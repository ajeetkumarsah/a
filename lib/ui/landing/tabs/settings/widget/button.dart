import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class PrivacyButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const PrivacyButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      // ignore: deprecated_member_use
      margin: EdgeInsets.only(top: 10),
      // ignore: deprecated_member_use
      child: FlatButton(
          disabledColor: white,
          height: MediaQuery.of(context).size.height * 0.06,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: white)),
          color: white,
          onPressed: onPressed,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: black,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: grey,
                )
              ],
            ),
          )),
    );
  }
}
