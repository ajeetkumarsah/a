import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/custom_switch.dart';
import 'package:salessimplify/ui/widgetHelper/custom_tag.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';

class AdditionalSettings extends StatefulWidget {
  static String routeName = "AdditionalSettings";
  const AdditionalSettings({Key? key}) : super(key: key);

  @override
  _AdditionalSettingsState createState() => _AdditionalSettingsState();
}

class _AdditionalSettingsState extends State<AdditionalSettings> {
  bool isActivityLostReasonEnabled = false;
  DateTime? selectedDate;
  @override
  void initState() {
    setLostReasonFlag();
    super.initState();
  }

  setLostReasonFlag() async {
    isActivityLostReasonEnabled =
        await SessionManager.getInstance().activityLostReasonSetting();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Additional Settings'),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Activity Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            CustomSwitchTiles(
              label: 'Activity outcome',
              isChecked: isActivityLostReasonEnabled,
              onChanged: (value) async {
                setState(() {
                  isActivityLostReasonEnabled = !isActivityLostReasonEnabled;
                  SessionManager.getInstance()
                      .setActivityLostReasonSetting(value);
                  print("value : $value");
                });
                await Repository.getInstance()
                    .updateActivityLostReasonSettings(value);
              },
              subLabel: '',
              title: 'title',
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => Navigator.push(
      //         context, CupertinoPageRoute(builder: (_) => HomeScreen())),
      //     child: Icon(Icons.wysiwyg_sharp, color: blueColor)),
    );
  }
}
