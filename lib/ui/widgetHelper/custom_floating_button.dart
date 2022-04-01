import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class CustomFloatingButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;

  const CustomFloatingButton({Key? key, required this.icon, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 52,
        height: 52,
        child: icon,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [lightBlue, deepblue],
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
