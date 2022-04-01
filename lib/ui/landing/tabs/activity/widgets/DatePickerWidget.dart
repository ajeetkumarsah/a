import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:shimmer/shimmer.dart';

class DatePickerWidget extends StatefulWidget {
  Function onDatePickerSelected;
  String? date;
  DatePickerWidget({
    required this.onDatePickerSelected,
    this.date,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  var f = DateFormat('d MMM,yyyy');
  DateTime currentDate = DateTime.now();
  DateTimeRange? selectedDateRange;
  String? showSelectedDate;
  // dateTomorrow() {
  //   final now = DateTime.now();
  //   final tomorrow = DateTime(now.year, now.month, now.day + 1);
  //   var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  //   var outputDate = outputFormat.format(tomorrow);
  //   return outputDate;
  // }

  // dateInHours(int hour) {
  //   final now = DateTime.now();
  //   final tomorrow =
  //       DateTime(now.year, now.month, now.day, now.hour + hour, now.minute);
  //   var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  //   var outputDate = outputFormat.format(tomorrow);
  //   return outputDate;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDateRangePickerWidget(context);
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              color: appColor.grey, borderRadius: BorderRadius.circular(4.0)),
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          selectedDateRange != null
                              ? " ${f.format(selectedDateRange!.start)} - ${f.format(selectedDateRange!.end)}"
                              : 'Select Date',
                          style: selectedDateRange != null
                              ? textHelper.defaultText
                              : textHelper.hintText,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }

  dateButton({required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: deepblue),
        child: Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  showDateRangePickerWidget(BuildContext context) async {
    DateTimeRange? data = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 100)),
    );
    setState(() {
      selectedDateRange = data;
      widget.onDatePickerSelected(data);
    });
    print(data);
  }
}
