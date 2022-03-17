import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class Experience extends StatelessWidget {
  const Experience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;

    bool isDesktop() => Responsive.isDesktop(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(88, 100, 0, 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdaptiveText(
              text: "WTF Fitness",
              minFontSize: 14,
              style: GoogleFonts.openSans(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
            AdaptiveText(
              text: "Experience?",
              minFontSize: 14,
              style: GoogleFonts.openSans(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 88.5,
                  width: 32,
                  decoration: const BoxDecoration(
                    color: Color(0Xff7C0000),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Constants.gradientRed,
                        Constants.gradientPrimary,
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: "@ your regular ",
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: 27,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                    AdaptiveText(
                      text: "gym cost?",
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: 27,
                        fontWeight: FontWeight.w300,
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
        const SizedBox(
          height: 100,
        ),
        Padding(
          padding: isDesktop()
              ? const EdgeInsets.only(left: 300)
              : EdgeInsets.all(0),
          child: BootstrapRow(
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                child: item(
                    heading: "Modern Equipments",
                    description:
                        'All WTF Powered Gyms are \nloaded with modern day \nequipments which will \nenhance your training \nexperience 2X.',
                    onClick: () {}),
              ),
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                child: item(
                  icon:'assets/gym/emojione_person.svg',
                    heading: 'Highly Skilled Trainer',
                    description:
                        'WTF Certified Trainer are of \nhigh skills and experience \nwhich will guide you to \nacheive your fitness goal \neasily',
                    onClick: () {}),
              ),
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                child: item(
                  icon:'assets/gym/Vector.svg',
                    heading: 'Top Class Ambiance',
                    description:
                        'We Firmly beleive that \nambiance makes a huge \ndifference in one \ntraining,thats why all our \ngyms have a Top class \nambiance',
                    onClick: () {}),
              ),
              BootstrapCol(
                sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
                child: item(
                    icon: 'assets/gym/fluent_sanitize.svg',
                    heading: 'Sanitized Gyms',
                    onClick: () {},
                    description:
                        'We are concerned for your \nsafety and hygeine,all WTF \nGym are properly sanitized \nand cleaned keeping all the \npreventive measures in mind.'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget item(
      {required String heading,
      required String description,
      required Function onClick,
      String? icon}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200, maxWidth: 190),
      padding: const EdgeInsets.only(left: 22, right: 22, top: 25, bottom: 22),
      margin: const EdgeInsets.only(bottom: 22),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Color(0Xff7C0000),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Center(
              child: Text(
                heading,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          AdaptiveText(
            text: description,
            minFontSize: 14,
            maxLines: 5,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                  icon != null ? icon : 'assets/gym/raphael_fitocracy.svg'),
            ],
          )
        ],
      ),
    );
  }
}
