import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:salessimplify/controller/color.dart';

import 'package:salessimplify/ui/widgetHelper/dotted_button.dart';
import 'package:salessimplify/ui/widgetHelper/logo_appbar.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({Key? key}) : super(key: key);

  @override
  _AddActivityPageState createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
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
              duration: Duration(milliseconds: 300),
              child: LogoAppBar(
                title: Center(
                    child: Text(
                  'Add Activity',
                  style: TextStyle(
                      color: white, fontSize: 24, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
                physics: ScrollPhysics(),
                child: new Container(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Call',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: black),
                              ),
                              Icon(Boxicons.bxs_phone_call)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Today, 1 Sept',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Tomorrow, 2 Sept',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Tomorrow, 2 Sept',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Tomorrow, 2 Sept',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [blueColor, deepblue],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }
}
