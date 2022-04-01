import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';

class BeautyTextfield extends StatefulWidget {
  final BorderRadius cornerRadius;
  final double? width, height;
  final Color? backgroundColor, accentColor, prefixIconColor;
  final String? placeholder, fontFamily;
  final Icon? prefixIcon;
  final TextInputType? inputType;
  final EdgeInsets? margin;
  final Duration? duration;
  final VoidCallback? onClickSuffix;
  final bool? autofocus, autocorrect, enabled, obscureText, isShadow;
  final FocusNode? focusNode;
  final int? maxLength, minLines, maxLines;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final TextStyle? style, placeholderStyle;
  final Color? cursorColor;
  final String? initialValue;
  final String? errorText;
  final TextStyle? errorStyle;
  final void Function(String?)? onSaved;
  final bool? isRequired;
  final bool? countryCode;
  final void Function(CountryCode)? countryOnChanged;
  final String? initialSelection;
  final Key? key;
  const BeautyTextfield({
    required this.width,
    required this.height,
    this.prefixIcon,
    this.prefixIconColor,
    this.isRequired,
    required this.inputType,
    this.controller,
    this.duration = const Duration(milliseconds: 500),
    this.margin = const EdgeInsets.all(10),
    this.obscureText = false,
    this.backgroundColor = grey,
    this.cornerRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.style,
    this.accentColor = Colors.white,
    this.placeholder = "Placeholder",
    this.placeholderStyle,
    this.isShadow = true,
    this.onClickSuffix,
    this.fontFamily,
    this.autofocus = false,
    this.autocorrect = false,
    this.focusNode,
    this.enabled = true,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.validator,
    this.cursorColor,
    this.initialValue,
    this.errorText,
    this.errorStyle,
    this.onSaved,
    this.countryOnChanged,
    this.countryCode,
    this.initialSelection,
    this.key,
  })  : assert(width != null),
        assert(height != null),
        assert(inputType != null);

  @override
  _BeautyTextfieldState createState() => _BeautyTextfieldState();
}

class _BeautyTextfieldState extends State<BeautyTextfield> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          color: appColor.grey,
          borderRadius: BorderRadius.circular(4.0), //widget.cornerRadius,
          border: Border.all(
              color: widget.isRequired != null
                  ? widget.isRequired!
                      ? redColor
                      : bgColor!
                  : bgColor!,
              width: 1)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (widget.countryCode != null && widget.countryCode == true)
              CountryCodePicker(
                onChanged: widget.countryOnChanged,
                initialSelection: widget.initialSelection != null
                    ? widget.initialSelection
                    : '+91',
                favorite: ['+39', 'FR', '+91', 'en'],
                enabled: true,
                showDropDownButton: true,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                showFlagMain: false,
                alignLeft: false,
                textStyle: textHelper.defaultText,
                padding: EdgeInsets.only(left: 4.0),
              ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(
                    right: 10,
                    left: (widget.countryCode != null &&
                            widget.countryCode == true)
                        ? 0
                        : 20),
                child: TextFormField(
                  key: widget.key,
                  controller: widget.controller,
                  cursorWidth: 1,
                  onSaved: widget.onSaved,
                  obscureText: widget.obscureText!,
                  keyboardType: widget.inputType,
                  style: widget.style,
                  autofocus: widget.autofocus!,
                  autocorrect: widget.autocorrect!,
                  focusNode: widget.focusNode,
                  enabled: widget.enabled,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  validator: widget.validator,
                  initialValue: widget.initialValue,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      errorText: widget.errorText,
                      errorStyle: widget.errorStyle,
                      hintStyle: widget.placeholderStyle != null
                          ? widget.placeholderStyle
                          : textHelper.hintText,
                      hintText: widget.placeholder,
                      // isDense: true,
                      // contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      // hintTextDirection: TextDirection.ltr,

                      // suffixIcon: widget.suffix,

                      // suffix: widget.suffix,
                      // suffixText: 'required',
                      border: InputBorder.none),
                  cursorColor:
                      widget.cursorColor != null ? widget.cursorColor : black,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: widget.duration!,
    );
  }
}
