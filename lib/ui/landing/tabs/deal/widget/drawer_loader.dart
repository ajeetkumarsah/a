import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class DrawerLoader extends StatelessWidget {
  const DrawerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext bc, int i) {
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            title: Shimmer.fromColors(
              baseColor: grey.withOpacity(0.4),
              highlightColor: white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                width: 150,
                height: 20,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
