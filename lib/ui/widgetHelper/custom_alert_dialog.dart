import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class CustomAlertDialog {
  static Future<void> showAlertDialog(
      {required BuildContext context,
      required Widget title,
      required Widget content,
      Function()? onPressed,
      Widget? buttonText}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: grey, fontWeight: FontWeight.w300),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(color: redColor, fontWeight: FontWeight.w400),
      ),
      onPressed: onPressed,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 8.0),
      titlePadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
      title: title,
      content: content,
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
