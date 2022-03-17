// ignore_for_file: unused_local_variable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class NutrivoresPlan extends StatelessWidget {
  const NutrivoresPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    List<Nutrivores> nutrivores = [
      Nutrivores(duration: ' Powered 7 Days', price: '₹ 1500'),
      Nutrivores(duration: 'Powered 15 days', price: '₹ 4000'),
      Nutrivores(duration: 'Powered 30 days', price: '₹ 6000'),
      Nutrivores(duration: 'Powered 2 months', price: '₹ 11000')
    ];

    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Constants.primaryColor),
      padding: const EdgeInsets.fromLTRB(0, 88, 0, 0),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 88.0, top: 38, bottom: 60),
          child: AdaptiveText(
            text: "Nutrivores Plan",
            minFontSize: 14,
            style: GoogleFonts.openSans(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 100),
        Container(
          height: 418,
          margin: EdgeInsets.only(left: 88, bottom: 88),
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: nutrivores.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: 418,
                width: 312,
                margin: EdgeInsets.only(right: 50),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 312,
                      height: 418,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Constants.deepMaroon,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: [12, 12],
                                strokeWidth: 2,
                                radius: Radius.circular(90),
                                padding: EdgeInsets.all(16.0),
                                color: Constants.primaryColor,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90)),
                                  child: Container(
                                    height: 129,
                                    width: 129,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(90),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: <Color>[
                                          Constants.gradientPrimary,
                                          Constants.gradientRed,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: SvgPicture.asset(
                                    'assets/nutrition/nutrition_plan.svg'),
                              )
                            ],
                          ),
                          Column(children: [
                            AdaptiveText(
                              text: nutrivores[index].duration,
                              align: TextAlign.center,
                              minFontSize: 14,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                            AdaptiveText(
                              text: nutrivores[index].price,
                              align: TextAlign.center,
                              minFontSize: 14,
                              style: GoogleFonts.openSans(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AdaptiveText(
                                    text: '+ Services',
                                    align: TextAlign.center,
                                    minFontSize: 8,
                                    style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  AdaptiveText(
                                    text: '+ Add ons',
                                    align: TextAlign.center,
                                    minFontSize: 8,
                                    style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AdaptiveText(
                                    text: '+ Advantages',
                                    align: TextAlign.center,
                                    minFontSize: 8,
                                    style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                  AdaptiveText(
                                    text: '+ Bonuses',
                                    align: TextAlign.center,
                                    minFontSize: 8,
                                    style: GoogleFonts.openSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
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

class Nutrivores {
  final String duration;
  final String price;

  Nutrivores({required this.duration, required this.price});
}
