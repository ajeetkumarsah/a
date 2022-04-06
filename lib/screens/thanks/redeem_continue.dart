// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class RedeemOrContinue extends StatelessWidget {
  RedeemOrContinue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 60,
                      width: 360,
                      margin: EdgeInsets.only(top: 33),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Constants.cardBlackLight,
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
                          text: 'Redeem Coins',
                          minFontSize: 14,
                          align: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 360,
                    margin: EdgeInsets.only(top: 33),
                    decoration: kGradientBoxDecoration,
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: kInnerDecoration,
                      child: Center(
                        child: AdaptiveText(
                          text: 'Continue Exploring',
                          minFontSize: 14,
                          align: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                        ),
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

  final kInnerDecoration = BoxDecoration(
    color: Constants.black,
    borderRadius: BorderRadius.circular(6),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [Color(0xffDE0000), Color(0xff9A0E0E)]),
    border: Border.all(
      color: Constants.primaryColor,
    ),
    borderRadius: BorderRadius.circular(8),
  );
}
