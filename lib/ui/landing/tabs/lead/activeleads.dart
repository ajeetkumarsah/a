import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/app_helper.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/tabs/lead/leaddetails.dart';
import 'package:salessimplify/ui/login/LoginPage.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/icon_button_helper.dart';
import 'package:salessimplify/util/utils.dart';
import 'package:provider/provider.dart';

class ActiveLeads extends StatefulWidget {
  static bool isAttched = false;
  static const _pageSize = 10;
  final PagingController<int, Leads> activePagingController;
  final PagingController<int, Leads> junkPagingController;

  const ActiveLeads(
      {Key? key,
      required this.activePagingController,
      required this.junkPagingController})
      : super(key: key);
  @override
  _ActiveLeadesState createState() => _ActiveLeadesState();
}

class _ActiveLeadesState extends State<ActiveLeads> {
  BuildContext? _context;
  bool isConverted = false;
  List<Option> option = [];

  @override
  void initState() {
    if (!ActiveLeads.isAttched) {
      widget.activePagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      ActiveLeads.isAttched = true;
    }
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Repository.getInstance()
          .getLead(true, pageKey, ActiveLeads._pageSize);
      final isLastPage = newItems.length < ActiveLeads._pageSize;
      var id = await SessionManager.getInstance().getId();

      if (isLastPage) {
        widget.activePagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.activePagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      widget.activePagingController.error = error;
      AppHelper().logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    isConverted = context.watch<Repository>().isActiveLeadConverted;
    if (isConverted) {
      widget.activePagingController.refresh();
      context.read<Repository>().invalidateLeadFlag();
    }
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: PagedListView<int, Leads>(
          pagingController: widget.activePagingController,
          physics: AlwaysScrollableScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<Leads>(
            noItemsFoundIndicatorBuilder: (BuildContext bc) {
              return emptyListHelper.getEmptyList(
                  EmptyListHelper.activeLeadsList, context);
            },
            firstPageProgressIndicatorBuilder: (BuildContext bc) {
              return EmptyListShimmer(tab: 2);
            },
            itemBuilder: (context, item, index) {
              item.tags.forEach((element) {
                option.add(
                  Option(
                      colorCode: element.colorCode,
                      label: element.name,
                      value: element.id,
                      name: element.name),
                );
              });
              return Column(
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
                                context, LeadsDetails.ROUTE_LEAD_DETAILS,
                                arguments: {
                              "name": item.name ?? '',
                              "id": item.id,
                              "type": "active",
                              'company': item.company ??
                                  CompanyNewModel(id: '', name: ''),
                              "email":
                                  item.email!.isNotEmpty ? item.email![0] : "",
                              'phone': item.phone!.isNotEmpty
                                  ? item.phone![0].toString()
                                  : '',
                            })
                            .then((value) => {if (value == true) _onRefresh()});
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: white, width: 2.5),
                          borderRadius: BorderRadius.circular(12.0)),
                      contentPadding: EdgeInsets.all(0.0),
                      tileColor: white,
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: appColor.blue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: Text(
                            (item.name ?? '').isEmpty
                                ? "NA"
                                : item.name?.characters.first.toUpperCase() ??
                                    '',
                            style: TextStyle(
                              fontSize: 24,
                              color: appColor.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item.name ?? "NA",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: black,
                        ),
                      ),
                      subtitle: Text(
                        item.company?.name != null
                            ? item.company!.name
                            : item.email!.isNotEmpty
                                ? item.email![0].toString()
                                : '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: grey,
                        ),
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          item.email!.isEmpty
                              ? SizedBox()
                              : iconButtonHelper.emailIconButtonHelper(
                                  onTap: () => Utils.launchUrl(
                                      "mailto:${item.email?[0] ?? ""}"),
                                ),
                          item.phone!.isEmpty
                              ? SizedBox()
                              : item.phone![0].toString().length <= 9
                                  ? SizedBox()
                                  : iconButtonHelper.callIconButtonHelper(
                                      onTap: () => Utils.launchUrl(
                                          "tel:${item.phone?[0] ?? 0}"),
                                    ),
                          item.phone!.isEmpty
                              ? SizedBox()
                              : iconButtonHelper.wtpIconButtonHelper(
                                  onTap: () => Utils.launchWtp(
                                    number: item.phone![0].toString()
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 0.5, color: Colors.grey[200])
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
