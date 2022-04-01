import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/contact/peopledetails.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/icon_button_helper.dart';
import 'package:salessimplify/util/utils.dart';
import 'package:provider/provider.dart';

import 'orgDetails.dart';

class Organization extends StatefulWidget {
  bool isLoaded = false;
  static bool isAttched = false;
  static const _pageSize = 10;
  final bool filter;
  final PagingController<int, Company> pagingController;
  Organization({Key? key, required this.filter, required this.pagingController})
      : super(key: key);
  @override
  _OrganizationState createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  @override
  void initState() {
    if (!Organization.isAttched) {
      widget.pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      Organization.isAttched = true;
    }

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Repository.getInstance()
          .getCompany(pageKey, Organization._pageSize);
      final isLastPage = newItems.length < Organization._pageSize;
      final filterNewItems =
          newItems.where((Company i) => i.name == "Sahil").toList();
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
    widget.isLoaded = context.watch<Repository>().isOtpSent;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: PagedListView<int, Company>(
          physics: AlwaysScrollableScrollPhysics(),
          pagingController: widget.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Company>(
            noItemsFoundIndicatorBuilder: (BuildContext bc) {
              return emptyListHelper.getEmptyList(
                  EmptyListHelper.organizationLIst, context);
            },
            firstPageProgressIndicatorBuilder: (BuildContext bc) {
              return EmptyListShimmer(tab: 1);
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
                      Navigator.pushNamed(context, OrgDetails.ROUTE_ORG_DETAILS,
                          arguments: {
                            "name": item.name,
                            "id": item.id,
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
                          item.name.isEmpty
                              ? "NA"
                              : item.name.characters.first.toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            color: appColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      item.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                    subtitle: item.website != null
                        ? Text(
                            item.website,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: grey,
                            ),
                          )
                        : null,
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        item.email.isEmpty
                            ? Container()
                            : iconButtonHelper.emailIconButtonHelper(
                                onTap: () =>
                                    Utils.launchUrl("mailto:${item.email[0]}"),
                              ),
                        item.phone.isEmpty
                            ? Container()
                            : item.phone[0].toString().length <= 9
                                ? Container()
                                : iconButtonHelper.callIconButtonHelper(
                                    onTap: () =>
                                        Utils.launchUrl("tel:${item.phone[0]}"),
                                  ),
                        item.phone.isEmpty
                            ? Container()
                            : iconButtonHelper.wtpIconButtonHelper(
                                onTap: () => Utils.launchWtp(
                                  number: item.phone[0].toString()
                                   
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(height: 0.5, color: Colors.grey[200]),
                ),
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
