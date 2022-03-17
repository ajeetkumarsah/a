import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
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
    return Container(
      color: Constants.primaryColor,
      constraints: const BoxConstraints(minHeight: 400, maxHeight: 600),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(88, height * 0.1, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: "You Know?",
                  minFontSize: 14,
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "We are making gyms ",
                      minFontSize: 14,
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: "fully automated.",
                      align: TextAlign.left,
                      minFontSize: 14,
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w300,
                        color: Constants.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AdaptiveText(
                  text:
                      "Partner with WTF and multiply your revenue channels by leveraging our technology and expertise in \nterms of infrastructure, customer service and experience, sales, and marketing.",
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
                        text: "Know More",
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
        ],
      ),
    );
  }
}
