import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final bool isLeft;
  final Widget? child;
  const CustomAnimatedSwitcher(
      {Key? key, this.isLeft = false, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      key: ValueKey(isLeft),
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final inAnimation =
            Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);
        final outAnimation =
            Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);

        if (child.key == ValueKey(isLeft)) {
          return ClipRect(
            child: SlideTransition(
              textDirection: TextDirection.ltr,
              position: inAnimation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          );
        } else {
          return ClipRect(
            child: SlideTransition(
              position: outAnimation,
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          );
        }
      },
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return currentChild!;
      },
      child: child,
    );
  }
}
