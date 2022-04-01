import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/dropdownmodel.dart';

class DropDownWidget extends StatefulWidget {
  final List<DropDownModel> modes;
  final IconData prefixIcon;
  final Function handler;
  DropDownModel dropdownValue;

  DropDownWidget(this.modes, this.prefixIcon, this.dropdownValue, this.handler);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appColor.grey, borderRadius: BorderRadius.circular(4.0)),
      key: widget.key,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<DropDownModel>(
        isExpanded: true,
        value: widget.dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: textHelper.hintText,
        underline: Container(height: 1, color: Colors.transparent),
        onChanged: (DropDownModel? newValue) {
          setState(() {
            widget.dropdownValue = newValue!;
            widget.handler(newValue);
          });
        },
        items: widget.modes
            .map<DropdownMenuItem<DropDownModel>>((DropDownModel value) {
          return DropdownMenuItem<DropDownModel>(
            value: value,
            child: Container(
              child: Text(
                getValue(value) ?? 'No Title',
                style: textHelper.defaultText,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  getValue(DropDownModel model) {
    return model.name;
  }

  @override
  void dispose() {
    super.dispose();
    widget.modes.clear();
  }
}
