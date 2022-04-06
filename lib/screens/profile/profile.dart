import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wtf_web/screens/profile/profile_details.dart';
import 'package:wtf_web/screens/thanks/summary.dart';
import 'package:wtf_web/screens/thanks/redeem_continue.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/utils/const.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [const ProfileDetails()],
    );
  }
}
