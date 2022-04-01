// ignore_for_file: unused_import

import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/DealCategory.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/models/DealModel.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import 'deal_details_page.dart';
import 'widget/deals_shimmer.dart';

class DealList extends StatelessWidget {
  List<DealCategory> _listData = [];
  BoardViewController boardViewController = new BoardViewController();
  bool isLoading = true;
  String pipelineId = "";

  @override
  Widget build(BuildContext context) {
    _listData = context.watch<Repository>().deals;
    isLoading = context.watch<Repository>().isDealLoading;
    pipelineId = context.watch<Repository>().selectedPipelineId;

    if (pipelineId.isEmpty) {
      getDealsWithDefaultId(context);
    }

    List<BoardList> _lists = [];
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(context, _listData[i]) as BoardList);
    }
    return isLoading
        ? DealsShimmer()
        : _lists.isEmpty
            ? emptyListHelper.getEmptyList(
                EmptyListHelper.dealsEmptyList, context)
            : BoardView(
                lists: _lists,
                boardViewController: boardViewController,
              );
  }

  getDealsWithDefaultId(BuildContext ctx) async {
    var data = await Repository.getInstance().getPipelines();
    if (data is List<PipelineModel> && (data).length > 0) {
      ctx.read<Repository>().getDeals(data[0].id);
    }
  }

  Widget buildBoardItem(BuildContext context, DealModel itemObject) {
    return BoardItem(
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState? state) {
        //Used to update our local item data
        var item = _listData[oldListIndex!].deals[oldItemIndex!];
        _listData[oldListIndex].deals.removeAt(oldItemIndex);
        _listData[listIndex!].deals.insert(itemIndex!, item);
        var stageId = _listData[listIndex].stageId;
        print("hello");
        updateDeal(context, pipelineId, stageId, item.id, item.order);
      },
      onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {
        Navigator.pushNamed(context, DealDetailsPage.routeName,
            arguments: {'item': itemObject}).then((value) {
          if (value == true) getDealsWithDefaultId(context);
        });
      },
      item: Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                itemObject.title,
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  itemObject.people.name != ''
                      ? Text(
                          "${itemObject.people.name} ",
                          style: Theme.of(context).textTheme.headline3,
                        )
                      : SizedBox(),
                  Text(
                    itemObject.company.name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              trailing: Text(
                "${itemObject.dealCurrency} ${itemObject.dealValue}",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            if (itemObject.tags.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: ListView.builder(
                    itemCount: itemObject.tags.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexColor.fromHex(
                                  itemObject.tags[index].colorCode),
                            ),
                            child: Text(
                              "${itemObject.tags[index].name}",
                              style: TextStyle(color: white, fontSize: 12),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }

  Widget _createBoardList(BuildContext context, DealCategory list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.deals.length; i++) {
      items.insert(i, buildBoardItem(context, list.deals[i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex!];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex!, list);
      },
      headerBackgroundColor: white,
      backgroundColor: white,
      header: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              gradient: LinearGradient(
                colors: [lightBlue, deepblue],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  list.stageName,
                  //textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: white,
                ),
              ],
            ),
          ),
        ),
      ],
      items: items,
    );
  }

  updateDeal(
    BuildContext context,
    String pipelineId,
    String stageId,
    String dealId,
    int order,
  ) async {
    Map<String, dynamic> params = {};
    params["pipelineId"] = pipelineId;
    params["stageId"] = stageId;
    params["dealId"] = dealId;
    params["order"] = order;

    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await Repository.getInstance().updateDeal(params);
    pr.hide().then((isHidden) {
      print(isHidden);
    });

    if (isSuccess) {
      // toastHelper.toastWithTitleAndColor("Successfully Created ", greenColor);
    } else {
      toastHelper.toastWithTitleAndColor("Failed to move! ", redColor);
    }
  }
}
