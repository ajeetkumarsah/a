// ignore_for_file: unused_local_variable

import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/onboarding/onboarding.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/const.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  int cupertinoTabBarIIIValue = 0;
  int cupertinoTabBarIIIValueGetter() => cupertinoTabBarIIIValue;
  @override
  Widget build(BuildContext context) {
    SessionManager sessionManager = SessionManager.getInstance();

    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(48, 120, 48, 100),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-5',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 789,
                        width: 1080,
                        margin: EdgeInsets.only(top: 54),
                        // padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xff922224),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AdaptiveText(
                              text: 'Update',
                              minFontSize: 14,
                              align: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                            AdaptiveText(
                              text: 'Karanjeet Singh dhillon',
                              minFontSize: 14,
                              align: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () async {
                            await sessionManager.clearPreferences();
                            // Navigator.pushReplacementNamed(
                            //     context, OnboardingScreen.routeName);
                            Navigator.pushReplacementNamed(
                                context, LandingScreen.routeName,
                                arguments:
                                    LandingPageArgumnet(userLoggedIn: false));
                            print('======>cleared');
                          },
                          child: Container(
                            height: 108,
                            width: 108,
                            decoration: BoxDecoration(
                                color: Constants.white,
                                borderRadius: BorderRadius.circular(90)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-7',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 40),
                  AdaptiveText(
                    text: 'My Subscription',
                    minFontSize: 14,
                    align: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Constants.white,
                    ),
                  ),
                  Container(
                    height: 56,
                    width: 664,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.only(top: 33),
                    // padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff922224),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CupertinoTabBar.CupertinoTabBar(
                          const Color(0xFF922224),
                          Constants.black,
                          [
                            const Text(
                              "Regular",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.75,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProRounded",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Addons",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.75,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProRounded",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Live",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.75,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProRounded",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Events",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.75,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProRounded",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          cupertinoTabBarIIIValueGetter,
                          (int index) {
                            setState(() {
                              cupertinoTabBarIIIValue = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(4.0),
                          allowExpand: true,
                          useShadow: false,
                          innerHorizontalPadding: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 176,
                    width: 664,
                    // margin: EdgeInsets.only(top: 33),
                    // padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Constants.cardBlackLight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 176,
                    width: 664,
                    // margin: EdgeInsets.only(top: 33),
                    // padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Constants.cardBlackLight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
