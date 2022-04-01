import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/app_helper.dart';
import 'package:salessimplify/models/ActivityData.dart';
import 'package:salessimplify/models/activity_lost_reasons.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/tabs/activity/ActivityRow.dart';
import 'package:salessimplify/ui/landing/tabs/activity/activity_details.dart';
import 'package:salessimplify/ui/login/LoginPage.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/save_button.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

import 'CreateActivity.dart';

class Overdue extends StatefulWidget {
  static const _pageSize = 10;
  static bool isAttched = false;
  final PagingController<int, ActivityData> overduePagingController;
  final PagingController<int, ActivityData> completedpagingController;
  final PagingController<int, ActivityData> upcomingpagingController;

  Overdue({
    Key? key,
    required this.overduePagingController,
    required this.completedpagingController,
    required this.upcomingpagingController,
  }) : super(key: key);

  @override
  _OverdueState createState() => _OverdueState();
}

class _OverdueState extends State<Overdue> {
  List<String> _reasons = [];
  String _selectedReason = '', comment = '';
  bool _isSelected = false, isActivityLostReasonSetting = false;
  @override
  void initState() {
    initializeDateFormatting();
    if (!Overdue.isAttched) {
      widget.overduePagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      Overdue.isAttched = true;
    }

    super.initState();
    setLostReasonFlag();
    setLostReasons();
  }

  setLostReasonFlag() async {
    isActivityLostReasonSetting =
        await SessionManager.getInstance().activityLostReasonSetting();
    print("");
  }

  setLostReasons() async {
    List<ActivityLostReasons> data =
        await Repository.getInstance().getActivityLostReasons();
    data.forEach((element) {
      _reasons.add(element.reason);
    });
    _selectedReason = _reasons[0];
    print("");
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Repository.getInstance()
          .getActivityData("overdue", pageKey, Overdue._pageSize);
      final isLastPage = newItems.length < Overdue._pageSize;

      if (isLastPage) {
        widget.overduePagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.overduePagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      widget.overduePagingController.error = error;
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
            pagingController: widget.overduePagingController,
            physics: AlwaysScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<ActivityData>(
                noItemsFoundIndicatorBuilder: (BuildContext bc) {
                  return emptyListHelper.getEmptyList(
                      EmptyListHelper.overDueList, context);
                },
                firstPageProgressIndicatorBuilder: (BuildContext bc) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: EmptyListShimmer(tab: 1),
                  );
                },
                itemBuilder: (context, item, index) => Dismissible(
                      key: Key('Done'),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,
                              ActivityDetailsPage.routeName, arguments: {
                            "name": item.name,
                            "id": item.id,
                            'schedule': item.schedule
                          }).then((value) => {if (value == true) _onRefresh()});
                        },
                        child: ActivityRow(
                          item: item,
                          isOverdue: true,
                          index: index,
                        ),
                      ),
                      background: slideRightBackground(),
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (DismissDirection direction) async {
                        return isActivityLostReasonSetting
                            ? showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Container(
                                        decoration: new BoxDecoration(
                                            color: white,
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(8.0),
                                                topRight: const Radius.circular(
                                                    8.0))),
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: new BoxDecoration(
                                                color: white,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16.0,
                                                            top: 0.0,
                                                            right: 12.0,
                                                            bottom: 6.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('Mark as Done',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        IconButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0,
                                                            bottom: 10),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18.0),
                                                      child: Text(
                                                        'Activity Outcome',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: appColor.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12.0),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: DropdownButton(
                                                            isExpanded: true,
                                                            underline:
                                                                SizedBox(),
                                                            hint: Text(
                                                                'Select lost reason'),
                                                            value:
                                                                _selectedReason,
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                _selectedReason =
                                                                    newValue!;
                                                              });
                                                            },
                                                            items: _reasons
                                                                .map((reason) {
                                                              return DropdownMenuItem(
                                                                child: new Text(
                                                                    reason),
                                                                value: reason,
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  GestureDetector(
                                                    onTap: _radio,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        SizedBox(width: 4.0),
                                                        Checkbox(
                                                          value: _isSelected,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isSelected =
                                                                  !_isSelected;
                                                            });
                                                          },
                                                          checkColor: white,
                                                          activeColor: deepblue,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Text(
                                                            "Schedule next activity",
                                                            style: TextStyle(
                                                                fontSize: 15))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: _buildTextField(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 16,
                                                right: 16,
                                              ),
                                              child: SaveButton(
                                                onTap: () {
                                                  markAsDone(
                                                      context, item, comment);
                                                  Navigator.pop(context);
                                                  _onRefresh().then((value) {
                                                    if (_isSelected) {
                                                      Navigator.pushNamed(
                                                        context,
                                                        CreateActivity
                                                            .ROUTE_CREATE_ACTIVITY,
                                                      ).then((value) => {
                                                            widget
                                                                .upcomingpagingController
                                                                .refresh(),
                                                            widget
                                                                .overduePagingController
                                                                .refresh(),
                                                          });
                                                    }
                                                  });
                                                },
                                                title: 'Mark As Done',
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              )
                            : markAsDoneActivityItem(item);
                      },
                    ))),
      ),
    );
  }

  markAsDoneActivityItem(item) {
    markAsDone(context, item, comment);
    return toastHelper.toastWithTitleAndColor("Please wait...", black);
  }

  Widget radioButton(bool isSelected) => Container(
        width: 18.0,
        height: 18.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: isSelected ? deepblue : grey),
            color: isSelected ? deepblue : grey),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? deepblue : grey),
              )
            : Container(),
      );

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget _buildTextField() {
    final maxLines = 5;

    return Container(
      height: maxLines * 24.0,
      decoration: BoxDecoration(
          color: appColor.grey, borderRadius: BorderRadius.circular(4.0)),
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: "Comments",
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          fillColor: appColor.grey,
          filled: true,
        ),
        onChanged: (String s) {
          setState(() {
            comment = s;
          });
        },
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: white,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20),
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(0),
              child: Lottie.asset(
                'assets/icons/done.json',
                repeat: true,
                reverse: true,
                animate: true,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Done',
              style: TextStyle(
                color: deepblue,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 20),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  markAsDone(BuildContext context, ActivityData item, String comment) async {
    Map<String, String> params = {};
    params["id"] = item.id;
    params["reasonId"] = item.activityType.id;
    params["comment"] = comment;

    var success = await context.read<Repository>().markAsDone(params);
    navigateToHome(context, success);
  }

  navigateToHome(BuildContext context, bool isSuccess) {
    if (isSuccess) {
      toastHelper.toastWithTitleAndColor(
          "Successfully changed the activity as Done", greenColor);
    } else {
      toastHelper.toastWithTitleAndColor(
          "Failed to change the Activity as Done", redColor);
    }
    widget.overduePagingController.refresh();
    widget.completedpagingController.refresh();
  }

  Future<void> _onRefresh() async {
    widget.overduePagingController.refresh();
    widget.upcomingpagingController.refresh();
  }
}
