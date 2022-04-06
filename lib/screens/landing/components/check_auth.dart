import 'package:flutter/material.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/login/login.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/session_manager/session_manager.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  Future<bool> _isLoggedIn() async {
    return await SessionManager.getInstance().getIsUserLoggedIn() != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isLoggedIn(),
      builder: (ctx, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? (snapshot.data as bool)
                ? LandingScreen()
                : LoginScreen()
            : CustomLoader();
      },
    );
  }
}
