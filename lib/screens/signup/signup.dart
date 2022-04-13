import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wtf_web/model/signup.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/package/animated_button.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/login/login.dart';
import 'package:wtf_web/screens/login/login_signup.dart';
import 'package:wtf_web/screens/onboarding/onboarding.dart';
import 'package:wtf_web/screens/profile/profile.dart';
import 'package:wtf_web/screens/signup/bloc/signup_bloc.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/alert_flash.dart';
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
  int index = 0;

  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  final referalCodeController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final AnimatedButtonController animatedButtonController =
      AnimatedButtonController();

  bool isOTPSent = false;
  final _bloc = SignupBloc();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);

    return BlocProvider(
      create: (context) => SignupBloc(),
      child: BlocConsumer<SignupBloc, SignupState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is FetchOtpState) {
            animatedButtonController.reset();
            _bloc.otp = state.otp;

            setState(() {
              isOTPSent = true;
            });

            print('got otp=======>');
            AlertFlash().showBasicsFlash(
                context: context,
                message:
                    'Please enter the OTP sent to +91${mobileController.text}');
          }
          if (state is SignupSuccessState) {
            print('=========>Signup Success');
            if (state.isSuccess) {
              animatedButtonController.completed();
              animatedButtonController.reset();
              AlertFlash()
                  .showBasicsFlash(context: context, message: state.msg);
              Navigator.pushReplacementNamed(
                  context, OnboardingScreen.routeName);
            } else {
              animatedButtonController.reset();
              AlertFlash()
                  .showBasicsFlash(context: context, message: state.msg);
            }
          }
          if (state is SignupStatusState) {
            animatedButtonController.reset();
            AlertFlash().showBasicsFlash(context: context, message: state.msg);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Constants.black,
            body: SingleChildScrollView(
              child: CustomAnimatedSwitcher(
                child: Form(
                  key: formkey,
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
                                              foregroundPainter:
                                                  CircleBlurPainter(
                                                      circleWidth: 104,
                                                      blurSigma: 1.0,
                                                      color: Constants
                                                          .primaryColor),
                                            ),
                                          ),
                                          Positioned(
                                            top: 80,
                                            right: 204,
                                            child: CustomPaint(
                                              foregroundPainter:
                                                  CircleBlurPainter(
                                                      circleWidth: 40,
                                                      blurSigma: 2.0,
                                                      color: Constants
                                                          .primaryColor),
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
                                                            MainAxisAlignment
                                                                .start,
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
                                                                  text:
                                                                      'Signup',
                                                                  minFontSize:
                                                                      14,
                                                                  align: TextAlign
                                                                      .center,
                                                                  style: GoogleFonts
                                                                      .openSans(
                                                                    fontSize:
                                                                        36,
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
                                                            controller:
                                                                fullNameController,
                                                            color: Color(
                                                                    0xff424242)
                                                                .withOpacity(
                                                                    0.4),
                                                            hintText:
                                                                'Enter Full name',
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Enter your full name";
                                                              } else
                                                                return null;
                                                            },
                                                          ),
                                                          ContainerTextField(
                                                            width: 374,
                                                            obscureText: !_bloc
                                                                .passwordVisible,
                                                            suffixIcon:
                                                                IconButton(
                                                              icon: Icon(
                                                                _bloc.passwordVisible
                                                                    ? Icons
                                                                        .visibility
                                                                    : Icons
                                                                        .visibility_off,
                                                                color: Constants
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _bloc.passwordVisible =
                                                                      !_bloc
                                                                          .passwordVisible;
                                                                });
                                                              },
                                                            ),
                                                            controller:
                                                                passwordController,
                                                            cursorColor:
                                                                Constants.white,
                                                            hintText:
                                                                'Enter password',
                                                            color: Color(
                                                                    0xff424242)
                                                                .withOpacity(
                                                                    0.4),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Enter a password";
                                                              } else
                                                                return null;
                                                            },
                                                          ),
                                                          ContainerTextField(
                                                            width: 374,
                                                            controller:
                                                                mobileController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            cursorColor:
                                                                Constants.white,
                                                            hintText:
                                                                'Mobile number',
                                                            color: Color(
                                                                    0xff424242)
                                                                .withOpacity(
                                                                    0.4),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Enter your mobile number";
                                                              } else
                                                                return null;
                                                            },
                                                          ),
                                                          BlocBuilder<
                                                              SignupBloc,
                                                              SignupState>(
                                                            bloc: _bloc,
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is FetchOtpState) {
                                                                return ContainerTextField(
                                                                  width: 374,
                                                                  controller:
                                                                      otpController,
                                                                  cursorColor:
                                                                      Constants
                                                                          .white,
                                                                  hintText:
                                                                      'OTP',
                                                                  color: Color(
                                                                          0xff424242)
                                                                      .withOpacity(
                                                                          0.4),
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return "Enter OTP";
                                                                    } else if (value !=
                                                                        state
                                                                            .otp) {
                                                                      return 'Wrong OTP';
                                                                    } else
                                                                      return null;
                                                                  },
                                                                );
                                                              }
                                                              if (state
                                                                  is PostSignupEvent) {
                                                                return Row(
                                                                  children: [
                                                                    ContainerTextField(
                                                                      // constraints: ,
                                                                      // width:
                                                                      //     374,
                                                                      controller:
                                                                          otpController,
                                                                      cursorColor:
                                                                          Constants
                                                                              .white,
                                                                      hintText:
                                                                          'OTP',
                                                                      color: Color(
                                                                              0xff424242)
                                                                          .withOpacity(
                                                                              0.4),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return "Enter OTP";
                                                                        } else if (value !=
                                                                            _bloc.otp) {
                                                                          return 'Wrong OTP';
                                                                        } else
                                                                          return null;
                                                                      },
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Text(
                                                                          'Resend OTP',
                                                                          style:
                                                                              GoogleFonts.openSans(color: Constants.primaryColor),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                              return SizedBox(
                                                                  height: 50);
                                                            },
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
                                                                  minFontSize:
                                                                      14,
                                                                  align: TextAlign
                                                                      .center,
                                                                  style: GoogleFonts
                                                                      .openSans(
                                                                    fontSize:
                                                                        36,
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
                                                                    minWidth:
                                                                        200,
                                                                    maxWidth:
                                                                        374),
                                                            cursorColor:
                                                                Constants.white,
                                                            color: Color(
                                                                    0xff424242)
                                                                .withOpacity(
                                                                    0.4),
                                                            controller:
                                                                emailController,
                                                            hintText:
                                                                'Email id',
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Enter valid email id";
                                                              } else
                                                                return null;
                                                            },
                                                          ),
                                                          ContainerTextField(
                                                            constraints:
                                                                BoxConstraints(
                                                                    minWidth:
                                                                        200,
                                                                    maxWidth:
                                                                        374),
                                                            cursorColor:
                                                                Constants.white,
                                                            controller:
                                                                cPasswordController,
                                                            obscureText: !_bloc
                                                                .confirmpasswordVisible,
                                                            suffixIcon:
                                                                IconButton(
                                                              icon: Icon(
                                                                _bloc.confirmpasswordVisible
                                                                    ? Icons
                                                                        .visibility
                                                                    : Icons
                                                                        .visibility_off,
                                                                color: Constants
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _bloc.confirmpasswordVisible =
                                                                      !_bloc
                                                                          .confirmpasswordVisible;
                                                                });
                                                              },
                                                            ),
                                                            hintText:
                                                                'Confirm Password',
                                                            color: Color(
                                                                    0xff424242)
                                                                .withOpacity(
                                                                    0.4),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Enter your full name";
                                                              } else if (passwordController
                                                                      .text !=
                                                                  value) {
                                                                return 'Passwords do not match';
                                                              } else
                                                                return null;
                                                            },
                                                          ),
                                                          ContainerTextField(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      minWidth:
                                                                          200,
                                                                      maxWidth:
                                                                          374),
                                                              cursorColor:
                                                                  Constants
                                                                      .white,
                                                              color: Color(
                                                                      0xff424242)
                                                                  .withOpacity(
                                                                      0.4),
                                                              controller:
                                                                  referalCodeController,
                                                              hintText:
                                                                  'Referal Code (Optional)'),
                                                          // SizedBox(height: 12),
                                                          AnimatedButton(
                                                            borderRadius: 8.0,
                                                            height: 58,
                                                            controller:
                                                                animatedButtonController,
                                                            color: Constants
                                                                .primaryColor,
                                                            text: isOTPSent
                                                                ? 'Sign Up'
                                                                : 'Send OTP',
                                                            loadingText:
                                                                'Loading',
                                                            loadedIcon: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white),
                                                            onPressed:
                                                                () async {
                                                              if (!isOTPSent) {
                                                                _bloc.add(SendOTPEvent(
                                                                    mobile: mobileController
                                                                        .text));
                                                                isOTPSent ==
                                                                    true;

                                                                setState(() {});
                                                              } else {
                                                                if (formkey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  _bloc.add(
                                                                    PostSignupEvent(
                                                                      signupDetails:
                                                                          SignupModel(
                                                                        name: fullNameController
                                                                            .text,
                                                                        email: emailController
                                                                            .text,
                                                                        mobile:
                                                                            mobileController.text,
                                                                        password:
                                                                            passwordController.text,
                                                                        accountType:
                                                                            'member',
                                                                        status:
                                                                            'active',
                                                                        referralCode:
                                                                            '',
                                                                        deviceDetails: [],
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  animatedButtonController
                                                                      .reset();
                                                                  AlertFlash().showBasicsFlash(
                                                                      context:
                                                                          context,
                                                                      message:
                                                                          'Please enter the required fields');
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: Constants
                                                                  .white,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            recognizer:
                                                                new TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                            text: 'Login',
                                                            style: GoogleFonts
                                                                .openSans(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
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
                                              foregroundPainter:
                                                  CircleBlurPainter(
                                                      circleWidth: 86,
                                                      blurSigma: 1.0,
                                                      color: Constants
                                                          .primaryColor),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 350,
                                            child: CustomPaint(
                                              foregroundPainter:
                                                  CircleBlurPainter(
                                                      circleWidth: 20,
                                                      blurSigma: 1.0,
                                                      color: Constants
                                                          .primaryColor),
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
              ),
            ),
          );
        },
      ),
    );
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
