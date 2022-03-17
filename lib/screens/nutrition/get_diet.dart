// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/nutrition/widget/custom_shape.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class GetDiet extends StatelessWidget {
  const GetDiet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(0, height * 0.1, 0, height * 0.1),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-5',
              child: Container(
                margin: EdgeInsets.only(top: 200, left: 100),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: 'Biceps ',
                      style: GoogleFonts.oregano(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 64,
                          color: Colors.white),
                    ),
                    Image.asset('assets/nutrition/Brunch.png'),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.32,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdaptiveText(
                            text: 'Fat -20gm',
                            minFontSize: 12,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          AdaptiveText(
                            text: 'Carbs-300gm',
                            minFontSize: 12,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          AdaptiveText(
                            text: 'Protien-35 gm',
                            minFontSize: 12,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            color: Constants.primaryColor,
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: <Color>[
                                Constants.gradientPrimary,
                                Constants.gradientRed,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 90),
                          alignment: Alignment.center,
                          child: AdaptiveText(
                            text: "Get Diet",
                            minFontSize: 14,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        someInfo(title: '200 +', subTitle: 'Premade Recepies'),
                        someInfo(
                            title: '25 +', subTitle: 'Certified Nutritionist'),
                        someInfo(
                            title: 'Unlimited', subTitle: 'Tailored Diets'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-7',
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: ClipPath(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          color: Constants.deepMaroon,
                        ),
                        clipper: CustomClipPath(),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/nutrition/foods.png'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget someInfo({required String title, required String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdaptiveText(
          text: title,
          minFontSize: 14,
          style: GoogleFonts.openSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        AdaptiveText(
          text: subTitle,
          minFontSize: 14,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
