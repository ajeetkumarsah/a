import 'package:flutter/material.dart';
import 'package:wtf_web/screens/helper/responsive.dart';

class Constants {
  // Name
  static String appName = "Rhinestone";
  static Color mgBackground = const Color(0xffebf1fc);

  // Material Design Color
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color lightAccent = const Color(0xFF3B72FF);
  static Color lightBackground = const Color(0xfffcfcff);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = const Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;

  static Color grey = const Color(0xff707070);
  static Color textPrimary = const Color(0xFF486581);
  static Color textDark = const Color(0xFF102A43);

  static Color backgroundColor = const Color(0xFFF5F5F7);

  // Green
  static Color darkGreen = const Color(0xFF3ABD6F);
  static const Color lightGreen = const Color(0xFFA1ECBF);

  // Yellow
  static const Color darkYellow = const Color(0xFF3ABD6F);
  static Color lightYellow = const Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = const Color(0xFF3B72FF);
  static Color lightBlue = const Color(0xFF3EC6FF);

  // Orange
  static const Color darkOrange = Color(0xFFFFB74D);
  static const Color primaryColor = Color(0xFF900F12);
  static const Color gradientBlackLight = Color(0xFF0B0B0B);

  static const Color cardBlackLight = Color(0xFF2E2E2E);

  static const Color cardRedLight = Color(0xFFCB3838);
  static const Color redIconColor = Color(0xFFFF002E);
  static const Color green = Color(0xFF277B30);
  static const Color svgIconColor = Color(0xFF922224);
  static const Color gradientRedLight = Color(0xFFD60303);
  static const Color gradientRed = Color(0xFFE40000);
  static const Color gradientGreenLight = Color(0xFF6FAF81);
  static const Color gradientGreen = Color(0xFF598966);
  static const Color gradientBlueLight = Color(0xFF438373);
  static const Color gradientBlue = Color(0xFF3E74B4);
  static const Color blue = Color(0xFF2F7DC6);
  static const Color gradientVioletLight = Color(0xFFB9789B);
  static const Color gradientViolet = Color(0xFF89506D);
  static const Color gradientPrimary = Color(0xFF7C0000);
  static const Color secondaryColor = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color maroon = Color(0xff70181A);
  static const Color maroonLight = Color(0xffAF4949);
  static const Color textRedLight = Color(0xffFD8888);
  static const Color greyLight = Color(0xff5E5E5E);
  static const Color deepMaroon = Color(0xff5B0404);
  static const Color black = Color(0xFF000000);
  static const Color blackCardColor = Color(0xFF242424);
  static const Color grayOne = Color(0xFFEEEEEE);
  static const Color grayTwo = Color(0xFFDDDDDD);
  static const Color grayThree = Color(0xFFB1B1B1);
  static const Color flatPurple = Color(0xFF8E3DD1);
  static const Color flatDeepPurple = Color(0xFF462066);
  static const Color red = Color(0xffD21515);
  static const Color textLightGreen = Color(0xffBAFF83);
  static const Color textLightPink = Color(0xffB41F6D);
  static const Color textLightBlue = Color(0xff00D1FF);
  static const Color cardRed = Color(0xffBC1212);
  static const Color cardGreen = Color(0xff65B240);
  static const Color cardBrown = Color(0xffC5743A);
  static const Color cardBabyPink = Color(0xffB64F48);
  static double headerHeight = 228.5;
  static double paddingSide = 30.0;
  static Color secondBlack = Colors.black87;

  static BoxShadow shadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 6,
    offset: const Offset(0, 1), // changes position of shadow
  );

  static double getPadding(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context) ? 16 : 100;
  }
}

LinearGradient? gradient = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: <Color>[
    Constants.gradientRed,
    Constants.gradientPrimary,
  ],
);

class TextTheme {
  const TextTheme();

  static TextStyle regularText = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.white);

  static TextStyle regularTextBlack = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w200,
      fontSize: 16,
      height: 1,
      color: Colors.black);

  static TextStyle regularTextPurple = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Constants.flatDeepPurple);

  static TextStyle regularTextWhite = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white);

  static TextStyle bigTitleLight = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w300,
      fontSize: 26,
      color: Colors.black);

  static TextStyle bigTitleSemiBold = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w500,
      fontSize: 26,
      color: Colors.black);

  static TextStyle titleSemiBoldPurple = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Constants.flatPurple);

  static TextStyle titleRegularGray = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Constants.grayThree);

  static TextStyle titleRegularBlack = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.black);

  static TextStyle titleRegularOrange = const TextStyle(
      fontFamily: "pop",
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Constants.darkOrange);
}
