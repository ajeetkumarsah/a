// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(48, 100, 48, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 789,
                    width: 1080,
                    margin: EdgeInsets.only(top: 33),
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Constants.cardBlackLight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget orderDetailsRow({
    required String firstText,
    required String secondText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdaptiveText(
          text: firstText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
        AdaptiveText(
          text: secondText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
      ],
    );
  }

  Widget paymentDetailsRow(
      {required String firstText,
      required String secondText,
      FontWeight? fontWeightFirst,
      FontWeight? fontWeightSecond}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdaptiveText(
          text: firstText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight:
                fontWeightFirst != null ? fontWeightFirst : FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
        AdaptiveText(
          text: secondText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight:
                fontWeightSecond != null ? fontWeightSecond : FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
      ],
    );
  }
}
