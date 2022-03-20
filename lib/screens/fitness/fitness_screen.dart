import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/fitness/wtf_powered.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';
import 'certified_trainers.dart';
import 'experience.dart';
import 'fitness_fullstop.dart';
import 'have_knowledge.dart';
import 'most_booked.dart';
import 'most_booked_stuidio.dart';

class FitnessCenter extends StatefulWidget {
  static String routeName = '//FitnessCenter';

  const FitnessCenter({Key? key}) : super(key: key);

  @override
  _FitnessCenterState createState() => _FitnessCenterState();
}

class _FitnessCenterState extends State<FitnessCenter> {
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
              colors: <Color>[
                Constants.primaryColor,
                Color(0xff0B0B0B),
              ],
            ),
          ),
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 700),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.only(top: 148, right: 123),
                  child: Image.asset(
                    'assets/fitness/fitnessBanner.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(88, height * 0.2, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "Empowering ",
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AdaptiveText(
                      text: "Fitness",
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AdaptiveText(
                      text:
                          "Join WTF now and enjoy the expereience \nlike never before",
                      minFontSize: 14,
                      maxLines: 2,
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
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
                            text: "Download App Now",
                            minFontSize: 14,
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Constants.primaryColor,
                            ),
                          ),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Constants.white),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                        ),
                        if (isDesktop()) const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.06,
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
        if (!isDesktop()) gymCountSection(width),
        const Experience(),
        const WTFPowered(),
        const MostBooked(),
        const MostBookedStudios(),
        FitnessFullStop(),
        const CertifiedTrainers(),
        const HaveKnowledge(),
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