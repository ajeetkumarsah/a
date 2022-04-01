import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class ToastHelper {
  toastWithTitleAndColor(String msg, Color? color) {
    return BotToast.showText(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        borderRadius: BorderRadius.circular(6.0),
        text: msg,
        textStyle: TextStyle(fontSize: 16, color: white),
        contentColor: color != null ? color : black);

    // Fluttertoast.showToast(
    //   msg: msg,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: color,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  }
}

ToastHelper toastHelper = new ToastHelper();
