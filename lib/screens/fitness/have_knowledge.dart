import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class HaveKnowledge extends StatelessWidget {
  const HaveKnowledge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    return Container(
      color: Constants.primaryColor,
      constraints: const BoxConstraints(minHeight: 400, maxHeight: 600),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(88, height * 0.1, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                AdaptiveText(
                  text: "Have",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: 43,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "Knowledge?",
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 43,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: "We will Acknowledge !",
                      align: TextAlign.left,
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 43,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AdaptiveText(
                  text:
                      "Join the growing team of GURUS at WTF and share your \nexperience and knowledge to the world full of \nopportunities and earn 3X more.",
                  minFontSize: 14,
                  maxLines: 3,
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: height * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: AdaptiveText(
                        text: "Know More",
                        minFontSize: 14,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Constants.white),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      alignment: Alignment.center,
                    ),
                    if (isDesktop()) const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 427,
              width: 427,
              decoration: BoxDecoration(
                  color: Constants.cardRed,
                  borderRadius: BorderRadius.circular(12.0)),
              child:
                  Center(child: Image.asset('assets/fitness/Guruprogram.png')),
            ),
          ),
        ],
      ),
    );
  }
}
