import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  String title;
  String content;
  String yes = 'Yes';
  String no = 'No';
  Function yesOnPressed;
  Function noOnPressed;
  BaseAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.yes,
    required this.no,
    required this.yesOnPressed,
    required this.noOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
      backgroundColor: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(yes),
          textColor: Colors.red[900],
          onPressed: () {
            yesOnPressed();
            
          },
        ),
        new FlatButton(
          child: Text(no),
          textColor: Colors.grey,
          onPressed: () {
            noOnPressed();
          },
        ),
      ],
    );
  }
}
