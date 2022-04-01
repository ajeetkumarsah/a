import 'package:flutter/material.dart';

import 'package:salessimplify/controller/color.dart';

class LeadsDrawer extends StatefulWidget {
  final int index;
  const LeadsDrawer({Key? key, required this.index}) : super(key: key);

  @override
  _LeadsDrawerState createState() => _LeadsDrawerState();
}

int currentIndex = 1;

class _LeadsDrawerState extends State<LeadsDrawer> {
  bool selectedTile = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          tileColor: Colors.grey[200],
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
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
              Navigator.pop(context);
            },
          ),
        ),
        ListTile(
          dense: true,
          selected: selectedTile,
          contentPadding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 0),
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
            Navigator.pop(context);
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
        ListTile(
          onTap: () {
            setState(() {
              currentIndex = 2;
            });
            Navigator.pop(context);
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
            child: Center(
              child:
                  Text('A', style: TextStyle(color: blueColor, fontSize: 12)),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          horizontalTitleGap: 1,
          title: Text(
            "Ajeet(you)",
            style: TextStyle(fontSize: 16),
          ),
          trailing: currentIndex == 2 ? Icon(Icons.check) : null,
        ),
        Divider(),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 50, right: 10),
          title: Text(
            "Filter",
            style: TextStyle(fontSize: 15, color: grey),
          ),
        ),
        ListTile(
          onTap: () {
            setState(() {
              currentIndex = 3;
            });
            Navigator.pop(context);
          },
          selected: currentIndex == 3 ? true : false,
          dense: true,
          contentPadding: EdgeInsets.only(left: 50, right: 10),
          title: Text(
            "All deleted leads",
            style: TextStyle(fontSize: 16),
          ),
          trailing: currentIndex == 3 ? Icon(Icons.check) : null,
        ),
        ListTile(
          onTap: () {
            setState(() {
              currentIndex = 4;
            });
            Navigator.pop(context);
          },
          selected: currentIndex == 4 ? true : false,
          dense: true,
          contentPadding: EdgeInsets.only(left: 50, right: 10),
          title: Text(
            "All active leads",
            style: TextStyle(fontSize: 16),
          ),
          trailing: currentIndex == 4 ? Icon(Icons.check) : null,
        ),
        ListTile(
          onTap: () {
            setState(() {
              currentIndex = 5;
            });
            Navigator.pop(context);
          },
          selected: currentIndex == 5 ? true : false,
          dense: true,
          contentPadding: EdgeInsets.only(left: 50, right: 10),
          title: Text(
            "All junk leads",
            style: TextStyle(fontSize: 16),
          ),
          trailing: currentIndex == 5 ? Icon(Icons.check) : null,
        ),
      ],
    );
  }
}
