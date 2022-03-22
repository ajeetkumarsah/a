import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class YouKnow extends StatelessWidget {
  const YouKnow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return Container(
      color: Constants.primaryColor,
      constraints: BoxConstraints(
          minHeight: !isDesktop() ? 200 : 400,
          maxHeight: !isDesktop() ? 300 : 600),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                !isDesktop() ? 33 : 88, !isDesktop() ? 25 : height * 0.1, 0,isDesktop()?0:36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: "You Know?",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: !isDesktop() ? 24 : 60,
                    fontWeight: FontWeight.w300,
                    color: Constants.gradientRed,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "We are making gyms ",
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: !isDesktop() ? 24 : 60,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: "fully automated.",
                      align: TextAlign.left,
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: !isDesktop() ? 24 : 60,
                        fontWeight: FontWeight.w300,
                        color: Constants.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding:isDesktop()?const EdgeInsets.all(0): const EdgeInsets.only(right:12.0),
                  child: AdaptiveText(
                    text:
                        "Partner with WTF and multiply your revenue channels by leveraging our technology and expertise in \nterms of infrastructure, customer service and experience, sales, and marketing.",
                    minFontSize: 14,
                    maxLines: 2,
                    style: GoogleFonts.openSans(
                      fontSize: !isDesktop() ? 12 : 22,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: AdaptiveText(
                        text: "Know More",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(!isDesktop() ? 1.77 : 12)),
                          color: Constants.white),
                      padding: !isDesktop()
                          ? const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 10)
                          : const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                      alignment: Alignment.center,
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
