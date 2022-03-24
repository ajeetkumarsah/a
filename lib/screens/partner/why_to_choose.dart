// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class WhyToChoose extends StatelessWidget {
  const WhyToChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
     bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isMobileLarge() => Responsive.isMobileLarge(context);
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(color: Color(0xff1A1A1A)),
      child: BootstrapContainer(
        fluid: true,
        padding: EdgeInsets.fromLTRB(isDesktop()? 88:12.0, height * 0.1, 0, 0),
        children: [
          BootstrapRow(
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-12 col-sm-12 col-md-12',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        AdaptiveText(
                          text: 'Why to Choose WTF ?',
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: isDesktop()?48:24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                            child: Divider(
                          thickness: 9,
                          height: 9,
                          color: Colors.white,
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          BootstrapRow(
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-12 col-sm-12 col-md-8',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 86),
                    rowBuilder(
                      isDesktop: isDesktop(),
                        title:
                            'If your fitness centre is getting affected by COVID19?',
                        icon: 'assets/partner/virus.svg'),
                    SizedBox(height: 46),
                    rowBuilder(
                      isDesktop: isDesktop(),
                        title: 'If finding new client is challenging for you?',
                        icon: 'assets/partner/group.svg'),
                    SizedBox(height: 46),
                    rowBuilder(
                      isDesktop: isDesktop(),
                        title: 'If managing operations is a headache for you?',
                        icon: 'assets/partner/setting.svg'),
                    SizedBox(height: 46),
                    rowBuilder(
                      isDesktop: isDesktop(),
                        title:
                            'If you want to make your business fully automated?',
                        icon: 'assets/partner/settings.svg'),
                    SizedBox(height: 68),
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
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-sm-12 col-md-4',
                child:isMobileLarge()?SizedBox(): Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 24),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/partner/iphone.png',
                    height: 400,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rowBuilder({required String title, required String icon,required bool isDesktop}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 12.0),
        AdaptiveText(
          text: title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: isDesktop?18:14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
