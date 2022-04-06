import 'package:flutter/material.dart';
import 'package:wtf_web/utils/const.dart';

class CustomDropDown extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? height, width;
  final BoxConstraints? constraints;
  final List<DropdownMenuItem<String>>? items;
  final Widget? hint;
  final TextStyle? style;
  final void Function(String?)? onChanged;
  final AlignmentGeometry? alignment;
  const CustomDropDown(
      {Key? key,
      this.padding,
      this.color,
      this.margin,
      this.height,
      this.width,
      this.constraints,
      required this.items,
      required this.onChanged,
      this.style,
      this.alignment,
      this.hint})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: widget.alignment,
        constraints: widget.constraints,
        width: widget.width != null ? widget.width : 374,
        height: widget.height != null ? widget.height : 58,
        margin: widget.margin != null
            ? widget.margin
            : EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: widget.color != null
                ? widget.color
                : Color(0xff424242).withOpacity(0.4)),
        padding: widget.padding != null
            ? widget.padding
            : EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: DropdownButton<String>(
            underline: SizedBox(),
            isExpanded: true,
            style: TextStyle(color: Colors.white),
            dropdownColor: Color(0xff424242),
            focusColor: Color(0xff424242).withOpacity(0.4),
            items: widget.items,
            hint: widget.hint,
            onChanged: widget.onChanged,
          ),
        ));
  }
}
