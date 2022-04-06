import 'package:flutter/material.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    bool isUserLoggedIn =
        await SessionManager.getInstance().getIsUserLoggedIn() != null
            ? await SessionManager.getInstance().getIsUserLoggedIn()
            : false;
    if (isUserLoggedIn) {
      //user found
      Navigator.pushReplacementNamed(context, LandingScreen.routeName,
          arguments: LandingPageArgumnet(userLoggedIn: true));
    } else {
      //user not found
      Navigator.pushReplacementNamed(context, LandingScreen.routeName,
          arguments: LandingPageArgumnet(userLoggedIn: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.black,
      body: Center(
        child: CustomLoader(),
      ),
    );
  }
}
