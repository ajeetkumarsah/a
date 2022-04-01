import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/roles_wise_userL_lst.dart';

class RoleWiseUserDropDown extends StatefulWidget {
  final List<RoleWiseUser> modes;

  final Function handler;
  RoleWiseUser dropdownValue;

  RoleWiseUserDropDown(this.modes, this.dropdownValue, this.handler);

  @override
  _RoleWiseUserDropDownState createState() => _RoleWiseUserDropDownState();
}

class _RoleWiseUserDropDownState extends State<RoleWiseUserDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: appColor.grey, borderRadius: BorderRadius.circular(4.0)),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0.0),
            child: DropdownButton<RoleWiseUser>(
              isExpanded: true,
              value: widget.dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: Theme.of(context).textTheme.caption,
              underline: Container(
                height: 1,
                color: Colors.transparent,
              ),
              onChanged: (RoleWiseUser? newValue) {
                setState(() {
                  widget.dropdownValue = newValue!;
                  widget.handler(newValue);
                });
              },
              items: widget.modes
                  .map<DropdownMenuItem<RoleWiseUser>>((RoleWiseUser value) {
                return DropdownMenuItem<RoleWiseUser>(
                  value: value,
                  child: Container(
                    child: Text(
                      value.email,
                      style: textHelper.defaultText,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.modes.clear();
  }
}
