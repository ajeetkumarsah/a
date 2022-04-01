import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widget/drop_down_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class Pipelines extends StatefulWidget {
  final Function function;
  Pipelines(this.function);

  @override
  _PipelinesState createState() => _PipelinesState();
}

class _PipelinesState extends State<Pipelines> {
  List<DropDownModel> modes = [];

  DropDownModel? selectedMode;
  List<PipelineModel> list = [];

  @override
  void initState() {
    super.initState();
    context.read<Repository>().getPipelines();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    list = context.watch<Repository>().pipelines;
    if (list.length > 0) {
      if (modes.length == 0) {
        list.forEach((element) {
          modes.add(
            DropDownModel(
              element.name,
              element.id,
            ),
          );
        });
      }
      if (selectedMode == null) {
        selectedMode = modes[0];
        widget.function(modes[0]);
        for (int i = 0; i < list.length; i++) {
          if (list[i].id == modes[0].value) {
            context.read<Repository>().setPipelineStages(list[i].stages);
            break;
          }
        }
      }
    }
    return modes.length > 0
        ? DropDownWidget(
            modes,
            Icons.list,
            selectedMode!,
            (DropDownModel model) {
              widget.function(model);
              selectedMode = model;
              for (int i = 0; i < list.length; i++) {
                if (list[i].id == model.value) {
                  context.read<Repository>().setPipelineStages(list[i].stages);
                  break;
                }
              }
            },
          )
        : Shimmer.fromColors(
            baseColor: grey.withOpacity(0.4),
            highlightColor: white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 50,
              decoration: BoxDecoration(
                color: appColor.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          );
  }
}
