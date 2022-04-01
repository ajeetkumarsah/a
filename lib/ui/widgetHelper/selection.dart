import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Selection extends StatefulWidget {
  final List<String> values;
  final String title;

  Selection({
    required this.values,
    required this.title,
  });

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  String selectedValue = "";

  @override
  void initState() {
    super.initState();
    selectedValue = widget.values[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.values.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(widget.values[index]),
            leading: Radio<String>(
              value: widget.values[index],
              groupValue: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
