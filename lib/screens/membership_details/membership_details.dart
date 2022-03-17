import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/similar_gyms_nearby.dart';
import 'package:wtf_web/screens/gym_details/train_live.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../gym_details/choose_membership.dart';
import '../gym_details/mass_monster.dart';
import 'about_gym.dart';
import 'order_payment_details.dart';
import 'payment_mode.dart';
import 'payment_mode_title.dart';

class MembershipDetails extends StatefulWidget {
  static String routeName = '//MembershipDetails';

  const MembershipDetails({Key? key}) : super(key: key);

  @override
  _MembershipDetailsState createState() => _MembershipDetailsState();
}

class _MembershipDetailsState extends State<MembershipDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 200, maxHeight: 244),
          color: Constants.primaryColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back,
                          color: Constants.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      AdaptiveText(
                        text: 'Modify your order',
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Constants.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        if (!isDesktop()) gymCountSection(width),
        const AboutGym(),
        const OrderPaymentDetails(),
        const PaymentModeTitle(),
        const PaymentMode(),
        const BottomBar(),
      ],
    );
  }

  double getPadding() {
    return ResponsiveWidget.isSmallScreen(context) ? 16 : 100;
  }

  Widget gymCountSection(double width) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: !isDesktop() ? Colors.white12.withOpacity(0.1) : Colors.black),
      padding: EdgeInsets.all(!isDesktop() ? 30 : 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: !isDesktop()
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'GYMS', count: '200'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'TRAINERS', count: '110'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'DIETITIANS', count: '95'),
          SizedBox(
            width: width * 0.01,
          ),
        ],
      ),
    );
  }

  bool isDesktop() => Responsive.isDesktop(context);

  Widget gymCount({required String count, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdaptiveText(
          text: count,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        AdaptiveText(
          text: label,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
