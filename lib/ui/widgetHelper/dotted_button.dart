import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class DottedButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function()? onTap;
  const DottedButton({Key? key, required this.title, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: deepblue,
      dashPattern: [6, 5],
      strokeWidth: 1.2,
      borderType: BorderType.RRect,
      radius: Radius.circular(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon != null ? icon : Icons.add, color: deepblue),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16, color: deepblue, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
