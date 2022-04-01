import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final Color iconColor;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String>? onTextChange;

  FormTextField({
    required this.hintText,
    required this.iconData,
    required this.iconColor,
    this.validator,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
        contentPadding: EdgeInsets.only(top: 20),
        // add padding to adjust text
        isDense: true,
        hintText: hintText,
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 0),
          // add padding to adjust icon
          child: Icon(
            iconData,
            color: iconColor,
            size: 24,
          ),
        ),
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
      onChanged: onTextChange != null ? onTextChange : (String? value) {},
    );
  }
}
