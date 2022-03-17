// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class MembershipAboutGym extends StatelessWidget {
  const MembershipAboutGym({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(56, 62, 0, 0),
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdaptiveText(
                text: "Mass Monster",
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
              Container(
                // height: 81,
                decoration: BoxDecoration(color: Constants.primaryColor),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AdaptiveText(
                      text: "Noida ",
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: "150 Ratings",
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/gym/map_pin.svg'),
              SizedBox(width: 10),
              AdaptiveText(
                text: "Noida Sector 8, C-Block",
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // trailing:
        ),
      ],
    );
  }
}
