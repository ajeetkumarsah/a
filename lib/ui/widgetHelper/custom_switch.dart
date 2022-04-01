import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class CustomSwitchTiles extends StatelessWidget {
  final String title;
  final String label;
  final String subLabel;
  final bool isTitled;
  final bool isChecked;
  final Function(bool)? onChanged;
  CustomSwitchTiles(
      {required this.title,
      required this.label,
      required this.subLabel,
      this.isTitled = false,
      this.isChecked = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: [
          if (isTitled)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin:
                    EdgeInsets.only(left: 12, top: 18, bottom: 18, right: 12),
                child: RichText(
                  text: TextSpan(
                    text: (title != null) ? title + ' ' : "##--",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                    children: <TextSpan>[TextSpan(text: "")],
                  ),
                ),
              ),
            ),
          Container(
              color: white,
              child: SwitchListTile(
                title: Text(
                  label,
                ),
                subtitle: subLabel != null && subLabel.isNotEmpty
                    ? Text(subLabel)
                    : null,
                value: isChecked ? true : false,
                onChanged: onChanged,
                activeColor: deepblue,
                activeTrackColor: deepblue.withOpacity(0.4),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              )),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
