import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;

  final List<Widget>? actions;
  const LogoAppBar({Key? key, required this.title, this.leading, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: new Size.fromHeight(70),
        child: Material(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blueColor, deepblue],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
              ),
            ),
            padding: EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
            child: title,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(70);
}
