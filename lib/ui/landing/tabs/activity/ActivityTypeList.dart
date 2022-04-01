import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/ActivitySymbol.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/activity/widgets/activity_symbol.dart';

class ActivityTypeList extends StatefulWidget {
  @override
  _ActivityTypeListState createState() => _ActivityTypeListState();
}

class _ActivityTypeListState extends State<ActivityTypeList> {
  List<ActivitySymbol> activitySymbols = [];
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    activitySymbols = context.watch<Repository>().activitySymbols;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
          child: Text(
            'Activity Type*',
            style: textHelper.heading16,
          ),
        ),
        Container(
          width: double.infinity,
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectedIndex == index ? deepblue : grey,
                ),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    context
                        .read<Repository>()
                        .setActivitySymbol(activitySymbols[index]);
                  },
                  child: Center(
                    child: ActivitySymbolWidget(
                      activityName: activitySymbols[index].mobileIcon ?? '',
                    ),
                  ),
                ),
              );
            },
            itemCount: activitySymbols.length,
          ),
        ),
      ],
    );
  }
}
