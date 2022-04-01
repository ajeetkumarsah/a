import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class SaveButton extends StatelessWidget {
  const SaveButton(
      {Key? key,
      required this.onTap,
      this.title,
      this.color,
      this.color1,
      this.width})
      : super(key: key);
  final Function() onTap;
  final String? title;
  final Color? color;
  final Color? color1;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      padding: EdgeInsets.all(0),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color != null ? color! : lightGreen,
              color1 != null ? color1! : deepGreen
            ]),
            borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title != null ? '$title' : 'Save',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
