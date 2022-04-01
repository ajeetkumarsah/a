import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class StageList extends StatefulWidget {
  int selectedPos = 0;
  Function stageSelectHandler;

  StageList(
    this.stageSelectHandler,
  );

  @override
  _StageListState createState() => _StageListState();
}

class _StageListState extends State<StageList> {
  List<Stage> list = [];
  int pos = 0;

  @override
  Widget build(BuildContext context) {
    pos = 0;
    list = context.watch<Repository>().stages;

    if (list.length > 0) {
      widget.stageSelectHandler(list[widget.selectedPos]);
    }
    return list.length == 0
        ? Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: grey.withOpacity(0.4),
                  highlightColor: white,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: appColor.grey,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            children: [
              ...list
                  .map((e) => StageTile(
                        tilePos: pos,
                        name: e.name,
                        handler: onTileClicked,
                        isSelected: pos++ <= widget.selectedPos,
                        listLength: list.length,
                      ))
                  .toList(),
            ],
          );
  }

  onTileClicked(int position) {
    setState(() {
      widget.selectedPos = position;
      widget.stageSelectHandler(list[position]);
    });
  }
}

class StageTile extends StatefulWidget {
  final String name;
  bool isSelected = true;
  int tilePos, listLength;
  Function handler;

  StageTile({
    required this.name,
    required this.tilePos,
    required this.handler,
    required this.isSelected,
    required this.listLength,
  });

  @override
  _StageTileState createState() => _StageTileState();
}

class _StageTileState extends State<StageTile> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          widget.handler(widget.tilePos);
        },
        child: widget.tilePos == widget.listLength - 1
            ? Label(
                triangleHeight: 25.0,
                edge: Edge.LEFT,
                child: Container(
                  margin: EdgeInsets.only(right: 0.0),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: (widget.isSelected || widget.tilePos == 0)
                        ? lightgreen
                        : grey,
                  ),
                  child: SizedBox(height: 20),
                ),
              )
            : widget.tilePos == 0
                ? Point(
                    triangleHeight: 25.0,
                    edge: Edge.RIGHT,
                    child: Container(
                      margin: EdgeInsets.only(right: 0.0),
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: (widget.isSelected || widget.tilePos == 0)
                            ? lightgreen
                            : grey,
                      ),
                      child: SizedBox(height: 20),
                    ),
                  )
                : Chevron(
                    triangleHeight: 30.0,
                    edge: Edge.RIGHT,
                    child: Container(
                      margin: EdgeInsets.only(right: 0.0),
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: (widget.isSelected || widget.tilePos == 0)
                            ? lightgreen
                            : grey,
                      ),
                      child: SizedBox(height: 20),
                    ),
                  ),
      ),
    );
  }
}
