import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wtf_web/screens/thanks/order_summary.dart';
import 'package:wtf_web/screens/thanks/redeem_continue.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/utils/const.dart';

class ThanksScreen extends StatefulWidget {
  static String routeName = '/ThanksScreen';

  const ThanksScreen({Key? key}) : super(key: key);

  @override
  _ThanksScreenState createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 80, maxHeight: 120),
          color: Constants.primaryColor,
        ),
        const OrderSummary(),
        const RedeemOrContinue(),
        const BottomBar(),
      ],
    );
  }
}
