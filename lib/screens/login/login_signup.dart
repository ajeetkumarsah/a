import 'package:flutter/material.dart';
import 'package:wtf_web/screens/login/login.dart';
import 'package:wtf_web/screens/signup/signup.dart';

class LoginSignupSwitcher extends StatefulWidget {
  @override
  _LoginSignupSwitcherState createState() => _LoginSignupSwitcherState();
}

bool isSignup = false;

class _LoginSignupSwitcherState extends State<LoginSignupSwitcher> {
  // PageController _controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isSignup ? SignupScreen() : LoginScreen(),
    );
    // PageView(
    //   controller: _controller,
    //   children: [LoginScreen(), SignupScreen()],
    // );
  }
}
