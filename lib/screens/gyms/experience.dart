import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class Experience extends StatelessWidget {
  const Experience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(
        color: Constants.primaryColor,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xffC60000),
            Color(0xffD13A3A),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 88, 0, 0),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(120, 0, 32, 0),
          child: BootstrapRow(
            children: [
              BootstrapCol(
                sizes: 'col-4 col-sm-4 col-md-4',
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdaptiveText(
                        text: "WTF Fitness",
                        minFontSize: 14,
                        style: GoogleFonts.openSans(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      AdaptiveText(
                        text: "Experience?",
                        minFontSize: 14,
                        style: GoogleFonts.openSans(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0XffFB5E5E),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AdaptiveText(
                                text: "@ your regular ",
                                minFontSize: 14,
                                style: GoogleFonts.openSans(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              ),
                              AdaptiveText(
                                text: "gym cost?",
                                minFontSize: 14,
                                style: GoogleFonts.openSans(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
              BootstrapCol(
                sizes: 'col-8 col-sm-8 col-md-8',
                child: Padding(
                  padding: const EdgeInsets.only(top: 180.0),
                  child: BootstrapRow(
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                            description: 'Modern \nEqipments',
                            icon: 'assets/gym/raphael_fitocracy.svg',
                            onClick: () {}),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                            description: 'Skilled \nTrainer',
                            icon: 'assets/gym/emojione_person.svg',
                            onClick: () {}),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                            description: 'Top class \nAmbiance',
                            icon: 'assets/gym/Vector.svg',
                            onClick: () {}),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                            onClick: () {},
                            icon: 'assets/gym/fluent_sanitize.svg',
                            description: 'Sanitized \nGYMS'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget item(
      {required String description,
      required String icon,
      required Function onClick}) {
    return Container(
      // constraints: const BoxConstraints(maxHeight: 144, maxWidth: 131),
      height: 144,
      width: 131,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 22),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 25.0,
                offset: Offset(0, -10))
          ],
          color: Constants.cardRedLight,
          borderRadius: BorderRadius.all(const Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Image.asset('assets/gym/.png'),
          SvgPicture.asset(
            icon,
            // height: 40,
          ),
          const SizedBox(height: 17),
          AdaptiveText(
            text: description,
            minFontSize: 14,
            maxLines: 5,
            align: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
