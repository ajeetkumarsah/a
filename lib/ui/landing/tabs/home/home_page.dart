import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/ui/landing/tabs/activity/new_add_activity.dart';
import 'package:salessimplify/ui/widgetHelper/custom_floating_button.dart';
import 'package:salessimplify/ui/widgetHelper/dotted_button.dart';

import 'package:salessimplify/ui/widgetHelper/logo_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _value = true, _value1 = false;
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          body: Column(
            children: [
              AnimatedContainer(
                height: _showAppbar ? 80.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: LogoAppBar(
                  title: Center(
                      child: Image.asset(
                    'assets/images/sales_logo.png',
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.07,
                  )),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollViewController,
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF00CCFF),
                              const Color(0xFF3366FF),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                          ),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  prefixIcon: Icon(
                                    Boxicons.bx_search_alt,
                                    color: white,
                                  ),
                                  hintText: "Search",
                                  hintStyle: TextStyle(color: white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide.none),
                                  fillColor: white.withOpacity(0.6),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Boxicons.bx_slider_alt,
                                  color: blueColor,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.all(0.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [blueColor, deepblue],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 32.0),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  'Your Schedule',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  '1 activity today',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: grey),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                          color: Colors.red[700],
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Boxicons.bx_calendar,
                                              color: white),
                                          SizedBox(width: 10),
                                          Text(
                                            '1 Overdue',
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [blueColor, deepblue],
                                            begin: const FractionalOffset(
                                                0.0, 0.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            stops: [0.0, 1.0],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Boxicons.bxs_message,
                                              color: white),
                                          SizedBox(width: 10),
                                          Text(
                                            '25 Unread',
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Today, 1 Sept',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      topLeft: Radius.circular(12.0),
                                    )),
                                child: GFCheckboxListTile(
                                  titleText: 'Call Customer',
                                  subTitleText: '10:00PM - 11:00PM',
                                  avatar: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Boxicons.bxs_phone_call,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  size: 22,
                                  activeBgColor: Colors.green,
                                  type: GFCheckboxType.circle,
                                  activeIcon: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  onChanged: (value1) {
                                    setState(() {
                                      _value = value1;
                                    });
                                  },
                                  value: _value,
                                  inactiveIcon: null,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      topLeft: Radius.circular(12.0),
                                    )),
                                child: GFCheckboxListTile(
                                  titleText: 'Meetings',
                                  subTitleText: '10:00PM - 11:00PM',
                                  avatar: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Boxicons.bxs_group,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  size: 22,
                                  activeBgColor: Colors.green,
                                  type: GFCheckboxType.circle,
                                  activeIcon: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _value1 = value;
                                    });
                                  },
                                  value: _value1,
                                  inactiveIcon: null,
                                ),
                              ),
                              SizedBox(height: 15),
                              DottedButton(
                                title: 'Add New Schedule',
                                icon: Boxicons.bxs_book_add,
                              ),
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Tomorrow, 2 Sept',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      topLeft: Radius.circular(12.0),
                                    )),
                                child: GFCheckboxListTile(
                                  titleText: 'Email',
                                  subTitleText: '10:00PM - 11:00PM',
                                  avatar: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  size: 22,
                                  activeBgColor: Colors.green,
                                  type: GFCheckboxType.circle,
                                  activeIcon: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _value1 = value;
                                    });
                                  },
                                  value: _value1,
                                  inactiveIcon: null,
                                ),
                              ),
                              SizedBox(height: 15),
                              DottedButton(
                                title: 'Add New Schedule',
                                icon: Boxicons.bxs_book_add,
                              ),
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Tomorrow, 2 Sept',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              DottedButton(
                                title: 'Add New Schedule',
                                icon: Boxicons.bxs_book_add,
                              ),
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Tomorrow, 2 Sept',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              DottedButton(
                                title: 'Add New Schedule',
                                icon: Boxicons.bxs_book_add,
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
          ),
          floatingActionButton: CustomFloatingButton(
            icon: Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddActivityPage())),
          )),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }
}
