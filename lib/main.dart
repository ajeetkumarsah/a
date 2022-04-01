// @dart=2.9

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/addformfield/addform.dart';
import 'package:salessimplify/ui/landing/tabs/activity/CreateActivity.dart';
import 'package:salessimplify/ui/landing/tabs/activity/SearchCompany.dart';
import 'package:salessimplify/ui/landing/tabs/activity/SearchDeals.dart';
import 'package:salessimplify/ui/landing/tabs/activity/SearchLeads.dart';
import 'package:salessimplify/ui/landing/tabs/activity/SearchPeople.dart';
import 'package:salessimplify/ui/landing/tabs/contact/orgDetails.dart';
import 'package:salessimplify/ui/landing/tabs/contact/peopledetails.dart';
import 'package:salessimplify/ui/landing/tabs/deal/adddeal/AddDeal.dart';
import 'package:salessimplify/ui/landing/tabs/deal/deal_details_page.dart';
import 'package:salessimplify/ui/landing/tabs/lead/leaddetails.dart';
import 'package:salessimplify/ui/landing/tabs/settings/additional_settings.dart';
import 'package:salessimplify/ui/landing/tabs/settings/update_user_info.dart';
import 'package:salessimplify/ui/login/LoginPage.dart';
import 'package:salessimplify/ui/register/RegistrationPage.dart';
import 'package:salessimplify/ui/widget/product_details.dart';
import 'package:salessimplify/ui/widgetHelper/SearchWidget.dart';
import 'controller/color.dart';
import 'ui/landing/LandingPage.dart';
import 'ui/landing/tabs/activity/activity_details.dart';
import 'ui/landing/tabs/settings/about_sales_simplify.dart';
import 'ui/landing/tabs/settings/help_feedback.dart';
import 'ui/landing/tabs/settings/refer_earn.dart';
import 'ui/landing/tabs/settings/settings.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Repository(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

//

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: deepblue,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.light,
        /* set Status bar icons color in Android devices.*/
        systemNavigationBarColor: Colors.transparent,
        /* set Status bar icons color in Android devices.*/
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.grey[100],
        accentColorBrightness: Brightness.light,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 16,
            color: Color(0xff4d4d4d),
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            color: Color(0xff4d4d4d),
          ),
          headline1: TextStyle(
              fontSize: 22,
              color: Color(0xff4d4d4d),
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 16,
              color: Color(0xff4d4d4d),
              fontWeight: FontWeight.bold),
          headline3: TextStyle(
            fontSize: 14,
            color: Color(0xff9e9e9e),
          ),
          headline4: TextStyle(
            fontSize: 12,
            color: Color(0xff9e9e9e),
          ),
          button: TextStyle(
            fontSize: 16,
            color: Color(0xffffffff),
          ),
          caption: TextStyle(
            fontSize: 12,
            color: Color(0xff000000),
          ),
        ),
      ),
      home: FutureBuilder(
        future: _isLoggedIn(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? (snapshot.data as bool)
                  ? LandingPage()
                  : LoginPage()
              : ProgressBarScreen();
        },
      ),
      routes: {
        LoginPage.ROUTE_LOGIN_PAGE: (_) => LoginPage(),
        LandingPage.ROUTE_LANDING_PAGE: (_) => LandingPage(),
        RegistrationPage.ROUTE_REGISTRATION_PAGE: (_) => RegistrationPage(),
        LeadsDetails.ROUTE_LEAD_DETAILS: (_) => LeadsDetails(),
        AddForm.ROUTE_ADD_FORM: (_) => AddForm(),
        SearchWidget.ROUTE_SEARCH: (_) => SearchWidget(),
        PeopleDetails.ROUTE_LEAD_DETAILS: (_) => PeopleDetails(),
        CreateActivity.ROUTE_CREATE_ACTIVITY: (_) => CreateActivity(),
        SearchDeals.ROUTE_SEARCH_DEAL_ACTIVITY: (_) => SearchDeals(),
        SearchPeople.ROUTE_SEARCH_PEOPLE_ACTIVITY: (_) => SearchPeople(),
        SearchLeads.ROUTE_SEARCH_LEAD_ACTIVITY: (_) => SearchLeads(),
        SearchCompany.ROUTE_SEARCH_COMPANY_ACTIVITY: (_) => SearchCompany(),
        AddDeal.ROUTE_ADD_DEAL: (_) => AddDeal(),
        SettingsPage.ROUTE_SETTINGS_PAGE: (_) => SettingsPage(),
        OrgDetails.ROUTE_ORG_DETAILS: (_) => OrgDetails(),
        AboutSalesSimplify.routeName: (_) => AboutSalesSimplify(),
        HelpFeedback.routeName: (_) => HelpFeedback(),
        RefersAndEarn.routeName: (_) => RefersAndEarn(),
        AdditionalSettings.routeName: (_) => AdditionalSettings(),
        UpdateUserInfo.routeName: (_) => UpdateUserInfo(),
        ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
        DealDetailsPage.routeName: (_) => DealDetailsPage(),
        ActivityDetailsPage.routeName: (_) => ActivityDetailsPage(),
      },
    );
  }

  Future<bool> _isLoggedIn() async {
    /*var session = await Firebase.initializeApp().whenComplete(() {});
    return FirebaseAuth.instance.currentUser != null;*/
    return await SessionManager.getInstance().getToken() != null;
  }
}

class ProgressBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
