import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wtf_web/utils/const.dart';

class CursorBlending extends StatefulWidget {
  @override
  _CursorBlendingState createState() => _CursorBlendingState();
}

class _CursorBlendingState extends State<CursorBlending>
    with SingleTickerProviderStateMixin {
  Offset? pointerOffset;
  AnimationController? pointerSizeController;
  Animation<double>? pointerAnimation;
  @override
  void initState() {
    pointerSizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    pointerAnimation = CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent:
            Tween<double>(begin: 0, end: 1).animate(pointerSizeController!));
    super.initState();
  }

  void togglePointerSize(bool hovering) async {
    if (hovering) {
      pointerSizeController!.forward();
    } else
      pointerSizeController!.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.none,
        onHover: (e) => setState(() => pointerOffset = e.localPosition),
        onExit: (e) => setState(() => pointerOffset = Offset.zero),
        child: Stack(
          children: [
            Row(
              children: [
                // Expanded(
                //   child: TextColumn(
                //     backgroundColor: Colors.black,
                //     textColor: Colors.white,
                //     onLinkHovered: togglePointerSize,
                //   ),
                // ),
                // Expanded(
                //   child: TextColumn(
                //     textColor: Constants.primaryColor,
                //     onLinkHovered: togglePointerSize,
                //   ),
                // ),
              ],
            ),
            if (pointerOffset != null) ...[
              AnimatedBuilder(
                  animation: pointerSizeController!,
                  builder: (context, snapshot) {
                    return AnimatedPointer(
                      pointerOffset: pointerOffset!,
                      radius: 45 + 100 * pointerAnimation!.value,
                    );
                  }),
              AnimatedPointer(
                pointerOffset: pointerOffset!,
                movementDuration: const Duration(milliseconds: 200),
                radius: 10,
              )
            ]
          ],
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    Key? key,
    required this.onLinkHovered,
    required this.child,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Function(bool) onLinkHovered;
  final Color textColor;
  final Color backgroundColor;
  final Widget child;
  TextStyle get _defaultTextStyle => TextStyle(color: textColor);
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      color: backgroundColor,
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHover: onLinkHovered,
        mouseCursor: SystemMouseCursors.none,
        onTap: () => null,
        child: Ink(
          child: child,
        ),
      ),
    );
  }
}

class AnimatedPointer extends StatelessWidget {
  const AnimatedPointer({
    Key? key,
    this.movementDuration = const Duration(milliseconds: 700),
    this.radius = 30,
    required this.pointerOffset,
  }) : super(key: key);
  final Duration movementDuration;
  final Offset pointerOffset;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: movementDuration,
      curve: Curves.easeOutExpo,
      top: pointerOffset.dy,
      left: pointerOffset.dx,
      child: CustomPaint(
        painter: Pointer(radius),
      ),
    );
  }
}

class Pointer extends CustomPainter {
  final double radius;

  Pointer(this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(0, 0),
      radius,
      Paint()
        ..color = Constants.redIconColor.withOpacity(0.4)
        ..blendMode = BlendMode.difference,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
