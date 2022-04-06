import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wtf_web/screens/order_summary/order_details.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/utils/const.dart';
import 'dart:html' as html;

class OrderSummary extends StatefulWidget {
  static String routeName = '/OrderSummary';

  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // return CursorBlending();
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 80, maxHeight: 120),
              color: Constants.primaryColor,
            ),
            const OrderSummaryDetails(),
            // RedeemOrContinue(),
            const BottomBar(
              color: Color(0xff292929),
            ),
          ],
        ),
      ],
    );
  }
}
