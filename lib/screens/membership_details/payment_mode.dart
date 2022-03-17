// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class PaymentMode extends StatefulWidget {
  const PaymentMode({Key? key}) : super(key: key);

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  int _selection = 0;

  selectTime(int? timeSelected) {
    setState(() {
      _selection = timeSelected!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(66, 60, 90, 90),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          Radio(
                            focusColor: Colors.white,
                            groupValue: _selection,
                            onChanged: selectTime,
                            value: 1,
                            activeColor: Constants.primaryColor,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Constants.white),
                          ),
                          AdaptiveText(
                            text: 'Full Payment',
                            minFontSize: 14,
                            align: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 108),
                      Wrap(
                        children: [
                          Radio(
                            focusColor: Colors.white,
                            groupValue: _selection,
                            onChanged: selectTime,
                            value: 2,
                            activeColor: Constants.primaryColor,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Constants.white),
                          ),
                          AdaptiveText(
                            text: 'Partial',
                            minFontSize: 14,
                            align: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Container(
                    height: 322,
                    decoration: BoxDecoration(
                        color: Constants.svgIconColor,
                        borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.fromLTRB(130, 12, 130, 69),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AdaptiveText(
                          text:
                              'Pay 2999 now and choose EMI date for your next payment',
                          minFontSize: 14,
                          align: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                        ),
                        SizedBox(height: 45),
                        selectEMIDateButton(title: 'Select 1st EMI date'),
                        SizedBox(height: 20),
                        selectEMIDateButton(title: 'Select 2nd EMI date'),
                      ],
                    ),
                  ),
                  Container(
                    height: 66,
                    // width: ,
                    margin: EdgeInsets.only(top: 64),
                    padding:
                        EdgeInsets.symmetric(horizontal: 144, vertical: 20),
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(47)),
                    child: AdaptiveText(
                      text: 'Proceed',
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget selectEMIDateButton({required String title}) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
          color: Constants.maroonLight,
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveText(
            text: title,
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
          SizedBox(width: 24),
          Image.asset('assets/membership_details/date.png')
        ],
      ),
    );
  }
}
