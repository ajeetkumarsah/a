import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/utils/const.dart';

class AlertFlash {
  void showMessage(
      {required String message, required BuildContext context, Widget? icon}) {
    // if (!mounted) return;
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (_, controller) {
        return Flash(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.6,
              top: 20,
              right: 20),
          // alignment: Alignment.topRight,
          backgroundColor: Constants.black,
          borderRadius: BorderRadius.circular(4),
          controller: controller,

          position: FlashPosition.top,
          behavior: FlashBehavior.fixed,
          child: FlashBar(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            icon: icon != null ? icon : Image.asset('assets/logo.png'),
            content: Text(
              message,
              style: GoogleFonts.montserrat(
                color: Constants.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        );
      },
    );
  }

  void showBasicsFlash(
      {required String message,
      required BuildContext context,
      Widget? icon,
      Color? backgroundColor,
      Color? textColor}) {
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.6,
              top: 20,
              right: 20),
          backgroundColor:
              backgroundColor != null ? backgroundColor : Constants.black,
          borderRadius: BorderRadius.circular(3),
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            icon: icon != null
                ? icon
                : Image.asset('assets/logo.png',
                    color: textColor != null ? textColor : null),
            content: Text(
              message,
              style: GoogleFonts.montserrat(
                color: textColor != null ? textColor : Constants.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        );
      },
    );
  }

  void showDialogFlash(
      {bool persistent = true, required BuildContext context}) {
    context.showFlashDialog(
        constraints: BoxConstraints(maxWidth: 300),
        persistent: persistent,
        title: Text('Flash Dialog'),
        content: Text(
            '⚡️A highly customizable, powerful and easy-to-use alerting library for Flutter.'),
        negativeActionBuilder: (context, controller, _) {
          return SizedBox();
        },
        positiveActionBuilder: (context, controller, _) {
          return SizedBox();
        });
  }
}