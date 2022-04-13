import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/package/animated_button.dart';
import 'package:wtf_web/screens/landing/argument/argument.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/login/bloc/login_bloc.dart';
import 'package:wtf_web/screens/signup/signup.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/alert_flash.dart';
import 'package:wtf_web/screens/widgets/container_text_field.dart';
import 'package:wtf_web/utils/const.dart';
import 'package:wtf_web/utils/custom_painter.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final AnimatedButtonController animatedButtonController =
      AnimatedButtonController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    _launchURL() async {
      const url =
          'https://play.google.com/store/apps/details?id=com.wtf.member&hl=en_US&gl=US';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is LoginStatusState) {
            if (state.isSuccess) {
              animatedButtonController.completed();
              animatedButtonController.reset();
              AlertFlash().showBasicsFlash(
                context: context,
                message: state.msg,
                backgroundColor: Constants.white,
                textColor: Constants.black,
              );
              WidgetsBinding.instance!.addPostFrameCallback(
                (_) {
                  if (true) {
                    Navigator.pushReplacementNamed(
                        context, LandingScreen.routeName,
                        arguments: LandingPageArgumnet(userLoggedIn: true));
                  }
                },
              );
            } else {
              animatedButtonController.reset();
              AlertFlash().showMessage(message: state.msg, context: context);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                BootstrapContainer(
                  fluid: true,
                  decoration: const BoxDecoration(color: Constants.black),
                  padding: EdgeInsets.all(0),
                  children: [
                    Container(
                      height: height,
                      padding: EdgeInsets.only(top: 90),
                      decoration: BoxDecoration(
                        color: Constants.black,
                        gradient: LinearGradient(
                          begin: isDesktop()
                              ? Alignment.centerLeft
                              : Alignment.bottomCenter,
                          end: isDesktop()
                              ? Alignment.centerRight
                              : Alignment.topCenter,
                          colors: [
                            Constants.black,
                            Color(0xFFde0000).withOpacity(0.7),
                          ],
                          stops: [0.1, 1],
                        ),
                      ),
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(top: isDesktop() ? 80 : 150),
                      child: BootstrapRow(
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-6 col-sm-12',
                            child: Stack(
                              // alignment: Alignment.center,
                              children: [
                                Positioned(
                                  bottom: 20,
                                  left: 140,
                                  child: CustomPaint(
                                    foregroundPainter: CircleBlurPainter(
                                        circleWidth: 64,
                                        blurSigma: 2.0,
                                        color: Constants.primaryColor),
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  right: 140,
                                  child: CustomPaint(
                                    foregroundPainter: CircleBlurPainter(
                                        circleWidth: 84,
                                        blurSigma: 1.0,
                                        color: Constants.primaryColor),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 438,
                                    height: 581,
                                    margin: EdgeInsets.only(
                                        top: isDesktop() ? 30 : 60),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFffffff).withOpacity(0.1),
                                          Color(0xFFFFFFFF).withOpacity(0.05),
                                        ],
                                        stops: [0.1, 1],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Form(
                                      key: formkey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AdaptiveText(
                                                text: 'Welcome Back',
                                                minFontSize: 14,
                                                align: TextAlign.center,
                                                style: GoogleFonts.openSans(
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  color: Constants.white,
                                                ),
                                              ),
                                              // Image.asset('assets/logo.png', height: 0),
                                            ],
                                          ),

                                          SizedBox(height: 30),
                                          ContainerTextField(
                                            cursorColor: Constants.white,
                                            controller: emailController,
                                            color: Color(0xff424242)
                                                .withOpacity(0.4),
                                            hintText: 'Enter Email',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter a valid email id";
                                              } else
                                                return null;
                                            },
                                          ),
                                          ContainerTextField(
                                            controller: passwordController,
                                            cursorColor: Constants.white,
                                            obscureText: !_bloc.passwordVisible,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _bloc.passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Constants.white,
                                                size: 18,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _bloc.passwordVisible =
                                                      !_bloc.passwordVisible;
                                                });
                                              },
                                            ),
                                            hintText: 'Enter password',
                                            color: Color(0xff424242)
                                                .withOpacity(0.4),
                                            onChanged: (value) {
                                              formkey.currentState!.validate();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter a password";
                                              } else
                                                return null;
                                            },
                                          ),

                                          SizedBox(height: 30),
                                          AnimatedButton(
                                            borderRadius: 8.0,
                                            height: 58,
                                            controller:
                                                animatedButtonController,
                                            color: Constants.primaryColor,
                                            text: 'Log in',
                                            loadingText: 'Loading',
                                            loadedIcon: Icon(Icons.check,
                                                color: Colors.white),
                                            onPressed: () async {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                _bloc.add(
                                                  OnLoginEvent(
                                                      firstData:
                                                          emailController.text,
                                                      authenticator:
                                                          passwordController
                                                              .text),
                                                );
                                              } else {
                                                animatedButtonController
                                                    .reset();
                                                if (emailController
                                                    .text.isEmpty) {
                                                  AlertFlash().showMessage(
                                                      message: 'Enter email!',
                                                      context: context);
                                                } else if (passwordController
                                                    .text.isEmpty) {
                                                  AlertFlash().showMessage(
                                                      message:
                                                          'Enter password!',
                                                      context: context);
                                                } else
                                                  AlertFlash().showMessage(
                                                      message:
                                                          'Wrong email or password!',
                                                      context: context);
                                              }
                                            },
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     print('Login call=======>');

                                          //   if (formkey.currentState!
                                          //       .validate()) {
                                          //     _bloc.add(
                                          //       OnLoginEvent(
                                          //           firstData:
                                          //               emailController.text,
                                          //           authenticator:
                                          //               passwordController
                                          //                   .text),
                                          //     );
                                          //   } else {
                                          //     Get.snackbar(
                                          //       "Wrong email or password!",
                                          //       "Please enter the correct email and password",
                                          //       colorText: Colors.white,
                                          //       snackPosition:
                                          //           SnackPosition.BOTTOM,
                                          //     );
                                          //   }
                                          // },
                                          //   child: Container(
                                          //     width: 420,
                                          //     height: 58,
                                          //     margin: EdgeInsets.symmetric(
                                          //         horizontal: 32),
                                          //     decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 6.0),
                                          //         color:
                                          //             Constants.primaryColor),
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 12.0),
                                          //     child: Center(
                                          //       child: AdaptiveText(
                                          //         text: 'Login',
                                          //         minFontSize: 14,
                                          //         align: TextAlign.center,
                                          //         style: GoogleFonts.openSans(
                                          //           fontSize: 18,
                                          //           fontWeight: FontWeight.w600,
                                          //           fontStyle: FontStyle.normal,
                                          //           color: Constants.white,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          GestureDetector(
                                            onTap: () {
                                              AlertFlash().showBasicsFlash(
                                                  context: context,
                                                  message: 'Coming soon!');
                                              // AlertFlash().showMessage(
                                              //     message: 'Coming soon!',
                                              //     context: context);
                                            },
                                            child: Container(
                                              width: 420,
                                              height: 58,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 32),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                border: Border.all(
                                                    width: 2,
                                                    color:
                                                        Constants.primaryColor),
                                                // color: Color(0xff424242).withOpacity(0.4),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Center(
                                                child: AdaptiveText(
                                                  text: 'Login with Email',
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

                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Dont have an account?  ',
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: Constants.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  recognizer:
                                                      new TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              SignupScreen
                                                                  .routeName);
                                                        },
                                                  text: 'Signup',
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    color:
                                                        Constants.redIconColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // AdaptiveText(
                                          //   text: 'Dont have an account? Signup',
                                          //   minFontSize: 14,
                                          //   align: TextAlign.center,
                                          //   style: GoogleFonts.openSans(
                                          //     fontSize: 14,
                                          //     fontWeight: FontWeight.w400,
                                          //     fontStyle: FontStyle.normal,
                                          //     color: Constants.white,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isMobile())
                            BootstrapCol(
                              sizes: 'col-12 col-md-6 col-sm-12',
                              child: Container(
                                // margin: EdgeInsets.only(top: isDesktop() ? 80 : 150),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                      child: CustomPaint(
                                        foregroundPainter: CircleBlurPainter(
                                            circleWidth: 30,
                                            blurSigma: 3.0,
                                            color: Constants.primaryColor),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          'assets/login/banner.png'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _launchURL();
                                          },
                                          child: Image.asset(
                                            'assets/login/googlePlay.png',
                                            height: 50,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                            'assets/login/appStore.png',
                                            height: 50,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
