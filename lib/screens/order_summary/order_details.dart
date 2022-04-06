// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hover_effect/hover_effect.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OrderSummaryDetails extends StatelessWidget {
  const OrderSummaryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(48, 100, 48, 140),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-7',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AdaptiveText(
                        text: 'Order Summary',
                        minFontSize: 14,
                        align: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Constants.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 434,
                    width: 800,
                    margin: EdgeInsets.only(top: 33),
                    // padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Constants.cardBlackLight,
                    ),
                    child: OrderSummaryDetailsDetails(),
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-5',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Container(
                    height: 152,
                    width: 488,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff6FAF81),
                    ),
                    child: paymentDetails(),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 48,
                        width: 184,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Color(0xff2F2F2F),
                            border:
                                Border.all(width: 2, color: Constants.white)),
                        child: Center(
                          child: AdaptiveText(
                            text: 'Back',
                            minFontSize: 10,
                            align: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 184,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Color(0xff2F2F2F),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xff9A0E0E),
                              Color(0xffDE0000),
                            ],
                          ),
                        ),
                        child: Center(
                          child: AdaptiveText(
                            text: 'Proceed',
                            minFontSize: 10,
                            align: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget paymentDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        paymentDetailsRow(
          firstText: 'Addon Price',
          secondText: '-',
          fontWeightSecond: FontWeight.w600,
        ),
        paymentDetailsRow(
          firstText: 'GST (18 %)',
          secondText: '-',
          fontWeightSecond: FontWeight.w600,
        ),
        paymentDetailsRow(
          firstText: 'Total Amount',
          secondText: '₹0',
          fontWeightSecond: FontWeight.w600,
        ),
      ],
    );
  }

  Widget OrderSummaryDetailsDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bottomDetails(firstText: 'Booking at', secondText: 'WTF Friends Gym'),
          bottomDetails(firstText: 'Trainer name', secondText: 'Pooja Chamoli'),
          bottomDetails(
              firstText: 'Addon',
              secondText: 'Zumba,pilates,Aerobics( 1 sessions)'),
          bottomDetails(firstText: 'Plan', secondText: 'WTF Active'),
          bottomDetails(firstText: 'Begin Time', secondText: '08:00 PM'),
          bottomDetails(firstText: 'Beign date', secondText: 'Mar 31 2022'),
          bottomDetails(firstText: 'End date', secondText: 'Apr 1  2022'),
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

  Widget paymentDetailsRow({
    required String firstText,
    required String secondText,
    FontWeight? fontWeightFirst,
    FontWeight? fontWeightSecond,
  }) {
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
