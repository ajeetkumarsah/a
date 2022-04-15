import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int cupertinoTabBarIIIValue = 0;
  int cupertinoTabBarIIIValueGetter() => cupertinoTabBarIIIValue;
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
