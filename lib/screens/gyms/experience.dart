import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class Experience extends StatelessWidget {
  const Experience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isSmallMobile() => Responsive.isSmallMobile(context);
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
          padding:  EdgeInsets.fromLTRB(isDesktop()?120:12.0,isSmallMobile() || isMobile()?20: 0,isDesktop()? 32:0, 0),
          child: BootstrapRow(
            children: [
              BootstrapCol(
                sizes: 'col-5 col-sm-5 col-md-5',
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdaptiveText(
                        text: "WTF Fitness",
                        minFontSize: 8,
                        style: GoogleFonts.openSans(
                          fontSize:isDesktop()? 48:isSmallMobile()?12:isMobile()?18: 24,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      AdaptiveText(
                        text: "Experience?",
                        minFontSize: 8,
                        style: GoogleFonts.openSans(
                          fontSize:isDesktop()? 48:isSmallMobile()?12:isMobile()?18:24,
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
                            height:!isDesktop()?50: 200,
                            width: width *0.04,
                            decoration: const BoxDecoration(
                              color: Color(0XffFB5E5E),
                            ),
                          ),
                          SizedBox(width:isSmallMobile() ?10: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AdaptiveText(
                                text: "@ your regular ",
                                minFontSize: 8,
                                style: GoogleFonts.openSans(
                                  fontSize:isDesktop()? 30:isSmallMobile() ?9:isMobile()?12:16,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              ),
                              AdaptiveText(
                                text: "gym cost?",
                                minFontSize: 8,
                                style: GoogleFonts.openSans(
                                  fontSize: isDesktop()? 30:isSmallMobile() ?9:isMobile()?12:16,
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
                sizes:'col-7 col-sm-7 col-md-7',
                child: Padding(
                  padding:  EdgeInsets.only(top:isSmallMobile()|| isMobile()?30: 180.0),
                  child: BootstrapRow(
                    children: <BootstrapCol>[
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                           isDesktop: isDesktop(),
                            description: 'Modern \nEqipments',
                            icon: 'assets/gym/raphael_fitocracy.svg',
                            onClick: () {}),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                           isDesktop: isDesktop(),
                            description: 'Skilled \nTrainer',
                            icon: 'assets/gym/emojione_person.svg',
                            onClick: () {}),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                           isDesktop: isDesktop(),
                            description: 'Top class \nAmbiance',
                            icon: 'assets/gym/Vector.svg',
                            onClick: () {}),
                      ),
                      BootstrapCol(
                        sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                        child: item(
                          isDesktop: isDesktop(),
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
      required Function onClick,required bool isDesktop}) {
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
            style:  GoogleFonts.montserrat(
              fontSize:isDesktop? 17:10,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
