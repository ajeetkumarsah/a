import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class ThreeCards extends StatelessWidget {
  const ThreeCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var padding = Constants.getPadding(context);
     bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return Container(
      decoration: const BoxDecoration(color: Color(0xff1A1A1A)),
      child: BootstrapContainer(
        fluid: true,
        padding:  EdgeInsets.fromLTRB(isDesktop()? 88:12.0, 88, 0, 0),
        children: [
          BootstrapRow(
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-4 col-sm-12 col-md-4',
                child: cardItem(
                  isDesktop: isDesktop(),
                    icon: 'assets/partner/send.png',
                    heading: 'Self onboarding',
                    description:
                        'Self onboard in just 30 minutes and start growing your business from Day 1',
                    onClick: () {},
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xffF24444),
                        Color(0xffC60000),
                      ],
                    )),
              ),
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-4 col-sm-12 col-md-4',
                child: cardItem(
                  isDesktop: isDesktop(),
                  icon: 'assets/partner/network.png',
                  heading: 'Business Growth',
                  description:
                      'Get 2x revenue jump through WTF channels, OTAs & AI enabled pricing',
                  onClick: () {},
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xffF24444),
                      Color(0xffD70303),
                    ],
                  ),
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-4 col-sm-12 col-md-4',
                child: cardItem(
                  isDesktop: isDesktop(),
                  icon: 'assets/partner/setting.png',
                  heading: 'Easy Operations',
                  description:
                      'Manage inventory, access bookings in real-time and seek support from WTF Partner Suite',
                  onClick: () {},
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      Color(0xffF24444),
                      Color(0xffD00101),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardItem(
      {required String heading,
      required String description,
      required Function onClick,
      Gradient? gradient,
      required String icon,required bool isDesktop}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      constraints: const BoxConstraints(minHeight: 147, maxWidth: 414),
      padding: const EdgeInsets.only(left: 22, right: 22, top: 25, bottom: 40),
      decoration: BoxDecoration(
          gradient: gradient != null
              ? gradient
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Constants.gradientRedLight,
                    Constants.gradientBlackLight
                  ],
                ),
          borderRadius: BorderRadius.all(const Radius.circular(8.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: AdaptiveText(
              text:heading,
              minFontSize: 14,
              maxLines:1,
              style:  GoogleFonts.montserrat(
                fontSize: 20,
                
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            leading: Image.asset(icon),
          ),
          const SizedBox(height: 17),
          AdaptiveText(
            text: description,
            minFontSize: 10,
            maxLines: 3,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
