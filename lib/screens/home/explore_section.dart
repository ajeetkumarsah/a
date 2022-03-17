import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(88, 88, 0, 0),
      children: [
        AdaptiveText(
          text: "Explore",
          minFontSize: 14,
          style: GoogleFonts.openSans(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
              child: item(
                  icon: 'assets/home/dumbal.png',
                  heading: "Fitness by WTF",
                  description:
                      'Come Train at WTF managed fitness centers which are fully automated,From making payments to earning rewards for your every activity in the gym we made it fun and hassle free',
                  onClick: () {}),
            ),
            BootstrapCol(
              sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
              child: item(
                  icon: 'assets/home/connect.png',
                  heading: 'Live by WTF',
                  description:
                      'Enjoy Live Training Facilities anwhere in the world through WTF Live,Train at your comfort and safety and never miss your training,',
                  onClick: () {}),
            ),
            BootstrapCol(
              sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
              child: item(
                  icon: 'assets/home/fork.png',
                  heading: 'Nutrition by WTF',
                  description:
                      'Get Your Tailored diet plan from the India’s Top Nutritionist.Our Nutritionist makes your diet health as well as tasty,which will not make taste buds suffer.',
                  onClick: () {}),
            ),
            BootstrapCol(
              sizes: 'col-12 col-lg-6 col-xl-3 col-sm-12 col-md-6',
              child: item(
                  icon: 'assets/home/people.png',
                  heading: 'PT by WTF',
                  onClick: () {},
                  description:
                      'Get trained from World class Trainer,From discussing your Fitness goals to creating your personalize training program all at WTF PT'),
            ),
          ],
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
            trailing: icon != null
                ? Image.asset(icon, height: 26)
                : Icon(
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
