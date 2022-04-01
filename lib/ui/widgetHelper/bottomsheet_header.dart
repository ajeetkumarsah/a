import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

Widget bottomSheetHeader(BuildContext context, String title) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 16.0, top: 0.0, right: 12.0, bottom: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Update $title',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: grey))
      ],
    ),
  );
}
