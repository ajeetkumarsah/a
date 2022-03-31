import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class GymsNearby extends StatelessWidget {
  const GymsNearby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 88, 0, 30),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 64),
            AdaptiveText(
              text: "Book Live class nearby",
              minFontSize: 14,
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        Container(
          height: 420,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 5,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                // height: 222,
                width: 824,
                margin: EdgeInsets.only(left: index == 0 ? 64 : 32),
                child: Column(
                  // alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 824,
                      height: 320,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/live_classes/card.png')),
                      ),
                    ),
                    ListTile(
                      title: AdaptiveText(
                        text: "WTF Friends Gym",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: AdaptiveText(
                        text: "09 AM-10 AM",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Container(
                        width: 128,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xffDE0000),
                              Color(0xff9A0E0E),
                            ],
                          ),
                        ),
                        child: Center(
                          child: AdaptiveText(
                            text: "Book Now",
                            minFontSize: 14,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
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
