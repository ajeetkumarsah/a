// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

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
                    // padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Constants.cardBlackLight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/thanks/cracker.gif',
                            height: 202, width: 202),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: AdaptiveText(
                            text: 'Your Order is successfull',
                            minFontSize: 14,
                            align: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/thanks/coin.png', height: 25),
                              SizedBox(width: 12),
                              AdaptiveText(
                                text: 'Coins Earned - 500',
                                minFontSize: 14,
                                align: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: Constants.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AdaptiveText(
                          text: 'Total Coins balance  - 13500',
                          minFontSize: 14,
                          align: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                        ),
                        Container(
                          height: 72,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 32),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                          ),
                          child: Center(
                            child: AdaptiveText(
                              text: 'Order Summary',
                              minFontSize: 14,
                              align: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                          ),
                        ),
                        summaryDetails()
                      ],
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

  Widget summaryDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Column(
        children: [
          bottomDetails(firstText: 'Booked at', secondText: 'Mass Monster'),
          bottomDetails(firstText: 'Workout', secondText: 'Gym Membership'),
          bottomDetails(firstText: 'Plan', secondText: 'WTF Active'),
          bottomDetails(
              firstText: 'Subscrition Start date', secondText: '26 feb 2022'),
          bottomDetails(
              firstText: 'Subscrition end date', secondText: '26 Mar 2022'),
        ],
      ),
    );
  }

  Widget bottomDetails(
      {required String firstText, required String secondText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdaptiveText(
            text: firstText,
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
          AdaptiveText(
            text: secondText,
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
        ],
      ),
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
