// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class FunSession extends StatelessWidget {
  const FunSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(88, 38, 0, 80),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdaptiveText(
              text: "Fun Session at GYM",
              minFontSize: 14,
              style: GoogleFonts.openSans(
                fontSize: 28,
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
                  color: Constants.blue),
              child: AdaptiveText(
                text: "Starting only at 119 ",
                minFontSize: 18,
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 170),
        Container(
          height: 238,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: 238,
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
                        height: 62,
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
                              horizontal: 16.0, vertical: 8.0),
                          child: AdaptiveText(
                            text: "Buy now",
                            align: TextAlign.center,
                            minFontSize: 10,
                            style: GoogleFonts.openSans(
                              fontSize: 14,
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

  Widget item(
      {required String heading,
      required String description,
      required Function onClick}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200, maxWidth: 217),
      padding: const EdgeInsets.only(left: 22, right: 22, top: 25, bottom: 40),
      decoration: const BoxDecoration(
          color: Color(0Xff7C0000),
          borderRadius: BorderRadius.all(const Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              FontAwesomeIcons.dumbbell,
              color: Colors.white,
              size: 46,
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          AdaptiveText(
            text: description,
            minFontSize: 14,
            maxLines: 3,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 48, right: 48, top: 13, bottom: 13),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white),
            child: AdaptiveText(
              text: 'Know More',
              minFontSize: 14,
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
