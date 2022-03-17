import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final double minFontSize;
  final int maxLines;
  final TextAlign align;
  final TextStyle style;

  AdaptiveText(
      {required this.text,
      Key? key,
      this.maxLines = 1,
      this.style = const TextStyle(color: Colors.white, fontSize: 16),
      this.align = TextAlign.start,
      this.minFontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      textAlign: align,
      minFontSize: minFontSize,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
