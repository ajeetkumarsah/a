import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf_web/controller/menu_controller.dart';
import 'package:wtf_web/controller/view_controller.dart';
import 'package:wtf_web/flavor/flavor_banner.dart';
import 'package:wtf_web/screens/about_us/about_us.dart';
import 'package:wtf_web/screens/fitness/fitness_screen.dart';
import 'package:wtf_web/screens/gyms/gyms.dart';
import 'package:wtf_web/screens/landing/components/header.dart';
import 'package:wtf_web/screens/live_classes/live_classes.dart';
import 'package:wtf_web/screens/login/login.dart';
import 'package:wtf_web/screens/membership/membership.dart';
import 'package:wtf_web/screens/signup/signup.dart';
import 'package:wtf_web/screens/thanks/thanks.dart';
import 'package:wtf_web/utils/const.dart';
import '../home/home_screen.dart';
import '../nutrition/nutrition.dart';
import '../partner/partner.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = '/landingScreen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final MenuController _controller = Get.put(MenuController());
  late ScrollController _scrollController;
  List<Widget> pages = [
    const SignupScreen(),
    const NutritionScreen(),
    const GymScreen(),
    const PartnerScreen(),
    // const Membership(),
    const AboutUsScreen(),
    // const MembershipDetails(),
    // const StudiosScreen(),
  ];
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
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
                  initialData: 0,
                  builder: (context, snapshot) {
                    return pages[snapshot.data!];
                  },
                ),
              ),
            ),
            Header(
              scroll: scroll,
            ),
          ],
        ),
      ),
    );
  }
}
