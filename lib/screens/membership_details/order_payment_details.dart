// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OrderPaymentDetails extends StatelessWidget {
  const OrderPaymentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(48, 100, 80, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdaptiveText(
                    text: 'Order Details',
                    minFontSize: 14,
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: Constants.white,
                    ),
                  ),
                  Container(
                    height: 330,
                    width: 556,
                    margin: EdgeInsets.only(top: 33),
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Constants.cardBlackLight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        orderDetailsRow(
                            firstText: 'Booked at', secondText: 'Mass Monster'),
                        orderDetailsRow(
                            firstText: 'Workout', secondText: 'Gym Membership'),
                        orderDetailsRow(
                            firstText: 'Plan', secondText: 'WTF Active'),
                        orderDetailsRow(
                            firstText: 'WTF Active', secondText: '26 feb 2022'),
                        orderDetailsRow(
                            firstText: 'Subscrition end date',
                            secondText: '26 Mar 2022'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: 'Payment Details',
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                    Container(
                      height: 160,
                      // width: 570,
                      margin: EdgeInsets.only(top: 33),
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.cardBlackLight,
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            Constants.gradientGreenLight,
                            Constants.gradientGreen,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          paymentDetailsRow(
                              firstText: 'Plan Price', secondText: '₹ 2999'),
                          paymentDetailsRow(
                              firstText: 'GST ( 0%)', secondText: '₹ 0'),
                          Container(height: 1, color: Constants.white),
                          paymentDetailsRow(
                              firstText: 'Total Amount',
                              fontWeightFirst: FontWeight.w600,
                              secondText: '₹ 2999',
                              fontWeightSecond: FontWeight.w600),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      decoration: BoxDecoration(
                          color: Constants.cardBlackLight,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      height: 81,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Coupon code',
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AdaptiveText(
                                text: "Apply",
                                align: TextAlign.left,
                                minFontSize: 14,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
