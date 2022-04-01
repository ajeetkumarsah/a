import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final Function() onTap;
  final Color? color;
  final Color? color1;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.leadingIcon,
      this.color,
      this.color1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Flexible(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    color != null ? color! : lightGreen,
                    color1 != null ? color1! : deepGreen
                  ],
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Wrap(
                  //crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    leadingIcon != null
                        ? Icon(
                            leadingIcon,
                            color: white,
                          )
                        : SizedBox(),
                    Text(
                      text,
                      style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
