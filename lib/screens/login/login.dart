import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/login/bloc/login_bloc.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    return BlocProvider(
      create: (context) => LoginBloc()
        ..add(
          PostLogInEvent(
            loginDetails: LoginModel(
                email: 'kukreti12.naresh@gmail.com', password: 'password'),
          ),
        ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          // print('Calling Function===========>');
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
                                            // controller: ,
                                            color: Color(0xff424242)
                                                .withOpacity(0.4),
                                            hintText: 'Enter Email'),
                                        ContainerTextField(
                                          // controller: ,
                                          cursorColor: Constants.white,
                                          hintText: 'Enter password',
                                          color: Color(0xff424242)
                                              .withOpacity(0.4),
                                        ),
                                        // ContainerTextField(
                                        //   cursorColor: Constants.white,
                                        //   hintText: 'OTP',
                                        //   color: Color(0xff424242).withOpacity(0.4),
                                        // ),

                                        SizedBox(height: 30),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 420,
                                            height: 58,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 32),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: Constants.primaryColor),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.0),
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
                                        Container(
                                          width: 420,
                                          height: 58,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 32),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            border: Border.all(
                                                width: 2,
                                                color: Constants.primaryColor),
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

                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Dont have an account?  ',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color: Constants.white,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Signup',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: Constants.redIconColor,
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
                              ],
                            ),
                          ),
                          if (!isMobile())
                            BootstrapCol(
                              sizes: 'col-12 col-md-6 col-sm-12',
                              child: Container(
                                // margin: EdgeInsets.only(top: isDesktop() ? 80 : 150),
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
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
