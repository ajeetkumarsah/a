import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/app_helper.dart';
import 'package:salessimplify/models/Profile.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:salessimplify/ui/landing/tabs/activity/UpComing.dart';
import 'package:salessimplify/ui/landing/tabs/settings/help_feedback.dart';
import 'package:salessimplify/ui/landing/tabs/settings/refer_earn.dart';
import 'package:salessimplify/ui/landing/tabs/settings/update_user_info.dart';
import 'package:salessimplify/ui/landing/tabs/settings/widget/empty_settings.dart';
import 'package:salessimplify/ui/login/LoginPage.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alert_dialog.dart';
import 'package:salessimplify/ui/widgetHelper/logo_appbar.dart';
import 'package:salessimplify/util/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'about_sales_simplify.dart';
import 'additional_settings.dart';
import 'arguments/profile_arguments.dart';

class SettingsPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static String ROUTE_SETTINGS_PAGE = "route/SettingsPage";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // SettingsController controllerx = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: LogoAppBar(
        title: Center(
          child: Text('Settings',
              style: TextStyle(
                  color: white, fontSize: 28, fontWeight: FontWeight.bold)),
        ),
      ),
      body: FutureBuilder(
        future: Repository.getInstance().curentUserProfile(),
        builder: (context, snapshot) {
          Profile? data;
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as Profile;
          }

          return snapshot.connectionState == ConnectionState.done
              ? ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    new Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [blueColor, deepblue],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 50, right: 25, left: 25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    height: 140.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          data?.fullName ?? 'Full Name',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Shimmer.fromColors(
                                          baseColor: black,
                                          highlightColor: white,
                                          loop: 1,
                                          child: Text(
                                            data?.company ?? 'Company',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        // Obx(() =>
                                        //     Text('${controllerx.log2.value}')),
                                        // RaisedButton(
                                        //   child: Text('Add +1'),
                                        //   onPressed: controllerx.change,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                              context, UpdateUserInfo.routeName,
                                              arguments:
                                                  ProfileArguments(data: data))
                                          .then((value) => setState(() {})),
                                      child: DecoratedBox(
                                        decoration: ShapeDecoration(
                                          shape: CircleBorder(),
                                          image: data?.avatar == null
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/user.png',
                                                  ),
                                                )
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    data?.avatar ?? '',
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 60, right: 40),
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                        colors: [lightBlue, deepblue],
                                      ),
                                    ),
                                    child: GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                                context,
                                                UpdateUserInfo.routeName,
                                                arguments: ProfileArguments(
                                                    data: data))
                                            .then((value) => setState(() {})),
                                        child: Center(
                                            child: Icon(Icons.edit,
                                                color: white, size: 16))),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _settingsItem(
                                      title: 'Email',
                                      icon: Boxicons.bx_mail_send,
                                      subtitle: data?.email ?? 'Email',
                                      onTap: () {
                                        if (data?.email != null) {
                                          Utils.launchUrl(
                                              'mailto:${data!.email}');
                                        }
                                      },
                                    ),
                                    _divider(),
                                    _settingsItem(
                                      title: 'Phone',
                                      icon: Boxicons.bxs_phone_call,
                                      subtitle: data?.phone ?? 'Phone',
                                      onTap: () {
                                        if (data?.phone != null) {
                                          Utils.launchUrl(
                                              "tel://${data!.phone}");
                                        }
                                      },
                                    ),
                                    _divider(),
                                    _settingsItem(
                                      title: 'Website',
                                      icon: Boxicons.bx_world,
                                      subtitle: data?.website ?? 'Website',
                                      onTap: () =>
                                          CustomAlertDialog.showAlertDialog(
                                        context: context,
                                        title: Text("Are you sure?",
                                            textAlign: TextAlign.center),
                                        content: Text(
                                            "Do you want to launch ${data!.website}?",
                                            textAlign: TextAlign.center),
                                        onPressed: () {
                                          if (data?.website != null) {
                                            Utils.launchUrl(data!.website);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // _settingsItem(
                                    //   title: 'Refer & Earn',
                                    //   icon: Boxicons.bxs_coupon,
                                    //   subtitle:
                                    //       'Invite friends and earn rewards',
                                    //   onTap: () => Navigator.pushNamed(
                                    //       context, RefersAndEarn.routeName),
                                    // ),
                                    // _divider(),
                                    _settingsItem(
                                      title: 'About Sales Simplify',
                                      icon: Icons.info_rounded,
                                      onTap: () => Navigator.pushNamed(context,
                                          AboutSalesSimplify.routeName),
                                    ),
                                    _divider(),
                                    _settingsItem(
                                      title: 'Help and Feedback',
                                      icon: Boxicons.bxs_help_circle,
                                      onTap: () => Navigator.pushNamed(
                                          context, HelpFeedback.routeName),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // _settingsItem(
                                    //   title: 'Synchronize Data',
                                    //   icon: Icons.person_add,
                                    // ),
                                    // _divider(),
                                    // _settingsItem(
                                    //   title: 'Import Contacts',
                                    //   icon: Boxicons.bxs_contact,
                                    // ),
                                    // _divider(),

                                    _settingsItem(
                                      title: 'Additional Settings',
                                      icon: Icons.settings,
                                      onTap: () => Navigator.pushNamed(context,
                                          AdditionalSettings.routeName),
                                    ),
                                    _divider(),

                                    _settingsItem(
                                      title: 'Log Out',
                                      icon: Boxicons.bx_log_out,
                                      onTap: () {
                                        CustomAlertDialog.showAlertDialog(
                                            context: context,
                                            title: Text("Log Out?",
                                                textAlign: TextAlign.left),
                                            content: Text(
                                                "Are you sure you want to Logout?",
                                                textAlign: TextAlign.left),
                                            onPressed: () async {
                                              AppHelper().logout(context);
                                              // context
                                              //     .read<Repository>()
                                              //     .isOtpSent = false;
                                              // Upcoming.isAttched = false;
                                              // await SessionManager.getInstance()
                                              //     .clearPreferences();
                                              // Navigator.popAndPushNamed(
                                              //   context,
                                              //   LoginPage.ROUTE_LOGIN_PAGE,
                                              // );
                                            });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : EmptySettings();
        },
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(height: 0.5, color: Colors.grey[200]),
    );
  }

  _settingsItem({
    required String title,
    String? subtitle,
    IconData? icon,
    Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: appColor.blue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: Icon(
            icon == null ? Boxicons.bxs_image_add : icon,
            color: appColor.blue,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: black, fontWeight: FontWeight.w400),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: black, fontWeight: FontWeight.w300),
            )
          : null,
    );
  }
}
