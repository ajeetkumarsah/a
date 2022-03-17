import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class MostBooked extends StatelessWidget {
  const MostBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(88, 88, 0, 0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Constants.gradientRed,
                    Constants.gradientPrimary,
                  ],
                ),
              ),
              child: AdaptiveText(
                text: "Most Booked GYMS ",
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: AdaptiveText(
                text: "View All",
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        Container(
          height: 222,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: 222,
                width: 366,
                margin: EdgeInsets.only(left: 20),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 366,
                      height: 222,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                            image: AssetImage('assets/fitness/gym.png')),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 10.0],
                          colors: <Color>[
                            Color(0xff00000000),
                            Color(0xff000000),
                          ],
                        ),
                      ),
                      alignment: Alignment.topLeft,
                      child: Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              stops: [0.0, 3.0],
                              colors: <Color>[
                                Color(0xff262626),
                                Color(0xff00000000),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(children: []),
                              AdaptiveText(
                                text: "ONE Fitness",
                                align: TextAlign.center,
                                minFontSize: 14,
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              ),
                              AdaptiveText(
                                text: "Noida Sector 8",
                                align: TextAlign.center,
                                minFontSize: 14,
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                ),
                              ),
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
