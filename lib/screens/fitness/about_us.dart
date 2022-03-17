import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../extra/utils/theme_data.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 88, 0, 0),
      children: [
        Align(
          alignment: Alignment.center,
          child: AdaptiveText(
            text: "What our Partner say about us?",
            align: TextAlign.center,
            minFontSize: 14,
            style: GoogleFonts.openSans(
              fontSize: 25,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 100),
        Container(
          height: 320,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: 320,
                width: 600,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 500,
                      height: 300,
                      margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                      padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AdaptiveText(
                            text: "Ragini Sharma",
                            align: TextAlign.center,
                            minFontSize: 14,
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                          AdaptiveText(
                            text: "ONE Fitness(Noida sector 8)",
                            align: TextAlign.center,
                            minFontSize: 14,
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          AdaptiveText(
                              text:
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                              align: TextAlign.center,
                              minFontSize: 14,
                              maxLines: 5,
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                              width: 8.0,
                              color: Color.fromARGB(255, 12, 12, 12)),
                          color: Constants.white,
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
          // gradient: LinearGradient(
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft,
          //     colors: [
          //       Colors.black12.withOpacity(0.1),
          //       const Color(0Xff7C0000)
          //     ]
          // ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Constants.gradientRed,
              Constants.gradientPrimary,
            ],
          ),
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
            trailing: const Icon(
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
