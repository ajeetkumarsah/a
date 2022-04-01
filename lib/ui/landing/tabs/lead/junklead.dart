import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/lead/leaddetails.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/icon_button_helper.dart';
import 'package:salessimplify/util/utils.dart';
import 'package:provider/provider.dart';

class JunkLead extends StatefulWidget {
  final PagingController<int, Leads> activePagingController;
  final PagingController<int, Leads> junkPagingController;
  static bool isAttched = false;
  static const _pageSize = 10;

  const JunkLead(
      {Key? key,
      required this.activePagingController,
      required this.junkPagingController})
      : super(key: key);
  @override
  _JunkLeadState createState() => _JunkLeadState();
}

class _JunkLeadState extends State<JunkLead> {
  bool isConverted = false;

  @override
  void initState() {
    if (!JunkLead.isAttched) {
      widget.junkPagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      JunkLead.isAttched = true;
    }

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Repository.getInstance()
          .getLead(false, pageKey, JunkLead._pageSize);
      final isLastPage = newItems.length < JunkLead._pageSize;

      if (isLastPage) {
        widget.junkPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.junkPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      widget.junkPagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    isConverted = context.watch<Repository>().isJunkLeadConverted;
    if (isConverted) {
      widget.junkPagingController.refresh();
      context.read<Repository>().invalidateJunkFlag();
    }

    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: PagedListView<int, Leads>(
          pagingController: widget.junkPagingController,
          physics: AlwaysScrollableScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<Leads>(
            noItemsFoundIndicatorBuilder: (BuildContext bc) {
              return emptyListHelper.getEmptyList(
                  EmptyListHelper.junkLeadsList, context);
            },
            firstPageProgressIndicatorBuilder: (BuildContext bc) {
              return EmptyListShimmer(tab: 2);
            },
            itemBuilder: (context, item, index) {
              return Column(
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
                                context, LeadsDetails.ROUTE_LEAD_DETAILS,
                                arguments: {
                              "name": item.name,
                              "id": item.id,
                              "type": "junk",
                              "email": item.email![0],
                              'company': item.company ??
                                  CompanyNewModel(id: '', name: ''),
                              'companyId': item.company?.id ?? '',
                            })
                            .then((value) => {if (value == true) _onRefresh()});
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
                            item.name != null
                                ? item.name != ''
                                    ? item.name?.characters.first
                                            .toUpperCase() ??
                                        ""
                                    : 'NA'
                                : 'NA',
                            style: TextStyle(
                              fontSize: 24,
                              color: appColor.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: black,
                        ),
                      ),
                      subtitle: item.company?.name != null
                          ? Text(
                              item.company!.name,
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
                                      number: item.phone![0].toString())),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(height: 0.5, color: Colors.grey[200]),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      widget.activePagingController.refresh();
      widget.junkPagingController.refresh();
    });
  }
}
