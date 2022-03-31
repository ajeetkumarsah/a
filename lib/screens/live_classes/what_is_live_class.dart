import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class WhatIsLiveClass extends StatelessWidget {
  const WhatIsLiveClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isSmallMobile() => Responsive.isSmallMobile(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(
        color: Constants.black,
      ),
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(isDesktop() ? 53 : 12.0,
              isSmallMobile() || isMobile() ? 20 : 0, isDesktop() ? 82 : 0, 0),
          child: BootstrapRow(
            children: [
              BootstrapCol(
                sizes: 'col-12 col-sm-12 col-md-12',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "What is \nWTF Live ?",
                      maxLines: 2,
                      minFontSize: 8,
                      style: GoogleFonts.openSans(
                        fontSize: isDesktop()
                            ? 36
                            : isSmallMobile()
                                ? 10
                                : isMobile()
                                    ? 14
                                    : 18,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    AdaptiveText(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo a commodo neque diam. Cras commodo sed sapien netus egestas faucibus imperdiet duis ac. Rhoncus eget consequat fermentum eget id vitae.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo a commodo neque diam. Cras commodo sed sapien netus egestas faucibus imperdiet duis ac. Rhoncus eget consequat fermentum eget id vitae.",
                      maxLines: 10,
                      minFontSize: 8,
                      style: GoogleFonts.openSans(
                        fontSize: isDesktop()
                            ? 16
                            : isSmallMobile()
                                ? 8
                                : isMobile()
                                    ? 10
                                    : 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
