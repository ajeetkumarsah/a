import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessimplify/controller/color.dart';

// ignore: must_be_immutable
class ExpectedCloseDate extends StatefulWidget {
  Function onExpectedCloseDateClickedHandler;

  ExpectedCloseDate(
    this.onExpectedCloseDateClickedHandler,
  );

  @override
  _ExpectedCloseDateState createState() => _ExpectedCloseDateState();
}

class _ExpectedCloseDateState extends State<ExpectedCloseDate> {
  DateTime currentDate = DateTime.now();
  var f = DateFormat('dd MMM,yy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
                color: deepblue, borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Expected Close Date",
                  style: Theme.of(context).textTheme.button,
                ),
                f.format(currentDate) == f.format(DateTime.now())
                    ? Container()
                    : Text(
                        '=>  ' + f.format(currentDate),
                        style: Theme.of(context).textTheme.button,
                      ),
              ],
            ),
          ),
          // Container(
          //     margin: EdgeInsets.only(left: 20),
          //     child: f.format(currentDate) == f.format(DateTime.now())
          //         ? Container()
          //         : Text(
          //             f.format(currentDate),
          //             style: Theme.of(context).textTheme.headline2,
          //           ))
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        widget.onExpectedCloseDateClickedHandler(
            currentDate.millisecondsSinceEpoch);
      });
  }
}
