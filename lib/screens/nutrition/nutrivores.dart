import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class NutriVores extends StatelessWidget {
  const NutriVores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding:  EdgeInsets.fromLTRB(48,isMobile()?30: 100, 0, 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: "NUT",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile()?32: 64,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: Constants.cardGreen,
                  ),
                ),
                AdaptiveText(
                  text: "RIVO",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile()?32:64,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: Constants.cardBrown,
                  ),
                ),
                AdaptiveText(
                  text: "RES",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize:isMobile()?32: 64,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: Constants.cardBabyPink,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            AdaptiveText(
              text: "Tailored diets for all",
              minFontSize: 14,
              style: GoogleFonts.openSans(
                fontSize:isMobile()?16: 36,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        Container(
          padding: isDesktop()
              ? const EdgeInsets.only(left: 300)
              : EdgeInsets.all(0),
          child: BootstrapRow(
            children: <BootstrapCol>[
              if (isDesktop())
                BootstrapCol(
                  sizes: 'col-12 col-md-3 col-sm-12',
                  child: SizedBox(),
                ),
              BootstrapCol(
                sizes: 'col-12 col-md-3 col-sm-12',
                child: item(
                  isDesktop: isDesktop(),
                  width: width,
                   isMobile: isMobile(),
                    color: Constants.cardGreen,
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada eu mollis lacus, ',
                    icon: 'assets/nutrition/icon1.png',
                    onClick: () {}),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-3 col-sm-12',
                child: item(
                  isDesktop: isDesktop(),
                  width: width,
                   isMobile: isMobile(),
                    color: Constants.cardBrown,
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada eu mollis lacus, ',
                    icon: 'assets/nutrition/icon2.png',
                    onClick: () {}),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-3 col-sm-12',
                child: item(
                  isDesktop: isDesktop(),
                  width: width,
                  isMobile: isMobile(),
                    color: Constants.cardBabyPink,
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Malesuada eu mollis lacus, ',
                    icon: 'assets/nutrition/icon3.png',
                    onClick: () {}),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget item(
      {required Color color,
      required String text,
      required String icon,
      required Function onClick,required isMobile,required double width,required bool isDesktop}) {
    return Stack(
      alignment:isDesktop? AlignmentDirectional.topStart:AlignmentDirectional.topCenter,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 301, maxWidth: 282),
          margin:  EdgeInsets.only(bottom: 22, top: 70),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(const Radius.circular(8.0))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 12.0, top: (162 / 2)),
            child: AdaptiveText(
              text: text,
              minFontSize: 12,
              maxLines: 5,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            icon,
            width: 195,
            height: 191,
          ),
        )
      ],
    );
  }
}
