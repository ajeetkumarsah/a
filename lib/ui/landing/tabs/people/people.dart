import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/ui/landing/tabs/home/home_page.dart';
import 'package:salessimplify/ui/landing/tabs/people/people_individual.dart';
import 'package:salessimplify/ui/widgetHelper/custom_floating_button.dart';

class PeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [lightBlue, deepblue],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 46, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
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
                                      Tab(text: "People"),
                                      Tab(text: "Organizations"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      _peopleWidget(),
                                      _organizationWidget()
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
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage())),
        ));
  }

  _peopleWidget() {
    return ListView.separated(
      itemCount: 50,
      separatorBuilder: (context, index) {
        return Divider(
          color: grey,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => PeopleIndividual())),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
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
                Boxicons.bx_user,
                color: Colors.blue,
              ),
            ),
          ),
          title: Text(
            'Tony Turner',
            style: TextStyle(
              fontSize: 16,
              color: black,
            ),
          ),
          subtitle: Text(
            'Wolfs Corp',
            style: TextStyle(
              fontSize: 13,
              color: grey,
            ),
          ),
          trailing: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Icon(
                Boxicons.bxs_phone_call,
                color: blueColor,
                size: 14,
              ),
            ),
          ),
        );
      },
    );
  }

  _organizationWidget() {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (context, index) {
        return Divider(
          color: grey,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => PeopleIndividual())),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
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
                Boxicons.bx_user,
                color: Colors.blue,
              ),
            ),
          ),
          title: Text(
            'Tony Turner',
            style: TextStyle(
              fontSize: 16,
              color: black,
            ),
          ),
          subtitle: Text(
            'Wolfs Corp',
            style: TextStyle(
              fontSize: 13,
              color: grey,
            ),
          ),
          trailing: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Icon(
                Boxicons.bxs_phone_call,
                color: blueColor,
                size: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
