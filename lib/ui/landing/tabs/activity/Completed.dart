import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/app_helper.dart';
import 'package:salessimplify/models/ActivityData.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/tabs/activity/ActivityRow.dart';
import 'package:salessimplify/ui/login/LoginPage.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

import 'activity_details.dart';

class Completed extends StatefulWidget {
  final PagingController<int, ActivityData> pagingController;
  final PagingController<int, ActivityData> overduePagingController;
  final PagingController<int, ActivityData> upcomingpagingController;
  static bool isAttched = false;
  const Completed(
      {Key? key,
      required this.pagingController,
      required this.overduePagingController,
      required this.upcomingpagingController})
      : super(key: key);
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  static const _pageSize = 10;
  var f = DateFormat('d MMM, HH:mm');

  @override
  void initState() {
    initializeDateFormatting();
    if (!Completed.isAttched) {
      widget.pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      Completed.isAttched = true;
    }

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Repository.getInstance()
          .getActivityData("completed", pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        widget.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
      AppHelper().logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: PagedListView<int, ActivityData>(
          pagingController: widget.pagingController,
          physics: AlwaysScrollableScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<ActivityData>(
            firstPageProgressIndicatorBuilder: (BuildContext bc) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: EmptyListShimmer(tab: 1),
              );
            },
            noItemsFoundIndicatorBuilder: (BuildContext bc) {
              return emptyListHelper.getEmptyList(
                  EmptyListHelper.completedList, context);
            },
            itemBuilder: (context, item, index) {
              DateTime valEnd = DateTime.parse(item.schedule);
              DateTime date = DateTime.now();
              bool valDate = date.isBefore(valEnd);
              return Dismissible(
                key: Key('To Do'),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ActivityDetailsPage.routeName,
                        arguments: {
                          "name": item.name,
                          "id": item.id,
                          'schedule': item.schedule
                        }).then((value) => {if (value == true) _onRefresh()});
                  },
                  child: ActivityRow(
                    item: item,
                    isOverdue: !valDate,
                    index: index,
                  ),
                ),
                background: slideRightBackground(item),
                direction: DismissDirection.endToStart,
                confirmDismiss: (DismissDirection direction) async {
                  return markAsComingActivityItem(item);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      widget.pagingController.refresh();
      widget.overduePagingController.refresh();
      widget.upcomingpagingController.refresh();
    });
  }

  markAsComingActivityItem(item) {
    markAsUnDone(context, item);
    return toastHelper.toastWithTitleAndColor("Please wait...", black);
  }

  Widget slideRightBackground(ActivityData item) {
    DateTime valEnd = DateTime.parse(item.schedule);
    DateTime date = DateTime.now();
    bool valDate = date.isBefore(valEnd);
    return Container(
      color: valDate ? lightGreen : redColor,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(width: 20),
            Icon(
              Icons.done,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              valDate ? 'To Do' : 'Overdue',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 20),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  markAsUnDone(BuildContext context, ActivityData item) async {
    Map<String, String> params = {};
    params["id"] = item.id;

    var success = await context.read<Repository>().markAsUnDone(params);
    navigateToHome(context, success, item);
  }

  navigateToHome(BuildContext context, bool isSuccess, ActivityData item) {
    DateTime valEnd = DateTime.parse(item.schedule);
    DateTime date = DateTime.now();
    bool valDate = date.isBefore(valEnd);
    if (isSuccess) {
      toastHelper.toastWithTitleAndColor(
          valDate
              ? "Changed the activity as To Do"
              : 'Changed the activity as Overdue',
          greenColor);
    } else {
      toastHelper.toastWithTitleAndColor(
          "Failed to change the Activity as To Do", redColor);
    }
    widget.overduePagingController.refresh();
    widget.upcomingpagingController.refresh();
    widget.pagingController.refresh();
  }
}
