// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class TrainLive extends StatelessWidget {
  const TrainLive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding:  EdgeInsets.fromLTRB(isDesktop()? 88:0.0,isDesktop()? 88:30, 0,isDesktop()? 80:12.0),
      children: [
        Padding(
          padding:  EdgeInsets.only(left:isDesktop()?0: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveText(
                text: "Train Live from Your Co-space",
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize:isDesktop()? 28:18,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
                margin: EdgeInsets.only(top: 8.0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Constants.green),
                child: AdaptiveText(
                  text: "Starting only at 99",
                  minFontSize: 12,
                  style: GoogleFonts.openSans(
                    fontSize: isDesktop()?24:14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height:isDesktop()? 170:90),
        Container(
          height:isDesktop()? 238:200,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: isDesktop()? 238:200,
                width: 283,
                margin: EdgeInsets.only(left: 20),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 283,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                            Constants.gradientPrimary,
                            Constants.gradientRed,
                          ],
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height:isDesktop()? 62:42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0)),
                            color: Constants.maroon),
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: Constants.red),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical:isDesktop()? 8.0:4.0),
                          child: AdaptiveText(
                            text: "Buy now",
                            align: TextAlign.center,
                            minFontSize: 10,
                            style: GoogleFonts.openSans(
                              fontSize:isDesktop()? 14:12,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
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
