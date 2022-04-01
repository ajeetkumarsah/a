import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';

class CustomFormButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const CustomFormButton({Key? key, this.onTap, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
            color: appColor.grey, borderRadius: BorderRadius.circular(4.0)),
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textHelper.defaultText14,
            ),
          ],
        ),
      ),
    );
  }
}
