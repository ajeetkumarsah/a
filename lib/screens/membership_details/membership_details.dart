import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/membership_plan.dart';
import 'package:wtf_web/screens/membership_details/arguments/arguments.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import 'about_gym.dart';
import 'order_payment_details.dart';
import 'payment_mode.dart';
import 'payment_mode_title.dart';

class MembershipDetails extends StatefulWidget {
  static String routeName = '/membershipDetails';

  const MembershipDetails({Key? key}) : super(key: key);

  @override
  _MembershipDetailsState createState() => _MembershipDetailsState();
}

class _MembershipDetailsState extends State<MembershipDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final MemberShipDetailsArgument args =
        ModalRoute.of(context)!.settings.arguments as MemberShipDetailsArgument;
    return Scaffold(
      backgroundColor: Constants.black,
      body: SingleChildScrollView(
        child: Column(
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
            AboutGym(memberShipDetailsArgument: args),
            OrderPaymentDetails(gymId: '', memberShipDetailsArgument: args),
            const PaymentModeTitle(),
            const PaymentMode(),
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}
