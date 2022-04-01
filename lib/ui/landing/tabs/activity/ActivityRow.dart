import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/ActivityData.dart';
import 'package:salessimplify/ui/landing/tabs/activity/widgets/activity_symbol.dart';

class ActivityRow extends StatefulWidget {
  final ActivityData item;
  final bool isOverdue;
  final int index;
  const ActivityRow(
      {Key? key,
      required this.item,
      required this.isOverdue,
      required this.index})
      : super(key: key);

  @override
  _ActivityRowState createState() => _ActivityRowState();
}

class _ActivityRowState extends State<ActivityRow> {
  bool checkedValue = false;
  var f = DateFormat('d MMM,yyyy, hh:mm a');
  @override
  void initState() {
    super.initState();
  }

  getDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(date.year, date.month, date.day);
    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else if (aDate == tomorrow) {
      return 'Tomorrow';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
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
            shape: RoundedRectangleBorder(
                side: BorderSide(color: white, width: 2.5),
                borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            tileColor: Colors.white,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: widget.isOverdue
                    ? redColor.withOpacity(0.15)
                    : appColor.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: ActivitySymbolWidget(
                  activityName: widget.item.mobileIcon,
                  color: widget.isOverdue ? redColor : appColor.blue,
                ),
              ),
            ),
            title: Text(
              "${widget.item.name}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
            subtitle: Text(
              // ignore: unnecessary_null_comparison
              "${widget.item.schedule != null ? f.format(
                  DateTime.parse(widget.item.schedule).toLocal(),
                ) : "NA"} ",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: grey,
              ),
            ),
            trailing: getDay(DateTime.parse(widget.item.schedule).toLocal()) ==
                    ''
                ? SizedBox()
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: LinearGradient(
                          colors: [
                            widget.isOverdue ? redColor : blueColor,
                            widget.isOverdue ? redColor : deepblue
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                        ),
                        color: widget.isOverdue ? redColor : appColor.blue),
                    child: Text(
                        getDay(DateTime.parse(widget.item.schedule).toLocal()),
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w300,
                            fontSize: 11)),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Container(height: 0.5, color: Colors.grey[200]),
        ),
      ],
    );
  }

  // timeZone() {
  //   DateTime EastCoast = dateTimeToZone(zone: "EST", datetime: myDT);
  //   return;
  // }
}
