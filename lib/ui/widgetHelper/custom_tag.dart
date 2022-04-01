import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';

class CustomTag extends StatefulWidget {
  final List<Option> allTags;
  final List<Option> selectedTags;
  final void Function(bool)? onSelected;
  const CustomTag({
    Key? key,
    required this.allTags,
    required this.selectedTags,
    this.onSelected,
  }) : super(key: key);

  @override
  _CustomTagState createState() => _CustomTagState();
}

class _CustomTagState extends State<CustomTag> {
  late GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: companyPosition.toList(),
    );
  }

  Iterable<Widget> get companyPosition sync* {
    for (Option option in widget.allTags) {
      yield Padding(
        padding: const EdgeInsets.all(2.0),
        child: Transform(
          transform: new Matrix4.identity()..scale(0.8),
          child: FilterChip(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: getValue(option.colorCode)),
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: getValue(option.colorCode),
            label: Text('${option.label}', style: TextStyle(color: white)),
            selectedColor: getValue(option.colorCode),
            selected: widget.selectedTags.contains(option),
            checkmarkColor: white,
            elevation: 0,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  widget.selectedTags.add(option);
                } else {
                  widget.selectedTags.removeWhere((Option name) {
                    return name.value == option.value;
                  });
                }
                // print('~~~~~~~~~~~~new');
                // widget.selectedTags.forEach((element) {
                //   print(
                //       'Label : ${element.label}, colorCode: ${element.colorCode},name: ${element.name},value: ${element.value}');
                // });
              });
              if (widget.onSelected != null) {
                widget.onSelected!(selected);
              }
            },
          ),
        ),
      );
    }
  }

  getValue(String value) {
    if (value != null) {
      return HexColor.fromHex(value);
    } else {
      return Colors.grey;
    }
  }
}
