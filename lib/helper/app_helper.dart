import 'package:flutter/widgets.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/tabs/activity/Completed.dart';
import 'package:salessimplify/ui/landing/tabs/activity/Overdue.dart';
import 'package:salessimplify/ui/landing/tabs/activity/UpComing.dart';
import 'package:salessimplify/ui/landing/tabs/contact/organization.dart';
import 'package:salessimplify/ui/landing/tabs/contact/people.dart';
import 'package:salessimplify/ui/landing/tabs/lead/activeleads.dart';
import 'package:salessimplify/ui/landing/tabs/lead/junklead.dart';
import 'package:salessimplify/ui/login/LoginPage.dart';
import 'package:provider/provider.dart';

class AppHelper {
  void logout(BuildContext context) async {
    context.read<Repository>().isOtpSent = false;
    Upcoming.isAttched = false;
    Overdue.isAttched = false;
    Completed.isAttched = false;
    ActiveLeads.isAttched = false;
    JunkLead.isAttched = false;
    People.isAttched = false;
    Organization.isAttched = false;
  
    await SessionManager.getInstance().clearPreferences();
    Navigator.popAndPushNamed(
      context,
      LoginPage.ROUTE_LOGIN_PAGE,
    );
  }
}
