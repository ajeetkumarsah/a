import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/sessionmanager/SessionManager.dart';
import 'package:salessimplify/ui/landing/tabs/lead/activeleads.dart';
import 'package:salessimplify/ui/landing/tabs/lead/junklead.dart';
import 'package:salessimplify/ui/landing/tabs/lead/widgets/leads_drawer.dart';
import 'package:salessimplify/ui/widget/SearchWidget.dart';
import 'package:salessimplify/ui/widgetHelper/logo_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/serach_filter_ui.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

class LeadPage extends StatefulWidget {
  final PagingController<int, Leads> pagingController;

  final PagingController<int, Leads> junkController;
  const LeadPage({
    Key? key,
    required this.pagingController,
    required this.junkController,
  }) : super(key: key);
  @override
  _LeadPageState createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  late TabController _controller;
  Map<String, dynamic> params = {};

  @override
  void initState() {
    super.initState();
    _controller = new TabController(
      length: 2,
      vsync: this,
    );
  }

  toggleDrawer() async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: LogoAppBar(
          title: SearchFilterUI(
        filterOnPressed: () => scaffoldKey.currentState!.openEndDrawer(),
        searchOnTap: () =>
            Navigator.pushNamed(context, SearchWidget.ROUTE_SEARCH),
        text: "Search Leads",
      )),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              tileColor: Colors.grey[200],
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => toggleDrawer(),
              ),
              title: Text(
                "Choose Filter",
                style: TextStyle(fontSize: 18),
              ),
              trailing: TextButton(
                style: ButtonStyle(),
                child: Text(
                  'RESET',
                  style: TextStyle(color: blueColor, fontSize: 13),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                  widget.pagingController.refresh();
                  widget.junkController.refresh();
                  toggleDrawer();
                },
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 50.0, vertical: 0),
              title: Text(
                "Users",
                style: TextStyle(fontSize: 15, color: grey),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
                widget.pagingController.refresh();
                widget.junkController.refresh();
                toggleDrawer();
              },
              selected: currentIndex == 1 ? true : false,
              dense: true,
              contentPadding: EdgeInsets.only(left: 50, right: 10),
              title: Text(
                "Everyone",
                style: TextStyle(fontSize: 16),
              ),
              trailing: currentIndex == 1 ? Icon(Icons.check) : null,
            ),
            FutureBuilder(
                future: getUserId(),
                builder: (context, snapshot) => snapshot.connectionState ==
                        ConnectionState.done
                    ? ListTile(
                        onTap: () async {
                          setState(() {
                            currentIndex = 2;
                          });
                          widget.pagingController.refresh();
                          widget.junkController.refresh();
                          toggleDrawer();
                          params = {
                            "filterType": "user",
                            "userId": snapshot.data,
                            "moduleType": "lead",
                            "limit": 10,
                            "pageNo": 1
                          };
                          print(snapshot.data);
                          var filter = await Repository.getInstance()
                              .activityFilter(params);
                          if (filter is bool && filter == true) {
                            toastHelper.toastWithTitleAndColor(
                                "Filter applied!", greenColor);
                          } else {
                            toastHelper.toastWithTitleAndColor(
                                "Failed to apply filter!", redColor);
                          }
                        },
                        selected: currentIndex == 2 ? true : false,
                        dense: true,
                        leading: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: FutureBuilder(
                            future: getName(),
                            builder: (context, snapshot) =>
                                snapshot.connectionState == ConnectionState.done
                                    ? Center(
                                        child: Text(
                                        (snapshot.data!
                                            .toString()
                                            .characters
                                            .first
                                            .toUpperCase()),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: blueColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ))
                                    : Text("A"),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                        horizontalTitleGap: 1,
                        title: FutureBuilder(
                          future: getName(),
                          builder: (context, snapshot) =>
                              snapshot.connectionState == ConnectionState.done
                                  ? Text(
                                      "${snapshot.data} (you)",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  : Text(""),
                        ),
                        trailing: currentIndex == 2 ? Icon(Icons.check) : null,
                      )
                    : SizedBox()),
            Divider(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [blueColor, deepblue],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints.expand(height: 50),
                                child: TabBar(
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  labelColor: Colors.blue,
                                  indicatorColor: Colors.blue,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorWeight: 3,
                                  tabs: [
                                    const Tab(text: "Active Leads"),
                                    const Tab(text: "Junk Lead"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    ActiveLeads(
                                      activePagingController:
                                          widget.pagingController,
                                      junkPagingController:
                                          widget.junkController,
                                    ),
                                    JunkLead(
                                      activePagingController:
                                          widget.pagingController,
                                      junkPagingController:
                                          widget.junkController,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getName() async {
    var name = await SessionManager.getInstance().getName();
    return name;
  }

  getUserId() async {
    var userId = await SessionManager.getInstance().getId();
    return userId;
  }
}
