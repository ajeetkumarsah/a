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
bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isTablet() => Responsive.isTablet(context);
  @override
  Widget build(BuildContext context) {
    
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
                      ),
                  tabItem(
                      label: 'WTF Live',
                      selected: _tabController.index == 1,
                    ),
                  tabItem(
                      label: 'Personal Training',
                      selected: _tabController.index == 2,
                      )
                ],
              ),
              ExpandablePageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  wtfFitness(),
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

  Widget wtfFitness() {
    return isMobile()?BootstrapRow(
      children: [BootstrapCol(
         sizes: 'col-12 col-sm-12 col-md-12',
        child: options(), ),BootstrapCol(
         sizes: 'col-12 col-sm-12 col-md-12',
        child: expandedView(), )],): Row(children: [ options(),expandedView( )],);
    
    
   
  }

  Widget WTFLive() {
    return
     Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/home/Live.png',
              fit: BoxFit.cover,
              height:isMobile()?400: 600,
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
                    fontSize:  isMobile()?30:60,
                    fontWeight: isMobile()? FontWeight.w700:FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                AdaptiveText(
                  text: "Fitness",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile()?36: 70,
                    fontWeight: isMobile()? FontWeight.w700:FontWeight.w300,
                    color: Constants.primaryColor,
                  ),
                ),
                AdaptiveText(
                  text: "101",
                  minFontSize: 14,
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile()?36: 70,
                    fontWeight:  isMobile()? FontWeight.w700:FontWeight.w300,
                    color: Constants.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: isMobile()? EdgeInsets.only( right:MediaQuery.of(context).size.width*0.3):EdgeInsets.all(0),
                  child: AdaptiveText(
                    text:
                        "Get access to live class from the trainer of your own gym at your comfort of \nyour home this Pandemic.Our Membership also gives you option to train at \nhome breaking all obstacle in your fitness journey.",
                    minFontSize: 14,
                    maxLines: 6,
                    style: GoogleFonts.montserrat(
                      fontSize:isMobile()?10: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.5),
                    ),
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
                          fontSize:isMobile()?10: 18,
                          fontWeight: FontWeight.w400,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(isMobile()?4: 12)),
                          color: Constants.white),
                      padding: isMobile()?EdgeInsets.symmetric(horizontal: 9,vertical: 10): EdgeInsets.all( 16),
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
              height:isMobile()?300: 500,
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
                            fontSize:isMobile()?30: 60,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        AdaptiveText(
                          text: "Training",
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize:isMobile()?36: 70,
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
                      height:isMobile()?70: 120,
                    ),
                    AdaptiveText(
                      text: "Program \nby WTF",
                      minFontSize: 14,
                      maxLines: 2,
                      style: GoogleFonts.montserrat(
                        fontSize:isMobile()?30: 60,
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
                    fontSize:isMobile()?10: 16,
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
                          fontSize: isMobile()?12:18,
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(isMobile()?4:12)),
                          color: Constants.white),
                      padding: isMobile()?EdgeInsets.symmetric(horizontal: 9,vertical: 10): const EdgeInsets.all(16),
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
        SizedBox(height: 20),
        wtfFitnessLeftItem(label: 'Pocket', width: 179, height: isMobile()?30: 58),
        wtfFitnessLeftItem(label: 'Friendly', width: 243, height:isMobile()?30: 58),
        wtfFitnessLeftItem(label: 'Membership', width: 290, height:isMobile()?30: 58),
      ],
    );
  }

  Widget expandedView() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: isMobile()? EdgeInsets.only(right:MediaQuery.of(context).size.width*0.4):EdgeInsets.all(0),
            child: AdaptiveText(
              text:
                  'WTF Powered gyms are top class infrastructure and Modern machinery at your regular gym membership',
              minFontSize: 8,
              maxLines: 3,
              style: GoogleFonts.montserrat(
                  fontSize:isMobile()?10: 14, fontWeight: FontWeight.w300, color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:!isDesktop()?MainAxisAlignment.start: MainAxisAlignment.center,
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
              margin:  EdgeInsets.only(top:isMobile()?8.0: 30, left: isMobile()?30: 0),
              alignment: Alignment.centerRight,
              child: wtfFitnessRightCard(
                  imagePath: 'assets/home/girl_exercise.png',
                  label: 'STUDIOS',
                  isLeft: true),
            ),
            const SizedBox(height: 30),
          Padding(
            padding: isMobile()? EdgeInsets.only(left:MediaQuery.of(context).size.width*0.6):EdgeInsets.all(0),
            child: AdaptiveText(
              text:
                  'Our WTF Studio is all about the Dance,Zumb &Pilates classes',
              minFontSize: 8,
              maxLines: 3,
              style: GoogleFonts.montserrat(
                  fontSize:isMobile()?10: 14, fontWeight: FontWeight.w300, color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
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
          height:isMobile()?140 :389.77,
          width: isMobile()?140:389.77,
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.all(Radius.circular(isMobile()?4: 16.2)),
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
                :isMobile()?-60: null,
        bottom: isLeft ? null : 0,
        right: isLeft
            ? isDesktop()
                ? -200
                :isMobile()?-50: null
            : null,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              padding: isLeft
                  ? EdgeInsets.only(right:isMobile()?16.0: 100)
                  : EdgeInsets.only(left:isMobile()?12.0: 60),
              margin: EdgeInsets.only(
                  top: isLeft ? isMobile()?4: 20 : 0, bottom: isLeft ? isMobile()?4: 20 : 0),
              alignment: Alignment.center,
              color: Constants.primaryColor,
              width: isLeft ? isMobile()?66: 280 :  isMobile()?77: 300,
              height:isMobile()?24: 81,
              child: AdaptiveText(
                text: label,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize:isMobile()?12: 45.74),
              ),
            ),
            Align(
              alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: isLeft
                    ? const EdgeInsets.only(left: 58.0)
                    :  EdgeInsets.only(right:isMobile()?60: 240.0),
                child: isLeft
                    ? Image.asset('assets/home/rright.png',height:isMobile()?36:null)
                    : Image.asset('assets/home/rleft.png',height:isMobile()?36:null),
              ),
            ),
          ],
        ));
  }

  Widget wtfFitnessLeftItem(
      {required String label, required double height, required double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          constraints: BoxConstraints(minHeight: height, minWidth: width),
          decoration: const BoxDecoration(color: Constants.primaryColor),
          alignment: Alignment.center,
          child: AdaptiveText(
            text: label,
            maxLines: 3,
            style: GoogleFonts.montserrat(
                fontSize:isMobile()?18: 36,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal),
          ),
        ),
        Spacer()
      ],
    );
  }

  Widget tabItem(
      {required String label, bool selected = false}) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
          fontSize: isMobile() ? 12 : 36,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: selected ? Constants.primaryColor : Colors.white),
    );
  }

  
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
