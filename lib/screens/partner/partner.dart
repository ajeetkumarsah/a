import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/home/who_said.dart';
import 'package:wtf_web/screens/home/you_know.dart';
import 'package:wtf_web/screens/partner/three_card.dart';
import 'package:wtf_web/screens/partner/why_to_choose.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/home/explore_section.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../fitness/partners_say_section.dart';
import '../home/offering_section.dart';
import '../home/world_class_section.dart';
import 'about_wtf_section.dart';
import 'must_try_listening.dart';

class PartnerScreen extends StatefulWidget {
  static String routeName = '//PartnerScreen';

  const PartnerScreen({Key? key}) : super(key: key);

  @override
  _PartnerScreenState createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(color: Color(0xff1A1A1A)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BootstrapContainer(
              fluid: true,
              padding: EdgeInsets.fromLTRB(48, 150, 48, 0),
              children: [
                BootstrapRow(children: [
                  BootstrapCol(
                      sizes: 'col-12 col-sm-12 col-md-6',
                      child: Column(
                        children: [
                          AdaptiveText(
                            text: "Want to grow your fitness business?",
                            minFontSize: 14,
                            maxLines: 2,
                            style: GoogleFonts.montserrat(
                              fontSize: 72,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AdaptiveText(
                            text:
                                "We made it easy for you,be a part of WTF Family in just about 45 mins, that is also the time average person works-out in the GYM too.",
                            minFontSize: 14,
                            maxLines: 2,
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: AdaptiveText(
                                  text: "Get Started",
                                  minFontSize: 14,
                                  style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    color: Constants.primaryColor),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 75),
                                alignment: Alignment.center,
                              ),
                              if (isDesktop()) const Spacer(),
                              // if (isDesktop()) gymCountSection(width),
                            ],
                          ),
                        ],
                      )),
                  BootstrapCol(
                      sizes: 'col-12 col-sm-12 col-md-6',
                      child: Column(
                        children: [
                          Container(
                            height: 421,
                            decoration: BoxDecoration(
                                color: Constants.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(210))),
                          )
                        ],
                      ))
                ])
              ]),
          if (!isDesktop()) gymCountSection(width),
          const ThreeCards(),
          const WhyToChoose(),
          const MustTryListening(),
          const AboutWTFSection(),
          const PartnerSaySection(),
          const BottomBar(),
        ],
      ),
    );
  }

  double getPadding() {
    return ResponsiveWidget.isSmallScreen(context) ? 16 : 100;
  }

  Widget gymCountSection(double width) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: !isDesktop() ? Colors.white12.withOpacity(0.1) : Colors.black),
      padding: EdgeInsets.all(!isDesktop() ? 30 : 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: !isDesktop()
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'GYMS', count: '200'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'TRAINERS', count: '110'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'DIETITIANS', count: '95'),
          SizedBox(
            width: width * 0.01,
          ),
        ],
      ),
    );
  }

  bool isDesktop() => Responsive.isDesktop(context);

  Widget gymCount({required String count, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdaptiveText(
          text: count,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        AdaptiveText(
          text: label,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
