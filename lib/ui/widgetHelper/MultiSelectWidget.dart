import 'package:flutter/material.dart';
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
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$title",
            style: Theme.of(context).textTheme.headline2,
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
  final Option option;
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
          ),
          Container(
            margin: EdgeInsets.only(
              left: 2,
            ),
            child: Text(
              widget.option.label,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}
