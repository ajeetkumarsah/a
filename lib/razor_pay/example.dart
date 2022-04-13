import 'dart:html';
import 'dart:ui' as ui;
//conditional import
import 'package:wtf_web/screens/thanks/thanks.dart';
import 'package:wtf_web/screens/widgets/alert_flash.dart';
import 'package:wtf_web/utils/const.dart';

import 'ui_fake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

class RazorPayWeb extends StatelessWidget {
  static String routeName = '/razorPayWeb';
  @override
  Widget build(BuildContext context) {
    //register view factory
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
//Event Listener
      window.onMessage.forEach((element) {
        print('================>element:' + element.data.toString());
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (element.data == 'SUCCESS') {
          AlertFlash().showBasicsFlash(
              context: context, message: 'Payment successful.');
          Navigator.pop(context, true);
          // Navigator.pushNamed(context, ThanksScreen.routeName);
          print('PAYMENT SUCCESSFULL=============>');
        } else if (element.data == 'MODAL_ERROR') {
          AlertFlash().showBasicsFlash(
              context: context, message: 'Something went wrong.');
          Navigator.pop(context);
          print('Error event called ============>');
        } else if (element.data == "MODAL_PROGRESS") {
          print('Progress event called ============>');
        } else if (element.data == "MODAL_ONLINE") {
          print('Online event called ============>');
        } else if (element.data == "MODAL_OFFLINE") {
          print('Offline event called ============>');
        } else if (element.data == "MODAL_DISMISS") {
          Navigator.pop(context);
          AlertFlash()
              .showBasicsFlash(context: context, message: 'Payment failed!.');
          print('Offline event called ============>');
        }
      });

      // element.requestFullscreen();
      element.allowFullscreen;
      element.src = 'assets/html/payment.html';
      element.style.border = 'none';
      return element;
    });
    return Scaffold(
      backgroundColor: Constants.black,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Constants.black,
            child: HtmlElementView(viewType: 'rzp-html'),
          );
        },
      ),
    );
  }
}
