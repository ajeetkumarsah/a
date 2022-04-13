import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf_web/controller/menu_controller.dart';
import 'package:wtf_web/controller/view_controller.dart';
import 'package:wtf_web/flavor/flavor_banner.dart';
import 'package:wtf_web/screens/about_us/about_us.dart';
import 'package:wtf_web/screens/fitness/fitness_screen.dart';
import 'package:wtf_web/screens/gyms/gyms.dart';
import 'package:wtf_web/screens/home/home_screen.dart';
import 'package:wtf_web/screens/landing/argument/argument.dart';
import 'package:wtf_web/screens/landing/components/header.dart';
import 'package:wtf_web/screens/login/login.dart';
import 'package:wtf_web/screens/login/login_signup.dart';
import 'package:wtf_web/screens/order_summary/order_summary.dart';
import 'package:wtf_web/screens/profile/profile.dart';
import 'package:wtf_web/screens/signup/signup.dart';
import 'package:wtf_web/screens/widgets/animated_pointer.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/const.dart';
import '../nutrition/nutrition.dart';
import '../partner/partner.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = '/landingScreen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  MenuController _controller = Get.put(MenuController());
  late ScrollController _scrollController;
  SessionManager sessionManager = SessionManager.getInstance();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    pointerSizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    pointerAnimation = CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent:
            Tween<double>(begin: 0, end: 1).animate(pointerSizeController!));

    super.initState();
  }

  bool scroll = false;
  void _scrollListener() {
    setState(() {
      var index = _scrollController.offset.round() + 1;
      print('$index');
      if (index <= 5) {
        scroll = false;
      } else {
        scroll = true;
      }
    });
  }

  Offset? pointerOffset;
  AnimationController? pointerSizeController;
  Animation<double>? pointerAnimation;

  void togglePointerSize(bool hovering) async {
    if (hovering) {
      pointerSizeController!.forward();
    } else
      pointerSizeController!.reverse();
  }

  @override
  Widget build(BuildContext context) {
    LandingPageArgumnet args =
        ModalRoute.of(context)!.settings.arguments as LandingPageArgumnet;
    List<Widget> pages = [
      const FitnessCenter(),
      const NutritionScreen(),
      const GymScreen(),
      const PartnerScreen(),
      // const Membership(),
      const AboutUsScreen(),
      // const MembershipDetails(),
      // const StudiosScreen(),
      args.userLoggedIn != null && args.userLoggedIn == true
          ? const ProfileScreen()
          : LoginSignupSwitcher(),
    ];
    return Scaffold(
      key: _controller.scaffoldkey,
      backgroundColor: Constants.black,
      // drawer: SideMenu(),
      body: Stack(
        // alignment: Alignment.center,

        children: [
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              child: StreamBuilder<int?>(
                stream: viewController.getBaseListStream,
                initialData: args.userLoggedIn ? pages.length - 1 : 0,
                builder: (context, snapshot) {
                  return pages[snapshot.data!];
                },
              ),
            ),
          ),
          Header(
            scroll: scroll,
            isLoggedIn: args.userLoggedIn,
          ),
          if (pointerOffset != null) ...[
            AnimatedBuilder(
                animation: pointerSizeController!,
                builder: (context, snapshot) {
                  return AnimatedPointer(
                    pointerOffset: pointerOffset!,
                    radius: 45 + 100 * pointerAnimation!.value,
                  );
                }),
            AnimatedPointer(
              pointerOffset: pointerOffset!,
              movementDuration: const Duration(milliseconds: 200),
              radius: 10,
            )
          ]
        ],
      ),
    );
  }
}
