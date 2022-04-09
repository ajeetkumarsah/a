// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/screens/gym_details/gym_details.dart';
import 'package:wtf_web/screens/membership_details/arguments/arguments.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class AboutGym extends StatelessWidget {
  final MemberShipDetailsArgument? memberShipDetailsArgument;
  const AboutGym({Key? key, required this.memberShipDetailsArgument})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(48, 53, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-5',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AdaptiveText(
                          text:
                              "${memberShipDetailsArgument!.gymDetails.gymName}",
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
                          decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(1.27)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
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
                          text:
                              "${memberShipDetailsArgument!.gymDetails.address1}, ${memberShipDetailsArgument!.gymDetails.address2}",
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
                  Container(
                    // width: 280,
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdaptiveText(
                              text: 'PLAN 1',
                              minFontSize: 14,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                            Container(
                              height: 27,
                              width: 87,
                              decoration: BoxDecoration(
                                  color: Constants.gradientGreenLight,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: AdaptiveText(
                                  text:
                                      '₹ ${memberShipDetailsArgument!.membershipPlan.price}',
                                  minFontSize: 14,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    color: Constants.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/logo.png'),
                            SizedBox(width: 8.0),
                            AdaptiveText(
                              text:
                                  '${memberShipDetailsArgument!.membershipPlan.planName}',
                              minFontSize: 14,
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                color: Constants.textLightGreen,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdaptiveText(
                            text: 'Best for person who frequently travel',
                            minFontSize: 10,
                            maxLines: 2,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AdaptiveText(
                                text: '•  1 Month membership',
                                minFontSize: 10,
                                maxLines: 2,
                                align: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Constants.white,
                                ),
                              ),
                              AdaptiveText(
                                text: '•  Trainer Support',
                                minFontSize: 10,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Constants.white,
                                ),
                              ),
                              AdaptiveText(
                                text: '•  Access to free diet plans',
                                minFontSize: 10,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Constants.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-7',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 287,
                    color: Constants.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
