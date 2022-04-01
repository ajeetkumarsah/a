import 'package:flutter/material.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';

class RefersAndEarn extends StatefulWidget {
  const RefersAndEarn({Key? key}) : super(key: key);
  static String routeName = "RefersAndEarn";

  @override
  _RefersAndEarnState createState() => _RefersAndEarnState();
}

class _RefersAndEarnState extends State<RefersAndEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Refers and Earn',
      ),
      body:
          emptyListHelper.getEmptyList(EmptyListHelper.refersAndEarn, context),
    );
  }
}
