import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/ActivityData.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/models/activity_lost_reason_settings.dart';
import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/addformfield/addform.dart';
import 'package:salessimplify/ui/landing/tabs/activity/ActivityTab.dart';
import 'package:salessimplify/ui/landing/tabs/activity/CreateActivity.dart';
import 'package:salessimplify/ui/landing/tabs/contact/contactpage.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/landing/tabs/deal/adddeal/AddDeal.dart';
import 'package:salessimplify/ui/landing/tabs/lead/leadpage.dart';
import 'package:salessimplify/ui/widgetHelper/custom_floating_button.dart';
import 'tabs/settings/settings.dart';

class LandingPage extends StatefulWidget {
  static String ROUTE_LANDING_PAGE = "route/landingPage";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  bool reload = false;
  late final PagingController<int, ActivityData> pagingController;
  final PagingController<int, ActivityData> overduePagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, ActivityData> completedController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Leads> leadpagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Leads> peopleController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Leads> junkController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Company> companyController =
      PagingController(firstPageKey: 1);
  late DealsPage _mDealsPage;
  late SettingsPage settings;

  @override
  void initState() {
    super.initState();
    pagingController = PagingController(firstPageKey: 1);
    updateActivityLostReason();
    getActivtyData();
    _mDealsPage = DealsPage();
    settings = SettingsPage();
  }

  @override
  void dispose() {
    pagingController.dispose();
    overduePagingController.dispose();
    completedController.dispose();
    leadpagingController.dispose();
    peopleController.dispose();
    junkController.dispose();
    companyController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pagingController.refresh();
  }

  Widget pageChooser() {
    switch (_selectedIndex) {
      case 0:
        return ActivityTab(
          pagingController: pagingController,
          completedController: completedController,
          overduePagingController: overduePagingController,
        );
      case 1:
        return LeadPage(
          junkController: junkController,
          pagingController: leadpagingController,
        );
      case 2:
        return _mDealsPage;
      case 3:
        return ContactPage(
          companyController: companyController,
          peopleController: peopleController,
        );
      default:
        return settings;
    }
  }

  updateActivityLostReason() async {
    final ActivityLostReasonSettings activityLostReasonSettings =
        await Repository.getInstance().getActivityLostReasonSettings();
    await SessionManager.getInstance().setActivityLostReasonSetting(
        activityLostReasonSettings.isActivityLostReasonEnabled);
  }

  final iconList = <IconData>[
    Boxicons.bx_calendar_check,
    Boxicons.bx_bullseye,
    Icons.monetization_on_outlined,
    Boxicons.bx_group,
    Boxicons.bx_cog,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: pageChooser(),
      ),
      floatingActionButton: CustomFloatingButton(
        icon: Icon(
          Icons.add,
          size: 40,
          color: white,
        ),
        onPressed: () => _settingModalBottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: white,
        icons: iconList,
        elevation: 5,
        activeIndex: _selectedIndex,
        activeColor: appColor.blue,
        splashColor: appColor.blue,
        inactiveColor: grey,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        notchMargin: 4.0,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getActivtyData() async {
    context.read<Repository>().getActivitySymbol();
  }

  addDeal() async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new AddDeal(),
          fullscreenDialog: true,
        ));

    if (result != null && result == true) {
      _mDealsPage.refresh();
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return new Container(
          color: Colors.transparent,
          child: new Container(
            padding: EdgeInsets.only(top: 4, left: 10, right: 10),
            decoration: new BoxDecoration(
              color: white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(8.0),
                topRight: const Radius.circular(8.0),
              ),
            ),
            child: new Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Create',
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: grey),
                    ),
                  ],
                ),
                new ListTile(
                  onTap: () => Navigator.pushNamed(
                    context,
                    CreateActivity.ROUTE_CREATE_ACTIVITY,
                  ).then((value) => {
                        pagingController.refresh(),
                        overduePagingController.refresh(),
                        completedController.refresh(),
                        Navigator.pop(context),
                      }),
                  leading: Icon(Boxicons.bx_calendar_check),
                  title: Text(
                    "Activity",
                    style: TextStyle(color: black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Add Activity",
                    style: TextStyle(color: grey),
                  ),
                ),
                new ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AddForm.ROUTE_ADD_FORM,
                            arguments: "Lead")
                        .then((value) => {
                              junkController.refresh(),
                              leadpagingController.refresh(),
                              Navigator.pop(context),
                            });
                  },
                  leading: Icon(Boxicons.bx_bullseye),
                  title: Text("Leads",
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold)),
                  subtitle: Text("Add Leads", style: TextStyle(color: grey)),
                ),
                new ListTile(
                  onTap: () {
                    /*Navigator.of(context)
                        .pushNamed(
                          AddDeal.ROUTE_ADD_DEAL,
                        )
                        .then((value) => {
                              Navigator.pop(context),
                            });*/
                    Navigator.pop(context);
                    addDeal();
                  },
                  leading: Icon(Icons.monetization_on_outlined),
                  title: Text("Deal",
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold)),
                  subtitle: Text("Add Deals", style: TextStyle(color: grey)),
                ),
                new ListTile(
                  onTap: () => Navigator.pushNamed(
                          context, AddForm.ROUTE_ADD_FORM,
                          arguments: "Person")
                      .then((value) => {
                            if (value == true)
                              {
                                companyController.refresh(),
                                peopleController.refresh(),
                              },
                            Navigator.pop(context),
                          }),
                  leading: Icon(Boxicons.bx_group),
                  title: Text("People",
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold)),
                  subtitle: Text("Add Person", style: TextStyle(color: grey)),
                ),
                new ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AddForm.ROUTE_ADD_FORM,
                            arguments: "Company")
                        .then((value) => {
                              companyController.refresh(),
                              peopleController.refresh(),
                              Navigator.pop(context),
                            });
                  },
                  leading: Icon(Boxicons.bx_buildings),
                  title: Text("Company",
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold)),
                  subtitle: Text("Add Company", style: TextStyle(color: grey)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
