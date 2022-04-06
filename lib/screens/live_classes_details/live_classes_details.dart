import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/live_classes_details/choose_plan.dart';
import 'package:wtf_web/screens/live_classes_details/live_classes_gym_details.dart';
import 'package:wtf_web/screens/live_classes_details/works_offers.dart';
import 'package:wtf_web/screens/membership/about_gym.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class LiveClassDetails extends StatefulWidget {
  static String routeName = '//LiveClassDetails';

  const LiveClassDetails({Key? key}) : super(key: key);

  @override
  _LiveClassDetailsState createState() => _LiveClassDetailsState();
}

class _LiveClassDetailsState extends State<LiveClassDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 400, maxHeight: 488),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 488,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: [
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 400, maxHeight: 488),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/membership/banner.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 400, maxHeight: 488),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/membership/banner.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 400, maxHeight: 488),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.center,
                  colors: [
                    Color(0xff000000),
                    Color(0xff000000).withOpacity(0.56),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 400, maxHeight: 488),
              child: Stack(
                // alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 12, right: 88, top: 60, bottom: 50),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        AdaptiveText(
                          text: 'Back',
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Constants.white,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AdaptiveText(
                      text: 'Multiple Photos can be added',
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: isDesktop() ? 36 : 18,
                        fontWeight: FontWeight.w500,
                        color: Constants.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        LiveClassAboutGym(),
        ChoosePlan(),
        const BottomBar(
          color: Color(0xff292929),
        ),
      ],
    );
  }

  double getPadding() {
    return ResponsiveWidget.isSmallScreen(context) ? 16 : 100;
  }

  Widget gymCountSection(double width) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: !isDesktop() ? Colors.white12.withOpacity(0.1) : Colors.black),
      padding: EdgeInsets.all(!isDesktop() ? 30 : 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: !isDesktop()
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'GYMS', count: '200'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'TRAINERS', count: '110'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'DIETITIANS', count: '95'),
          SizedBox(
            width: width * 0.01,
          ),
        ],
      ),
    );
  }

  bool isDesktop() => Responsive.isDesktop(context);

  Widget gymCount({required String count, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdaptiveText(
          text: count,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        const SizedBox(height: 6),
        AdaptiveText(
          text: label,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
