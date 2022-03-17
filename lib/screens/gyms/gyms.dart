import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/fitness/wtf_powered.dart';
import 'package:wtf_web/screens/gyms/experience.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import 'filters_gyms.dart';
import 'widget/search_section.dart';

class GymScreen extends StatefulWidget {
  static String routeName = '//GymScreen';

  const GymScreen({Key? key}) : super(key: key);

  @override
  _GymScreenState createState() => _GymScreenState();
}

class _GymScreenState extends State<GymScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Constants.gradientRedLight, Constants.black],
            ),
          ),
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 542),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Constants.black.withOpacity(0.4), BlendMode.srcOver),
                  child: Stack(
                    children: <Widget>[
                      AdaptiveText(
                        text: 'Powered',
                        style: GoogleFonts.montserrat(
                          fontSize: 352,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Constants.gradientRed,
                          letterSpacing: -7,
                        ),
                      ),
                      // Solid text as fill.
                      AdaptiveText(
                        text: "Powered",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 352,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 324.0),
                  child: Image.asset(
                    'assets/gym/running_girl.png',
                    // color: Constants.gradientRed,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 124.0),
                  child: Image.asset(
                    'assets/gym/running_boy.png',
                    // color: Constants.gradientRed,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(88, height * 0.2, height * 0.2, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AdaptiveText(
                        text: "GYM",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 220,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isDesktop())
          const SizedBox(
            height: 0,
          ),
        if (!isDesktop()) gymCountSection(width),
        const SearchSection(),
        FiltersAndGyms(),
        const Experience(),
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
