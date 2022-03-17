// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class PaymentModeTitle extends StatelessWidget {
  const PaymentModeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Constants.cardBlackLight),
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: AdaptiveText(
            text: 'Payment Mode',
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
        ),
      ],
    );
  }
}
