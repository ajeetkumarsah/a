import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/gym_details/gym_details.dart';
import 'package:wtf_web/screens/home/home_screen.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/login/login.dart';
import 'package:wtf_web/screens/onboarding/onboarding.dart';
import 'package:wtf_web/screens/profile/profile.dart';
import 'package:wtf_web/screens/signup/signup.dart';
import 'package:wtf_web/screens/splash/splash_screen.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/session_manager/session_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    SessionManager _sessionManager = SessionManager.getInstance();
    return GetMaterialApp(
      title: 'WTF',
      debugShowCheckedModeBanner: false,
      // initialRoute: LoginScreen.routeName,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black12,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: const Color(0xFFE5E5E5),
          dividerColor: Colors.white54,
          // textTheme: GoogleFonts.montserrat(),
          textTheme: GoogleFonts.montserratTextTheme(),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              // This will be applied to the "back" icon
              iconTheme: IconThemeData(color: Colors.black),
              // This will be applied to the action icon buttons that locates on the right side
              actionsIconTheme: IconThemeData(color: Colors.black),
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarDividerColor: Colors.white,
              ),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15))),
      home: SplashScreen(),

      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LandingScreen.routeName: (context) => const LandingScreen(),
        GymDetails.routeName: (context) => const GymDetails(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
      },
    );
  }
}
