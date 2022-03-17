// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class SimilarGymsNearby extends StatelessWidget {
  SimilarGymsNearby({Key? key}) : super(key: key);
  final List<SimilarGyms> similarGyms = [
    SimilarGyms(
        title: 'ONE Fitness',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Angrezi Akhada',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Musclemania',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Fuerzaa',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Fuerzaa',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Fuerzaa',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Fuerzaa',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
    SimilarGyms(
        title: 'Fuerzaa',
        subTitle: 'Noida Sector 8',
        icon: 'assets/home/men_exercise.png'),
  ];

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(88, 38, 0, 80),
      children: [
        AdaptiveText(
          text: "Similar Gyms Nearbuy",
          minFontSize: 14,
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 70),
        Container(
          height: 238,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: similarGyms.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: 214,
                width: 366,
                margin: EdgeInsets.only(left: 20),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 366,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Constants.cardBlackLight,
                        image: DecorationImage(
                            image: AssetImage(similarGyms[index].icon),
                            fit: BoxFit.fitWidth),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AdaptiveText(
                              text: similarGyms[index].title,
                              minFontSize: 14,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                            AdaptiveText(
                              text: similarGyms[index].subTitle,
                              minFontSize: 8,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.transparent,
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class SimilarGyms {
  final String title;
  final String subTitle;
  final String icon;

  const SimilarGyms(
      {required this.title, required this.subTitle, required this.icon});
}
