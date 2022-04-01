import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:salessimplify/controller/color.dart';

class IconButtonHelper {
  wtpIconButtonHelper({Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.5),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: wtpColor,
        ),
        child: Icon(
          Boxicons.bxl_whatsapp,
          size: 19,
          color: white,
        ),
      ),
    );
  }

  callIconButtonHelper({Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(colors: [lightGreen, deepGreen]),
        ),
        child: Icon(
          Icons.call,
          size: 16,
          color: white,
        ),
      ),
    );
  }

  emailIconButtonHelper({Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(colors: [blueColor, deepblue]),
        ),
        child: Icon(
          Icons.email,
          size: 16,
          color: white,
        ),
      ),
    );
  }
}

IconButtonHelper iconButtonHelper = new IconButtonHelper();
