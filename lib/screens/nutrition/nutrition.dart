import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/nutrition/get_diet.dart';
import 'package:wtf_web/screens/nutrition/nutrivores_plan.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../fitness/certified_trainers.dart';
import '../fitness/have_knowledge.dart';
import 'nutrivores.dart';

class NutritionScreen extends StatefulWidget {
  static String routeName = '//NutritionScreen';

  const NutritionScreen({Key? key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color(0xffD60303), Color(0xff0B0B0B)],
            ),
          ),
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 700),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(right:isMobile()?12.0: 61.0, bottom:isMobile()?12.0: 122),
                  child: Image.asset(
                    'assets/nutrition/banner.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(88, height * 0.2, 0, 0),
                child: Column(
                  crossAxisAlignment:isMobile()?CrossAxisAlignment.center: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    AdaptiveText(
                      text: "Who said diet",
                      align: TextAlign.center,
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile() ?36:72,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AdaptiveText(
                      text: "foods are",
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize:isMobile() ?36: 72,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AdaptiveText(
                      text: "Boring?",
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize:isMobile() ?36: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        if (!isDesktop()) gymCountSection(width),
        const NutriVores(),
        const GetDiet(),
        const NutrivoresPlan(),
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
