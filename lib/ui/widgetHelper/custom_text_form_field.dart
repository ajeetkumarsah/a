import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final Color hintColor;
  final Color suffixColor;
  final Color titleColor;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool requiredField;
  final TextInputType? keyboardType;
  final bool enableSuffix;
  final bool readOnly;
  final bool isEnable;
  final bool autoFocus;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? enableSuggestions;
  final bool? obscureText;
  final Widget? prefix;
  final String? labelText;
  final int? hintMaxLines;
  CustomTextFormField({
    this.hintText,
    this.hintColor = Colors.grey,
    this.initialValue,
    this.autoFocus = false,
    this.suffixColor = Colors.black,
    this.titleColor = Colors.black,
    this.readOnly = false,
    this.enableSuffix = false,
    this.requiredField = false,
    this.keyboardType,
    this.isEnable = true,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.validator,
    this.controller,
    this.enableSuggestions,
    this.obscureText,
    this.prefix,
    this.labelText,
    this.hintMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        initialValue: controller == null ? initialValue : null,
        validator: validator,
        controller: controller,
        enableSuggestions: enableSuggestions ?? false,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: prefix,
          isDense: true,
          hintText: hintText,
          alignLabelWithHint: true,
          labelText: labelText,
          labelStyle: TextStyle(color: grey, fontSize: 16),
          hintStyle: TextStyle(color: grey, fontSize: 14),
          contentPadding: EdgeInsets.all(15.0),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: deepblue.withOpacity(0.4), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey, width: 1.5)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          filled: true,
          fillColor: white,
          hintMaxLines: hintMaxLines,
        ),
        enabled: !isEnable ? false : true,
        readOnly: readOnly ? true : false,
        autofocus: autoFocus,
        keyboardType: keyboardType,
      ),
    );
  }
}
