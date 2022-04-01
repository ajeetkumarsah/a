import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class FormTextField extends StatelessWidget {
  final String? hintText;
  final IconData? iconData;
  final Color? iconColor;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String>? onTextChange;
  final Widget? suffix;
  final Widget? suffixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final String? labelText;
  String? initialValue;
  FormTextField({
    this.hintText,
    this.iconData,
    this.iconColor,
    this.validator,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.onTextChange,
    this.suffix,
    this.suffixIcon,
    this.initialValue,
    this.enabledBorder,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        enabledBorder: enabledBorder != null
            ? enabledBorder
            : OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
        border: border != null
            ? border
            : OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
        errorBorder: errorBorder != null
            ? errorBorder
            : OutlineInputBorder(
                borderSide: BorderSide(color: redColor, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
        focusedBorder: focusedBorder != null
            ? focusedBorder
            : OutlineInputBorder(
                borderSide: BorderSide(color: lightBlue, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
        focusedErrorBorder: focusedErrorBorder != null
            ? focusedErrorBorder
            : OutlineInputBorder(
                borderSide: BorderSide(color: redColor, width: 1),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),

        contentPadding: EdgeInsets.only(top: 20),
        // add padding to adjust text
        isDense: true,
        hintText: hintText,
        labelText: labelText,
        suffix: suffix,
        suffixIcon: suffixIcon,

        prefixIcon: iconData != null
            ? Padding(
                padding: EdgeInsets.only(top: 0),
                // add padding to adjust icon
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 20,
                ),
              )
            : null,
      ),
      validator: validator != null
          ? validator
          : (String? value) {
              if (value!.isEmpty) {
                return "Invalid input";
              }
              return null;
            },
      controller: controller,
      initialValue: initialValue,
      onChanged: onTextChange != null ? onTextChange : (String? value) {},
    );
  }
}
