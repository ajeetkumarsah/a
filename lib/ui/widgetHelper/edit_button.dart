import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class EditButton extends StatelessWidget {
  final Function() onTap;
  final Widget? icon;
  final List<Color>? colors;
  const EditButton({Key? key, required this.onTap, this.icon, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: colors != null ? colors! : [lightBlue, deepblue],
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: icon != null
              ? icon
              : Icon(
                  Icons.edit,
                  color: white,
                  size: 16,
                ),
        ),
      ),
    );
  }
}
