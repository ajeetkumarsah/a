// ignore_for_file: unused_element

import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class WorldClassSection extends StatefulWidget {
  const WorldClassSection({Key? key}) : super(key: key);

  @override
  _WorldClassSectionState createState() => _WorldClassSectionState();
}

class _WorldClassSectionState extends State<WorldClassSection>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController pageController;
  int currentPage = 2;
  double viewPortFraction = 0.5;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => changeAction());
  }

  void changeAction() {
    setState(() {});
    pageController.animateToPage(_tabController.index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isTablet() => Responsive.isTablet(context);
    return Container(
      padding: EdgeInsets.only(left: isDesktop() ? 88 : 12),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home/diamond_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: BootstrapContainer(
        fluid: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Label
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdaptiveText(
                    text: 'World Class\nFacilities',
                    maxLines: 2,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: isMobile() ? 24 : 48,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Divider(
                      thickness: isMobile() ? 3 : 9,
                      height: isMobile() ? 3 : 9,
                      color: Colors.white,
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 50),
              TabBar(
                controller: _tabController,
                indicatorWeight: isMobile() ? 3 : 10,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Constants.primaryColor,
                unselectedLabelColor: Colors.white,
                labelColor: Constants.primaryColor,
                labelPadding: const EdgeInsets.only(bottom: 12),
                unselectedLabelStyle: GoogleFonts.montserrat(
                  fontSize: isMobile() ? 12 : 36,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
                labelStyle: GoogleFonts.montserrat(
                  fontSize: isMobile() ? 12 : 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
                tabs: [
                  tabItem(
                      label: 'WTF Fitness',
                      selected: _tabController.index == 0,
                      isMobile: isMobile()),
                  tabItem(
                      label: 'WTF Live',
                      selected: _tabController.index == 1,
                      isMobile: isMobile()),
                  tabItem(
                      label: 'Personal Training',
                      selected: _tabController.index == 2,
                      isMobile: isMobile())
                ],
              ),
              ExpandablePageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  wtfFitness(isMobile()),
                  WTFLive(),
                  personalTraning()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget wtfFitness(bool isMobile) {
    return Row(
      children: [options(), expandedView()],
    );
  }

  Widget WTFLive() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/home/Live.png',
              fit: BoxFit.cover,
              height: 600,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: "Unlocking",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                AdaptiveText(
                  text: "Fitness",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: 70,
                    fontWeight: FontWeight.w300,
                    color: Constants.primaryColor,
                  ),
                ),
                AdaptiveText(
                  text: "101",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: 70,
                    fontWeight: FontWeight.w300,
                    color: Constants.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                AdaptiveText(
                  text:
                      "Get access to live class from the trainer of your own gym at your comfort of \nyour home this Pandemic.Our Membership also gives you option to train at \nhome breaking all obstacle in your fitness journey.",
                  minFontSize: 14,
                  maxLines: 3,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: AdaptiveText(
                        text: "Download App Now",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Constants.white),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                    ),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget personalTraning() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/home/PT.png',
              fit: BoxFit.cover,
              height: 500,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        AdaptiveText(
                          text: "Personal ",
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 60,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        AdaptiveText(
                          text: "Training",
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 70,
                            fontWeight: FontWeight.w800,
                            color: Constants.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Constants.grey),
                      width: 5,
                      height: 120,
                    ),
                    AdaptiveText(
                      text: "Program \nby WTF",
                      minFontSize: 14,
                      maxLines: 2,
                      style: GoogleFonts.montserrat(
                        fontSize: 60,
                        fontWeight: FontWeight.w200,
                        color: Constants.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                AdaptiveText(
                  text:
                      "Train with world class fitness trainer Starting \njust @ 1500/month.",
                  minFontSize: 14,
                  maxLines: 3,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: AdaptiveText(
                        text: "Download App Now",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Constants.white),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                    ),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget wtfPersonalRightItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/home/bg1.png',
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget options() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        wtfFitnessLeftItem(label: 'Pocket', width: 179, height: 58),
        wtfFitnessLeftItem(label: 'Friendly', width: 243, height: 58),
        wtfFitnessLeftItem(label: 'Membership', width: 290, height: 58),
      ],
    );
  }

  Widget expandedView() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 30),
          AdaptiveText(
            text:
                'WTF Powered gyms are top class infrastructure and Modern machinery at your regular gym membership',
            minFontSize: 12,
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              wtfFitnessRightCard(
                  imagePath: 'assets/home/men_exercise.png',
                  label: 'GYMS',
                  isLeft: false),
              if (isDesktop())
                Container(
                  margin: const EdgeInsets.only(top: 160, left: 60),
                  child: wtfFitnessRightCard(
                      imagePath: 'assets/home/girl_exercise.png',
                      label: 'STUDIOS',
                      isLeft: true),
                )
            ],
          ),
          if (!isDesktop())
            Container(
              margin: const EdgeInsets.only(top: 30, left: 0),
              child: wtfFitnessRightCard(
                  imagePath: 'assets/home/girl_exercise.png',
                  label: 'STUDIOS',
                  isLeft: true),
            )
        ],
      ),
    );
  }

  Widget wtfFitnessRightCard(
      {required String label, required String imagePath, bool isLeft = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: 389.77,
          width: 389.77,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.2)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imagePath,
              ),
            ),
          ),
        ),
        bookMark(!isLeft, label)
      ],
    );
  }

  Widget bookMark(bool isLeft, String label) {
    return Positioned(
        left: isLeft
            ? null
            : isDesktop()
                ? -300
                : null,
        bottom: isLeft ? null : 0,
        right: isLeft
            ? isDesktop()
                ? -200
                : null
            : null,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              padding: isLeft
                  ? EdgeInsets.only(right: 100)
                  : EdgeInsets.only(left: 60),
              margin: EdgeInsets.only(
                  top: isLeft ? 20 : 0, bottom: isLeft ? 20 : 0),
              alignment: Alignment.center,
              color: Constants.primaryColor,
              width: isLeft ? 280 : 300,
              height: 81,
              child: AdaptiveText(
                text: label,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize: 45.74),
              ),
            ),
            Align(
              alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: isLeft
                    ? const EdgeInsets.only(left: 58.0)
                    : const EdgeInsets.only(right: 240.0),
                child: isLeft
                    ? Image.asset('assets/home/rright.png')
                    : Image.asset('assets/home/rleft.png'),
              ),
            ),
          ],
        ));
  }

  Widget wtfFitnessLeftItem(
      {required String label, required double height, required double width}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      constraints: BoxConstraints(minHeight: height, minWidth: width),
      decoration: const BoxDecoration(color: Constants.primaryColor),
      alignment: Alignment.center,
      child: AdaptiveText(
        text: label,
        maxLines: 3,
        style: GoogleFonts.montserrat(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal),
      ),
    );
  }

  Widget tabItem(
      {required String label, bool selected = false, required bool isMobile}) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
          fontSize: isMobile ? 12 : 36,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: selected ? Constants.primaryColor : Colors.white),
    );
  }

  bool isDesktop() => Responsive.isDesktop(context);
}

class PView extends StatelessWidget {
  const PView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(itemBuilder: (context, index) {
      return Container(
        height: 300,
        color: Colors.red,
      );
    });
  }
}
