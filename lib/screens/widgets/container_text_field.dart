import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/utils/const.dart';

class ContainerTextField extends StatelessWidget {
  final String? hintText;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration = const InputDecoration();
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization = TextCapitalization.none;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign = TextAlign.start;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus = false;
  final bool readOnly = false;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final String obscuringCharacter = '•';
  final bool obscureText = false;
  final bool autocorrect = true;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions = true;
  final bool maxLengthEnforced = true;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines = 1;
  final int? minLines;
  final bool expands = false;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth = 2.0;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding = const EdgeInsets.all(20.0);
  final bool enableInteractiveSelection = true;
  final TextSelectionControls? selectionControls;
  final BoxConstraints? constraints;
  const ContainerTextField(
      {Key? key,
      this.hintText,
      this.width,
      this.height,
      this.color,
      this.margin,
      this.padding,
      this.controller,
      this.initialValue,
      this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.style,
      this.strutStyle,
      this.textDirection,
      this.textAlignVertical,
      this.toolbarOptions,
      this.showCursor,
      this.smartDashesType,
      this.smartQuotesType,
      this.maxLengthEnforcement,
      this.minLines,
      this.maxLength,
      this.onChanged,
      this.onTap,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.enabled,
      this.cursorHeight,
      this.cursorRadius,
      this.cursorColor,
      this.keyboardAppearance,
      this.constraints,
      this.selectionControls})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      width: width != null ? width : 420,
      height: height != null ? height : 58,
      margin: margin != null
          ? margin
          : EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: color != null ? color : Color(0xff424242).withOpacity(0.4),
      ),
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: style != null ? style : TextStyle(color: Constants.white),
        strutStyle: strutStyle,
        textDirection: textDirection,
        textAlignVertical: textAlignVertical,
        toolbarOptions: toolbarOptions,
        showCursor: showCursor,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        maxLengthEnforcement: maxLengthEnforcement,
        minLines: minLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        validator: validator,
        inputFormatters: inputFormatters,
        enabled: enabled,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        keyboardAppearance: keyboardAppearance,
        selectionControls: selectionControls,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Constants.white,
            ),
            hintText: hintText),
      ),
    );
  }
}
