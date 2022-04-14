// ignore_for_file: unused_local_variable

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/member_info.dart';
import 'package:wtf_web/model/user_profile.dart';
import 'package:wtf_web/screens/landing/argument/argument.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/const.dart';

class ProfileDetails extends StatefulWidget {
  final UserProfile userInfo;
  const ProfileDetails({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  int cupertinoTabBarIIIValue = 0;
  int cupertinoTabBarIIIValueGetter() => cupertinoTabBarIIIValue;
  int _selectedIndex = 0;

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
                        padding: EdgeInsets.only(top: 160, bottom: 52),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xff922224),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
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
                              text: '${widget.userInfo.name}',
                              minFontSize: 14,
                              align: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                            Spacer(),
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 14,
                              runSpacing: 14,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                profileTabItem(
                                  title: 'My Profile',
                                  index: 0,
                                  leading:
                                      Image.asset('assets/profile/profile.png'),
                                ),
                                profileTabItem(
                                  title: 'Shift Trainer',
                                  index: 1,
                                  leading:
                                      Image.asset('assets/profile/trainer.png'),
                                ),
                                profileTabItem(
                                  title: 'Notifications',
                                  index: 2,
                                  leading: Image.asset(
                                      'assets/profile/notification.png'),
                                ),
                                profileTabItem(
                                  title: 'Subscription',
                                  index: 3,
                                  leading: Image.asset(
                                      'assets/profile/subscription.png'),
                                ),
                                profileTabItem(
                                  title: 'Transactions',
                                  index: 4,
                                  leading: Image.asset(
                                      'assets/profile/transaction.png'),
                                ),
                                profileTabItem(
                                  title: 'Logout',
                                  index: 5,
                                  leading:
                                      Image.asset('assets/profile/logout.png'),
                                ),
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () async {
                            await sessionManager.clearPreferences();

                            Navigator.pushReplacementNamed(
                                context, LandingScreen.routeName,
                                arguments:
                                    LandingPageArgumnet(userLoggedIn: false));
                            print('======>cleared');
                          },
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Constants.white,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/profile/man.png')),
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

  Widget profileTabItem(
      {required String title, Widget? leading, required int index}) {
    return GestureDetector(
      onTap: () {
        //
        _selectedIndex = index;
        setState(() {});
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: index == _selectedIndex ? Color(0xffE25252) : null,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            leading != null
                ? leading
                : Icon(Icons.person, color: Constants.white),
            SizedBox(width: 12),
            AdaptiveText(
              text: title,
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
