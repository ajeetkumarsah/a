import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
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
    return Container(
      constraints: const BoxConstraints(minHeight: 400, maxHeight: 900),
      padding: EdgeInsets.only(bottom: 150),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.asset(
                'assets/home/line.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Image.asset(
                'assets/home/thinLine.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/home/food.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 180.0, top: 230),
              child: Image.asset(
                'assets/home/foods.png',
                fit: BoxFit.fitHeight,
                // height: 350,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(88, height * 0.2, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: "Diet Plans are ",
                  minFontSize: 14,
                  style: const TextStyle(
                    fontSize: 60,
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
                      style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: " Who said?",
                      minFontSize: 14,
                      style: const TextStyle(
                        fontSize: 70,
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
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 22,
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
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Constants.white),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                    ),
                    if (isDesktop()) const Spacer(),
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
