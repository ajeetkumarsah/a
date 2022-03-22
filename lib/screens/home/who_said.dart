import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class WhoSaid extends StatelessWidget {
  const WhoSaid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return Container(
    constraints:  BoxConstraints(minHeight:isMobile()?200: 400, maxHeight:isMobile()?300: 900),
    padding:isMobile()?EdgeInsets.all(0): EdgeInsets.only(bottom: 150),
    child: Stack(
      children: [
    Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: Image.asset(
        'assets/home/line.png',
        fit: BoxFit.fitWidth,
      ),
    ),
    ),
    Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Image.asset(
        'assets/home/thinLine.png',
        fit: BoxFit.fitWidth,
      ),
    ),
    ),
    Align(
    alignment: Alignment.centerRight,
    child: Padding(
       padding: const EdgeInsets.only( top: 130,bottom: 16),
      child: Image.asset(
        'assets/home/food.png',
        fit: BoxFit.fitHeight,
      ),
    ),
    ),
    Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(right: 64.0, top: 150,bottom: 32),      
      child: Image.asset(
        'assets/home/foods.png',
        fit: BoxFit.fitHeight,
        // height: 350,
      ),
    ),
    ),
    Container(
    margin: EdgeInsets.fromLTRB(isMobile()?12:88,isMobile()?12: height * 0.2, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          text: "Diet Plans are ",
          minFontSize: 14,
          style:  TextStyle(
            fontSize:isMobile()?36: 60,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            AdaptiveText(
              text: "Expensive.",
              minFontSize: 14,
              style:  TextStyle(
                fontSize: isMobile()?36: 70,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            AdaptiveText(
              text: " Who said?",
              minFontSize: 14,
              style:  TextStyle(
                fontSize: isMobile()?24: 70,
                fontWeight: FontWeight.w300,
                color: Constants.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AdaptiveText(
          text:
              "Get personalised diet plans as per your fitness goals from certified dieticians at \naffordable price only at WTF",
          minFontSize: 14,
          maxLines: 8,
          style: TextStyle(
            fontSize:isMobile()?12: 22,
            fontWeight: FontWeight.w200,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        SizedBox(height: height * 0.06),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: AdaptiveText(
                text: "Download App Now",
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize:isMobile()?10: 18,
                  fontWeight: FontWeight.w300,
                  color: Constants.primaryColor,
                ),
              ),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(isMobile()?1.77: 12)),
                  color: Constants.white),
              padding:isMobile()?const EdgeInsets.symmetric(vertical:10,horizontal:9.0): const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            if (isDesktop()|| isMobile()) const Spacer(),
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
