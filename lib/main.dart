import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/home/home_screen.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WTF',
      debugShowCheckedModeBanner: false,
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
      home: const LandingScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LandingScreen.routeName: (context) => const LandingScreen(),
      },
    );
  }
}
