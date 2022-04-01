import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widget/drop_down_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserDropDown extends StatelessWidget {
  DropDownModel? selectedModel;
  Function handler;
  List<DropDownModel> list = [];

  UserDropDown(
    this.selectedModel,
    this.handler,
  );

  @override
  Widget build(BuildContext context) {
    list = context.read<Repository>().profiles;
    if (list.length > 0 && selectedModel == null) {
      handler(list[0]);
    }
    return list.length > 0
        ? DropDownWidget(
            list,
            Icons.person,
            selectedModel ?? list[0],
            handler,
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
