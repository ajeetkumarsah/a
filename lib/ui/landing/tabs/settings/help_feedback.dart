import 'package:flutter/material.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';

class HelpFeedback extends StatefulWidget {
  const HelpFeedback({Key? key}) : super(key: key);
  static String routeName = "HelpFeedback";

  @override
  _HelpFeedbackState createState() => _HelpFeedbackState();
}

class _HelpFeedbackState extends State<HelpFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help & Feedback',
      ),
      body: emptyListHelper.getEmptyList(EmptyListHelper.helpFeedback, context),
      // floatingActionButton: CustomFloatingButton(
      //   icon: Icon(
      //     Boxicons.bxs_bot,
      //     size: 30,
      //   ),
      //   onPressed: () {},
      // ),
    );
  }
}
