import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class EmptySettings extends StatelessWidget {
  const EmptySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          new Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blueColor, deepblue],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50, right: 25, left: 25),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0)),
                          height: 140.0,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Shimmer.fromColors(
                                baseColor: grey.withOpacity(0.4),
                                highlightColor: white,
                                child: Container(
                                  width: 200,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Shimmer.fromColors(
                                baseColor: grey.withOpacity(0.4),
                                highlightColor: white,
                                child: Container(
                                  width: 300,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: GestureDetector(
                            child: Shimmer.fromColors(
                              baseColor: grey.withOpacity(0.4),
                              highlightColor: white,
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                    shape: CircleBorder(),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/user.png',
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _settingsItem(),
                          _divider(),
                          _settingsItem(),
                          _divider(),
                          _settingsItem(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _settingsItem(),
                          _divider(),
                          _settingsItem(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _settingsItem(),
                          _divider(),
                          _settingsItem(),
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
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(height: 0.5, color: Colors.grey[200]),
    );
  }

  _settingsItem() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Shimmer.fromColors(
        baseColor: grey.withOpacity(0.4),
        highlightColor: white,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: grey.withOpacity(0.4),
        highlightColor: white,
        child: Container(
          width: 150,
          height: 10,
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: grey.withOpacity(0.4),
        highlightColor: white,
        child: Container(
          width: 300,
          height: 5,
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
