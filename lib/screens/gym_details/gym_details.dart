import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/similar_gyms_nearby.dart';
import 'package:wtf_web/screens/gym_details/train_live.dart';
import 'package:wtf_web/screens/home/who_said.dart';
import 'package:wtf_web/screens/home/you_know.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/home/explore_section.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import 'choose_membership.dart';
import 'fun_session.dart';
import 'image_by_user.dart';
import 'mass_monster.dart';

class GymDetails extends StatefulWidget {
  static String routeName = '//GymDetails';

  const GymDetails({Key? key}) : super(key: key);

  @override
  _GymDetailsState createState() => _GymDetailsState();
}

class _GymDetailsState extends State<GymDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 700),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/home/bg1.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 12, right: 88, top: 60, bottom: 50),
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
                      style: const TextStyle(
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
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Constants.white,
                  ),
                ),
              )
            ],
          ),
        ),
        if (!isDesktop()) gymCountSection(width),
        const MassMonsterSection(),
        const ChooseMembership(),
        const TrainLive(),
        const FunSession(),
        const ImageUploadedByUser(),
        SimilarGymsNearby(),
        const BottomBar(),
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
        const SizedBox(
          height: 6,
        ),
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
