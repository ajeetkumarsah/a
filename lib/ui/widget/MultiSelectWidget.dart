import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/Option.dart';

class MultiSelectWidget extends StatelessWidget {
  final List<Option> values;
  final String title;
  final Function handler;

  MultiSelectWidget({
    required this.values,
    required this.title,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$title",
            overflow: TextOverflow.ellipsis,
            style: textHelper.heading16,
          ),
        ),
        ...values
            .map(
              (e) => MyCheckbox(
                option: e,
                handler: handler,
              ),
            )
            .toList(),
      ],
    );
  }
}

class MyCheckbox extends StatefulWidget {
  final Option? option;
  final Function handler;

  MyCheckbox({
    required this.option,
    required this.handler,
  });

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            onChanged: (_) {
              setState(
                () {
                  isSelected = !isSelected;
                  widget.handler(widget.option, isSelected);
                },
              );
            },
            value: isSelected,
            checkColor: white,
            activeColor: deepblue,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 2, right: 10),
              child: Text(
                widget.option?.label ?? 'No Title',
                overflow: TextOverflow.ellipsis,
                style: textHelper.defaultText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
