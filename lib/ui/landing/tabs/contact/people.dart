import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/contact/peopledetails.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/icon_button_helper.dart';
import 'package:salessimplify/util/utils.dart';
import 'package:provider/provider.dart';

class People extends StatefulWidget {
  final bool filter;
  static bool isAttched = false;
  static const _pageSize = 10;
  final PagingController<int, Leads> pagingController;
  People({Key? key, required this.filter, required this.pagingController})
      : super(key: key);
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  bool isPersonDeleted = false;

  @override
  void initState() {
    if (!People.isAttched) {
      widget.pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      People.isAttched = true;
    }

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await Repository.getInstance().getPeople(pageKey, People._pageSize);
      final isLastPage = newItems.length < People._pageSize;
      final filterNewItems =
          newItems.where((Leads i) => i.id == "Sahil").toList();
      if (isLastPage) {
        widget.pagingController
            .appendLastPage(widget.filter ? filterNewItems : newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController
            .appendPage(widget.filter ? filterNewItems : newItems, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    isPersonDeleted = context.watch<Repository>().isPersonDeleted;
    if (isPersonDeleted) {
      widget.pagingController.refresh();
      context.read<Repository>().invalidatePersonFlag();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: PagedListView<int, Leads>(
          pagingController: widget.pagingController,
          physics: AlwaysScrollableScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<Leads>(
            noItemsFoundIndicatorBuilder: (BuildContext bc) {
              return emptyListHelper.getEmptyList(
                  EmptyListHelper.contactList, context);
            },
            firstPageProgressIndicatorBuilder: (BuildContext bc) {
              return EmptyListShimmer(tab: 3);
            },
            itemBuilder: (context, item, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        topLeft: Radius.circular(12.0),
                      )),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context, PeopleDetails.ROUTE_LEAD_DETAILS,
                          arguments: {
                            "name": item.name,
                            "id": item.id,
                            "company":
                                item.company != null ? item.company!.name : ' ',
                            "email":
                                item.email!.isNotEmpty ? item.email![0] : '',
                          }).then((value) => {if (value == true) _onRefresh()});
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: white, width: 2.5),
                        borderRadius: BorderRadius.circular(12.0)),
                    contentPadding: EdgeInsets.all(0.0),
                    tileColor: Colors.white,
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: appColor.blue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Text(
                          item.name?.isEmpty == true
                              ? "NA"
                              : item.name!.characters.first.toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            color: appColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      item.name == null
                          ? "NA"
                          : item.name == ''
                              ? 'NA'
                              : '${item.name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                    subtitle: Text(
                      item.company?.name == null
                          ? item.email != null
                              ? item.email!.isNotEmpty
                                  ? item.email![0]
                                  : ''
                              : ''
                          : '${item.company!.name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: grey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        item.email!.isEmpty
                            ? Container()
                            : iconButtonHelper.emailIconButtonHelper(
                                onTap: () => Utils.launchUrl(
                                    "mailto:${item.email?[0] ?? ""}"),
                              ),
                        item.phone!.isEmpty
                            ? Container()
                            : item.phone![0].toString().length <= 9
                                ? Container()
                                : iconButtonHelper.callIconButtonHelper(
                                    onTap: () => Utils.launchUrl(
                                        "tel:${item.phone?[0] ?? 0}"),
                                  ),
                        item.phone!.isEmpty
                            ? Container()
                            : iconButtonHelper.wtpIconButtonHelper(
                                onTap: () => Utils.launchWtp(
                                  number: item.phone![0].toString(),
                                 
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(height: 0.5, color: Colors.grey[200]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      widget.pagingController.refresh();
    });
  }
}
