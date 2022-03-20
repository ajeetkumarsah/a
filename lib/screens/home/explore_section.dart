import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/explore_section.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isDesktop() => Responsive.isDesktop(context);
    List<ExploreModel> exploreItems = [
      ExploreModel(
          icon: 'assets/home/dumbal.png',
          heading: "Fitness by WTF",
          description:
              'Come Train at WTF managed fitness centers which are fully automated,From making payments to earning rewards for your every activity in the gym we made it fun and hassle free',
          onClick: () {}),
      ExploreModel(
          icon: 'assets/home/connect.png',
          heading: 'Live by WTF',
          description:
              'Enjoy Live Training Facilities anwhere in the world through WTF Live,Train at your comfort and safety and never miss your training,',
          onClick: () {}),
      ExploreModel(
          icon: 'assets/home/fork.png',
          heading: 'Nutrition by WTF',
          description:
              'Get Your Tailored diet plan from the India\'s Top Nutritionist.Our Nutritionist makes your diet health as well as tasty,which will not make taste buds suffer.',
          onClick: () {}),
      ExploreModel(
        icon: 'assets/home/people.png',
        heading: 'PT by WTF',
        onClick: () {},
        description:
            'Get trained from World class Trainer,From discussing your Fitness goals to creating your personalize training program all at WTF PT',
      ),
    ];
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.fromLTRB(!isDesktop() ? 16 : 88, 88, 0, 0),
      children: [
        AdaptiveText(
          text: "Explore",
          minFontSize: 14,
          style: GoogleFonts.openSans(
            fontSize: isMobile() ? 24 : 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 100),
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Container(
                constraints: BoxConstraints(
                    minHeight: 200, maxHeight: isMobile() ? 228 : 317),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: exploreItems.length,
                  itemBuilder: ((context, index) => item(
                      isMobile: isMobile(),
                      heading: exploreItems[index].heading,
                      description: exploreItems[index].description,
                      onClick: exploreItems[index].onClick,
                      icon: exploreItems[index].icon)),
                ),
              ),
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
      String? icon,
      required bool isMobile}) {
    return Container(
      margin: EdgeInsets.only(right: 32.0),
      constraints: BoxConstraints(
          minHeight: isMobile ? 228 : 291, maxWidth: isMobile ? 250 : 317),
      padding: EdgeInsets.only(
          left: isMobile ? 17 : 22,
          right: isMobile ? 17 : 22,
          top: isMobile ? 20 : 25,
          bottom: isMobile ? 30 : 40),
      decoration: BoxDecoration(
          color: Color(0Xff7C0000),
          gradient: LinearGradient(
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
            colors: [
              Constants.gradientRed,
              Constants.gradientPrimary,
            ],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.all(const Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              heading,
              style: TextStyle(
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            trailing: icon != null
                ? Image.asset(icon, height: isMobile ? 20 : 26)
                : Icon(
                    FontAwesomeIcons.dumbbell,
                    color: Colors.white,
                    size: isMobile ? 20 : 46,
                  ),
          ),
          SizedBox(height: isMobile ? 0 : 17),
          AdaptiveText(
            text: description,
            minFontSize: 8,
            maxLines: 8,
            style: TextStyle(
              fontSize: isMobile ? 10 : 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Container(
            height: isMobile ? 40 : null,
            padding: isMobile
                ? EdgeInsets.symmetric(horizontal: 36, vertical: 10)
                : EdgeInsets.only(left: 48, right: 48, top: 13, bottom: 13),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white),
            child: AdaptiveText(
              text: 'Know More',
              minFontSize: 14,
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: isMobile ? 14 : 18,
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
