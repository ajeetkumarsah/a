import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/onboarding/onboarding.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/widgets/container_text_field.dart';
import 'package:wtf_web/screens/widgets/custom_animatedswitcher.dart';
import 'package:wtf_web/utils/const.dart';
import 'package:wtf_web/utils/custom_painter.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return index == 0
        ? SingleChildScrollView(
            child: CustomAnimatedSwitcher(
              child: Column(
                children: [
                  BootstrapContainer(
                    fluid: true,
                    decoration: const BoxDecoration(color: Constants.black),
                    padding: EdgeInsets.all(0),
                    children: [
                      Container(
                        height: height,
                        decoration: BoxDecoration(
                          color: Constants.black,
                          image: DecorationImage(
                            image: AssetImage('assets/signup/banner.png'),
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
                                          margin: EdgeInsets.only(
                                              top: isDesktop() ? 90 : 30),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 34),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFffffff)
                                                    .withOpacity(0.1),
                                                Color(0xFFFFFFFF)
                                                    .withOpacity(0.05),
                                              ],
                                              stops: [0.1, 1],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    36.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AdaptiveText(
                                                              text: 'Signup',
                                                              minFontSize: 14,
                                                              align: TextAlign
                                                                  .center,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                fontSize: 36,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: Constants
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      ContainerTextField(
                                                          width: 374,
                                                          cursorColor:
                                                              Constants.white,
                                                          // controller: ,
                                                          color: Color(
                                                                  0xff424242)
                                                              .withOpacity(0.4),
                                                          hintText:
                                                              'Enter Full name'),
                                                      ContainerTextField(
                                                        width: 374,
                                                        // controller: ,
                                                        cursorColor:
                                                            Constants.white,
                                                        hintText:
                                                            'Enter password',
                                                        color: Color(0xff424242)
                                                            .withOpacity(0.4),
                                                      ),
                                                      ContainerTextField(
                                                        width: 374,
                                                        // controller: ,
                                                        cursorColor:
                                                            Constants.white,
                                                        hintText:
                                                            'Mobile number',
                                                        color: Color(0xff424242)
                                                            .withOpacity(0.4),
                                                      ),
                                                      ContainerTextField(
                                                        width: 374,
                                                        // controller: ,
                                                        cursorColor:
                                                            Constants.white,
                                                        hintText: 'OTP',
                                                        color: Color(0xff424242)
                                                            .withOpacity(0.4),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    36.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AdaptiveText(
                                                              text: '',
                                                              minFontSize: 14,
                                                              align: TextAlign
                                                                  .center,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                fontSize: 36,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: Constants
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      ContainerTextField(
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth: 200,
                                                                  maxWidth:
                                                                      374),
                                                          cursorColor:
                                                              Constants.white,
                                                          color: Color(
                                                                  0xff424242)
                                                              .withOpacity(0.4),
                                                          hintText: 'Email id'),
                                                      ContainerTextField(
                                                        constraints:
                                                            BoxConstraints(
                                                                minWidth: 200,
                                                                maxWidth: 374),
                                                        cursorColor:
                                                            Constants.white,
                                                        hintText:
                                                            'Confirm Password',
                                                        color: Color(0xff424242)
                                                            .withOpacity(0.4),
                                                      ),
                                                      ContainerTextField(
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth: 200,
                                                                  maxWidth:
                                                                      374),
                                                          cursorColor:
                                                              Constants.white,
                                                          color: Color(
                                                                  0xff424242)
                                                              .withOpacity(0.4),
                                                          hintText:
                                                              'Referal Code (Optional)'),
                                                      SizedBox(height: 12),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            index = 1;
                                                          });
                                                        },
                                                        child: Container(
                                                          // width: 374,
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth: 200,
                                                                  maxWidth:
                                                                      374),
                                                          height: 58,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              color: Constants
                                                                  .primaryColor),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.0),
                                                          child: Center(
                                                            child: AdaptiveText(
                                                              text: 'Signup',
                                                              minFontSize: 14,
                                                              align: TextAlign
                                                                  .center,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: Constants
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 42.0),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'Already have an account?  ',
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          color:
                                                              Constants.white,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: 'Login',
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          color: Constants
                                                              .redIconColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                    ],
                                  ),
                                ),
                              ),
                              // if (!isMobile())
                              //   BootstrapCol(
                              //     sizes: 'col-12 col-md-6 col-sm-12',
                              //     child: Container(
                              //       // margin: EdgeInsets.only(top: isDesktop() ? 80 : 150),
                              //       child: Stack(
                              //         // mainAxisAlignment: MainAxisAlignment.start,
                              //         // crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           Align(
                              //             child: CustomPaint(
                              //               foregroundPainter: CircleBlurPainter(
                              //                   circleWidth: 30,
                              //                   blurSigma: 3.0,
                              //                   color: Constants.primaryColor),
                              //             ),
                              //           ),
                              //           Align(
                              //             alignment: Alignment.center,
                              //             child: Image.asset('assets/login/banner.png'),
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const BottomBar()
                ],
              ),
            ),
          )
        : OnboardingScreen();
    // return BlocProvider(
    //   create: (context) => LoginBloc()
    //     ..add(
    //       PostLogInEvent(
    //         loginDetails: LoginModel(
    //             email: 'kukreti12.naresh@gmail.com', password: 'password'),
    //       ),
    //     ),
    //   child: BlocConsumer<SignupBloc, SignupState>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       // print('Calling Function===========>');

    //     },
    //   ),
    // );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      6,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 280,
          child: Center(
              child: Text(
            "Page $index",
            style: TextStyle(color: Colors.indigo),
          )),
        ),
      ),
    );
    return SingleChildScrollView(
      child: Container(
        color: Constants.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: controller,
                // itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                'Jumping Dot',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: JumpingDotEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    jumpScale: .7,
                    verticalOffset: 15,
                    paintStyle: PaintingStyle.stroke),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                'Swap',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: SwapEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: SwapType.yRotation,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child: Text(
                'Scrolling Dots',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: ScrollingDotsEffect(
                  activeStrokeWidth: 2.6,
                  activeDotScale: 1.3,
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 12,
                  dotWidth: 12,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'WormEffect Effect',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SmoothPageIndicator(
              controller: controller, // PageController
              count: 6,

              // forcing the indicator to use a specific direction
              textDirection: TextDirection.rtl,
              effect: WormEffect(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'Customizable Effect',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              // color: Colors.red.withOpacity(.4),
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 32,
                    height: 12,
                    color: Colors.indigo,
                    rotationAngle: 180,
                    verticalOffset: -10,
                    borderRadius: BorderRadius.circular(24),
                    // dotBorder: DotBorder(
                    //   padding: 2,
                    //   width: 2,
                    //   color: Colors.indigo,
                    // ),
                  ),
                  dotDecoration: DotDecoration(
                    width: 24,
                    height: 12,
                    color: Colors.grey,
                    // dotBorder: DotBorder(
                    //   padding: 2,
                    //   width: 2,
                    //   color: Colors.grey,
                    // ),
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(2),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(16),
                    //     bottomRight: Radius.circular(2)),
                    borderRadius: BorderRadius.circular(16),
                    verticalOffset: 0,
                  ),
                  spacing: 6.0,
                  // activeColorOverride: (i) => colors[i],
                  inActiveColorOverride: (i) => colors[i],
                ),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
