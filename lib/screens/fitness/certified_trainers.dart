import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../extra/utils/theme_data.dart';

class CertifiedTrainers extends StatefulWidget {
  const CertifiedTrainers({Key? key}) : super(key: key);

  @override
  State<CertifiedTrainers> createState() => _CertifiedTrainersState();
}

class _CertifiedTrainersState extends State<CertifiedTrainers> {
  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 88, 0, 40),
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AdaptiveText(
                  text: "Meet WTF ",
                  align: TextAlign.center,
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AdaptiveText(
                      text: "Certified ",
                      align: TextAlign.center,
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: "TRAINERS ",
                      // align: TextAlign.center,
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: 70,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 100),
        Container(
          height: 450,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                width: 370,
                height: 404,
                padding: EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 191,
                        height: 404,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Constants.primaryColor,
                          border:
                              Border.all(width: 5, color: Color(0xff000000)),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    color: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'assets/fitness/statusBar.svg',
                                      // fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Image.asset('assets/logo.png'),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 307,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24.0),
                                        bottomRight: Radius.circular(24.0)),
                                    color: Color(0xff940000),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/fitness/phoneIcon.png'),
                                        fit: BoxFit.cover)),
                                child: Container(
                                  height: 307,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(24.0),
                                          bottomRight: Radius.circular(24.0)),
                                      color:
                                          Color(0xff940000).withOpacity(0.58)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: AdaptiveText(
                            text: "RAVINDRA",
                            align: TextAlign.center,
                            minFontSize: 14,
                            style: GoogleFonts.openSans(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AdaptiveText(
                              text: "CARDIO",
                              align: TextAlign.center,
                              minFontSize: 14,
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.normal,
                                color: Color(0xffFFFFFF),
                                letterSpacing: 10,
                              ),
                            ),
                            AdaptiveText(
                              text: "CROSSFIT",
                              align: TextAlign.center,
                              minFontSize: 14,
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                letterSpacing: 10,
                              ),
                            ),
                            AdaptiveText(
                              text: "AEROBICS",
                              align: TextAlign.center,
                              minFontSize: 14,
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                letterSpacing: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
