import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class FitnessFullStop extends StatelessWidget {
  FitnessFullStop({Key? key}) : super(key: key);
  List<String> icons = [
    'assets/fitness/girl.png',
    'assets/fitness/man.png',
    'assets/fitness/girls.png',
    'assets/fitness/man1.png',
    'assets/fitness/man2.png'
  ];
  List<String> names = ['ZUMBA', 'CROSSFIT', 'PILATES', 'GYM', 'CARDIO'];
  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    return Container(
      color: Constants.primaryColor,
      constraints: const BoxConstraints(minHeight: 400, maxHeight: 650),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(88, height * 0.1, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "Fitness",
                      minFontSize: 14,
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        AdaptiveText(
                          text: "We serve all your needs ",
                          minFontSize: 14,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 3,
                          width: 230,
                          color: Constants.white,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Image.asset('assets/fitness/FULLSTOP.png'),
                const SizedBox(height: 12),
                Container(
                  height: 322,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 222,
                            width: 366,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  width: 151,
                                  height: 151,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: <Color>[
                                        Constants.gradientPrimary,
                                        Constants.gradientRed,
                                      ],
                                    ),
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                                Image.asset(
                                  icons[index],
                                  height: 190,
                                )
                              ],
                            ),
                          ),
                          AdaptiveText(
                            text: names[index],
                            align: TextAlign.center,
                            minFontSize: 14,
                            style: GoogleFonts.openSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
