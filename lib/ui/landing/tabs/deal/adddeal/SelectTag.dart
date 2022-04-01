import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/models/tag.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/widgetHelper/drop_down_widget.dart';
import 'package:shimmer/shimmer.dart';

class SelectTag extends StatelessWidget {
  String type;
  DropDownModel? selectedTag;
  List<DropDownModel> dropdowns = [];

  Function handler;
  SelectTag({
    Key? key,
    required this.handler,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.getInstance().getTags(type: type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data is List<Tag>) {
          List<Tag> tags = snapshot.data as List<Tag>;
          tags.forEach((element) {
            dropdowns.add(
              DropDownModel(element.name, element.id),
            );
          });

          if (selectedTag == null) {
            selectedTag = dropdowns[0];
          }
        }
        return snapshot.connectionState == ConnectionState.done
            ? DropDownWidget(
                dropdowns,
                Icons.tag,
                selectedTag!,
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
                      borderRadius: BorderRadius.circular(4.0)),
                ),
              );
      },
    );
  }
}
