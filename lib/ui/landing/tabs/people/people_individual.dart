import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:salessimplify/ui/widgetHelper/custom_floating_button.dart';

class PeopleIndividual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.lightBlueAccent,
        body: Column(
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
              padding: EdgeInsets.only(
                  top: 40.0, left: 0.0, right: 40.0, bottom: 30.0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 15.0, right: 8.0),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                title: Center(
                  child: Text(
                    'Ajeet Kumar Sah',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ),
                trailing: Text(' '),
              ),
            ),
            Expanded(
              flex: 1,
              child: new Container(
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F9F9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Center(
                                    child: Icon(
                                      Boxicons.bx_user,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                title: Text('Ajeet Kumar Sah',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 28.0, vertical: 0.0),
                                leading: Icon(
                                  Boxicons.bx_building,
                                  color: Colors.black,
                                ),
                                title: Text('Saino ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 28.0, vertical: 0.0),
                                leading: Icon(
                                  Boxicons.bx_purchase_tag,
                                  color: Colors.black,
                                ),
                                title: Text('Saino'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.55,
                          child: DefaultTabController(
                            length: 3,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  constraints:
                                      BoxConstraints.expand(height: 50),
                                  child: TabBar(
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                    labelColor: Colors.blue,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorWeight: 3,
                                    tabs: [
                                      Tab(text: "General"),
                                      Tab(text: "Time Line"),
                                      Tab(text: "Deals"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      _general(),
                                      _general(),
                                      _general(),
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
        floatingActionButton: CustomFloatingButton(
          icon: Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () {},
        ));
  }

  _general() {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))),
          child: ListTile(
            leading: Container(
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
            title: Text(
              'Work',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              '+1234567890',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        _divider(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListTile(
            tileColor: Colors.white,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Icon(
                  Boxicons.bx_mail_send,
                  color: Colors.blue,
                ),
              ),
            ),
            title: Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              'app@saino.io',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        _divider(),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              )),
          child: ListTile(
            tileColor: Colors.white,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Icon(
                  Boxicons.bx_group,
                  color: Colors.blue,
                ),
              ),
            ),
            title: Text(
              'Followers',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(height: 0.5, color: Colors.grey[200]),
    );
  }
}
