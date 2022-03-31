import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/home/who_said.dart';
import 'package:wtf_web/screens/home/you_know.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/home/explore_section.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import 'offering_section.dart';
import 'partners_say_section.dart';
import 'world_class_section.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '//homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 700),
          decoration: isMobile()
              ? BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/home/banner_mobile.jpg'),
                      fit: BoxFit.fitHeight))
              : null,
          child: Stack(
            children: [
              if (!isMobile())
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/home/bg1.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              Container(
                margin: EdgeInsets.fromLTRB(isDesktop() ? 88 : 30.0,
                    isDesktop() ? height * 0.2 : 90, 0, isDesktop() ? 0 : 26),
                child: Column(
                  mainAxisAlignment: isDesktop()
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  crossAxisAlignment: isDesktop()
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    AdaptiveText(
                      text: "MAKING INDIA FIT",
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: isDesktop() ? 72 : 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: isDesktop()
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        AdaptiveText(
                          text: "ON",
                          minFontSize: 14,
                          style: GoogleFonts.openSans(
                            fontSize: isDesktop() ? 72 : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        AdaptiveText(
                          text: " BUDGET",
                          minFontSize: 14,
                          style: GoogleFonts.openSans(
                            fontSize: isDesktop() ? 72 : 36,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AdaptiveText(
                      text:
                          "Join WTF managed fitness centers and explore\nfitness like never before",
                      minFontSize: 14,
                      maxLines: 2,
                      align: isDesktop() ? TextAlign.start : TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    // SizedBox(height:isDesktop()? height * 0.06:30),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: AdaptiveText(
                            text: "Download App Now",
                            minFontSize: 14,
                            style: GoogleFonts.openSans(
                              fontSize: isDesktop() ? 18 : 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Constants.primaryColor),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                        ),
                        if (isDesktop()) const Spacer(),
                        if (isDesktop()) gymCountSection(width),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isDesktop())
          const SizedBox(
            height: 0,
          ),
        if (isDesktop() && !isDesktop()) gymCountSection(width),
        const ExploreSection(),
        const OfferingSection(),
        const WorldClassSection(),
        const WhoSaid(),
        const YouKnow(),
        const PartnerSaySection(),
        const BottomBar(),
      ],
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
  bool isMobile() => Responsive.isMobile(context);

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
