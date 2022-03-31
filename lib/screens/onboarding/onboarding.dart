import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/widgets/container_text_field.dart';
import 'package:wtf_web/screens/widgets/custom_dropdown.dart';
import 'package:wtf_web/utils/const.dart';
import 'package:wtf_web/utils/custom_painter.dart';

class OnboardingScreen extends StatefulWidget {
  static String routeName = '/OnboardingScreen';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  bool isDesktop() => Responsive.isDesktop(context);
  bool isMobile() => Responsive.isMobile(context);
  List<String> icons = [];
  @override
  void initState() {
    super.initState();
    icons = [
      'assets/signup/onboard1.png',
      'assets/signup/onboard2.png',
      'assets/signup/onboard3.png',
      'assets/signup/onboard4.png'
    ];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final pages = [
      onBoarding1(),
      onBoarding2(),
      onBoarding3(),
      onBoarding4(),
    ];

    return Container(
      height: height,
      // width: double.infinity,
      child: PageView.builder(
        controller: controller,
        // pageSnapping: false,
        physics: NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        itemBuilder: (_, index) {
          return baseContainer(
              height: height, icon: icons[index], child: pages[index]);
        },
      ),
    );

    // Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Positioned(
    //       top: 100,
    //       right: 284,
    //       child: CustomPaint(
    //         foregroundPainter: CircleBlurPainter(
    //             circleWidth: 104,
    //             blurSigma: 1.0,
    //             color: Constants.primaryColor),
    //       ),
    //     ),
    //     Positioned(
    //       top: 80,
    //       right: 204,
    //       child: CustomPaint(
    //         foregroundPainter: CircleBlurPainter(
    //             circleWidth: 40, blurSigma: 2.0, color: Constants.primaryColor),
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment.center,
    //       child: Container(
    //         constraints: BoxConstraints(
    //             maxHeight: 538, minHeight: 400, maxWidth: 874, minWidth: 600),
    //         // width: 874,
    //         // height: 538,
    //         margin: EdgeInsets.only(top: isDesktop() ? 90 : 30),
    //         padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight,
    //             colors: [
    //               Color(0xFF1D1D1D),
    //               Color(0xFF494949).withOpacity(0.31),
    //             ],
    //             stops: [0.1, 1],
    //           ),
    //           borderRadius: BorderRadius.circular(16),
    //         ),
    //         // child:
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget onBoarding1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdaptiveText(
              text: 'Let us know more about You',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomDropDown(
                  hint: Text(
                    'Select your age',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  hint: Text(
                    'Select your body Type',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  hint: Text(
                    'Height in cm',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  hint: Text(
                    'Target weight in kg',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomDropDown(
                  hint: Text(
                    'Gender',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  hint: Text(
                    'Workout Experience',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  hint: Text(
                    'Weight in kg',
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 56)
              ],
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.bounceInOut);
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBoarding2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.white,
              ),
            ),
            AdaptiveText(
              text: 'How Fast do you want to achieve this goal?',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
            SizedBox()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ContainerTextField(
                    width: 374,
                    cursorColor: Constants.white,
                    // controller: ,
                    color: Color(0xff424242).withOpacity(0.4),
                    hintText: 'Enter Full name'),
                ContainerTextField(
                  width: 374,
                  // controller: ,
                  cursorColor: Constants.white,
                  hintText: 'Enter password',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
                ContainerTextField(
                  width: 374,
                  // controller: ,
                  cursorColor: Constants.white,
                  hintText: 'Mobile number',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
                ContainerTextField(
                  width: 374,
                  // controller: ,
                  cursorColor: Constants.white,
                  hintText: 'OTP',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ContainerTextField(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                    cursorColor: Constants.white,
                    color: Color(0xff424242).withOpacity(0.4),
                    hintText: 'Email id'),
                ContainerTextField(
                  constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                  cursorColor: Constants.white,
                  hintText: 'Confirm Password',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
                ContainerTextField(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                    cursorColor: Constants.white,
                    color: Color(0xff424242).withOpacity(0.4),
                    hintText: 'Referal Code (Optional)'),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    // width: 374,
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                    height: 58,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Constants.primaryColor),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Center(
                      child: AdaptiveText(
                        text: 'Login',
                        minFontSize: 14,
                        align: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Constants.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.bounceInOut);
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBoarding3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.white,
              ),
            ),
            AdaptiveText(
              text: 'How Fast do you want to achieve this goal?',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
            SizedBox()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ContainerTextField(
                    width: 374,
                    cursorColor: Constants.white,
                    // controller: ,
                    color: Color(0xff424242).withOpacity(0.4),
                    hintText: 'Enter Full name'),
                ContainerTextField(
                  width: 374,
                  // controller: ,
                  cursorColor: Constants.white,
                  hintText: 'Enter password',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
                ContainerTextField(
                  width: 374,
                  // controller: ,
                  cursorColor: Constants.white,
                  hintText: 'Mobile number',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
                ContainerTextField(
                  width: 374,
                  // controller: ,
                  cursorColor: Constants.white,
                  hintText: 'OTP',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ContainerTextField(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                    cursorColor: Constants.white,
                    color: Color(0xff424242).withOpacity(0.4),
                    hintText: 'Email id'),
                ContainerTextField(
                  constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                  cursorColor: Constants.white,
                  hintText: 'Confirm Password',
                  color: Color(0xff424242).withOpacity(0.4),
                ),
                ContainerTextField(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                    cursorColor: Constants.white,
                    color: Color(0xff424242).withOpacity(0.4),
                    hintText: 'Referal Code (Optional)'),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    // width: 374,
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 374),
                    height: 58,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Constants.primaryColor),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Center(
                      child: AdaptiveText(
                        text: 'Login',
                        minFontSize: 14,
                        align: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Constants.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.bounceInOut);
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBoarding4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.white,
              ),
            ),
            AdaptiveText(
              text: 'How Fast do you want to achieve this goal?',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
            SizedBox()
          ],
        ),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 32),
                    height: 172,
                    width: 172,
                    decoration: BoxDecoration(
                      color: Color(0xff383838),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.bounceInOut);
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget baseContainer({double? height, required Widget child, String? icon}) {
    return Column(
      children: [
        BootstrapContainer(
          fluid: true,
          decoration: const BoxDecoration(color: Constants.black),
          padding: EdgeInsets.all(0),
          children: [
            Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Constants.black,
                image: DecorationImage(
                  image: AssetImage(
                      icon != null ? icon : 'assets/signup/onboard2.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              alignment: Alignment.center,
              // padding: EdgeInsets.only(top: isDesktop() ? 80 : 150),
              child: Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff000000),
                      Color(0xff000000).withOpacity(0.61),
                      Color(0xff000000)
                    ],
                    // stops: [0.1, 1, 0.1],
                  ),
                ),
                child: BootstrapRow(
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-12 col-md-12 col-sm-12',
                      child: Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 10,
                              left: 288,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 86,
                                    blurSigma: 1.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 350,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 20,
                                    blurSigma: 1.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              right: 284,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 104,
                                    blurSigma: 1.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              right: 204,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 40,
                                    blurSigma: 2.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: 538,
                                    minHeight: 400,
                                    maxWidth: 874,
                                    minWidth: 600),
                                // width: 874,
                                // height: 538,
                                margin:
                                    EdgeInsets.only(top: isDesktop() ? 90 : 30),
                                padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1D1D1D),
                                      Color(0xFF494949).withOpacity(0.31),
                                    ],
                                    stops: [0.1, 1],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: child,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
