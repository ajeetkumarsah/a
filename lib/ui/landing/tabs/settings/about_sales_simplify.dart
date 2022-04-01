import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/ui/landing/tabs/settings/widget/button.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/util/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/animation.dart';

class AboutSalesSimplify extends StatefulWidget {
  static String routeName = "aboutSalesSimplify";

  @override
  _AboutSalesSimplifyState createState() => _AboutSalesSimplifyState();
}

class _AboutSalesSimplifyState extends State<AboutSalesSimplify>
    with TickerProviderStateMixin {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _initPackageInfo();
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(1 - _controller.value),
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  List<String> gridItems = [
    'Our Website',
    'Privacy Policy',
    'Terms of Services',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.98,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/back.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                          gradient: LinearGradient(
                            colors: [blueColor, deepblue],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: GlassmorphicContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.all(20),
                          borderRadius: 1,
                          blur: 20,
                          alignment: Alignment.bottomCenter,
                          border: 1,
                          linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                            stops: [0.1, 1],
                          ),
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                            stops: [0.1, 1],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.only(
                                      top: 12, left: 20, bottom: 0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon:
                                      Icon(Icons.arrow_back_ios, color: white)),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 16, top: 0),
                                child: Column(
                                  children: [
                                    AutoSizeText(
                                      'Sell smarter',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white),
                                      maxFontSize: 40,
                                      minFontSize: 35,
                                    ),
                                    SvgPicture.asset('assets/icons/line.svg',
                                        color: deepblue,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45),
                                    AutoSizeText(
                                      'Grow faster',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white),
                                      maxFontSize: 40,
                                      minFontSize: 35,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 30),
                                child: AutoSizeText(
                                  'Increase the conversion of your leads by up to 300% with a high-performing all-in-one solution built just for sales teams.',
                                  maxLines: 10,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: white),
                                  maxFontSize: 16,
                                  minFontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40)),
                                      child: RaisedButton(
                                        color: deepblue,
                                        onPressed: () {
                                          Utils.launchUrl(
                                              'https://salessimplify.com/');
                                        },
                                        child: AutoSizeText(
                                          'Know More',
                                          style: TextStyle(color: white),
                                          maxFontSize: 16,
                                          minFontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          elevation: 2,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40)),
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: white,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: EdgeInsets.all(0),
                                  child: ClipRRect(
                                    child: Image.asset(
                                        'assets/images/sales_logo.png'),
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                  ),
                                ),
                                // Text('Something about company details.',
                                //     maxLines: 10,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w400,
                                //         color: black)),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: gridItems.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 4.0,
                                              mainAxisSpacing: 4.0),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return gridTile(
                                            title: gridItems[index],
                                            child: index == 0
                                                ? Icon(Icons.language_outlined,
                                                    color: deepblue)
                                                : index == 1
                                                    ? Icon(
                                                        Icons
                                                            .privacy_tip_outlined,
                                                        color: deepblue)
                                                    : index == 2
                                                        ? Icon(
                                                            Icons
                                                                .receipt_long_outlined,
                                                            color: deepblue)
                                                        : index == 3
                                                            ? Icon(
                                                                Icons
                                                                    .tablet_mac_rounded,
                                                                color: deepblue)
                                                            : Icon(
                                                                Icons
                                                                    .tablet_mac_rounded,
                                                                color:
                                                                    deepblue),
                                            onTap: () {
                                              if (index == 0) {
                                                Utils.launchUrl(
                                                    "https://salessimplify.com/");
                                              } else if (index == 1) {
                                                Utils.launchUrl(
                                                    "https://salessimplify.com/privacy-policy/");
                                              } else if (index == 2) {
                                                Utils.launchUrl(
                                                    "https://salessimplify.com/terms-of-service/");
                                              } else if (index == 3) {}
                                            });
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: 'About Sales Simplify',
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: 120,
                height: 120,
                decoration:
                    ShapeDecoration(shape: CircleBorder(), color: white),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/sales_logo.png'),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: 10,
              ),
              Shimmer.fromColors(
                baseColor: black,
                highlightColor: white,
                loop: 1,
                child: Text(
                  'Sales Simplify',
                  style: TextStyle(
                    color: black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'What\'s new?',
                          style: TextStyle(
                            color: deepblue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Text(
                      'Version ${_packageInfo.version}',
                      style: TextStyle(
                        color: black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'What is new in version ${_packageInfo.version}',
                      style: TextStyle(
                        color: black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Bugs Fixed and Performance Improvement',
                      style: TextStyle(
                        color: black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              // ignore: deprecated_member_use
              PrivacyButton(
                onPressed: () => Utils.launchUrl(
                    "https://salessimplify.com/privacy-policy/"),
                title: 'Privacy Policy',
              ),

              PrivacyButton(
                onPressed: () => Utils.launchUrl(
                    "https://salessimplify.com/terms-of-service/"),
                title: 'Terms of Services',
              ),
              PrivacyButton(
                onPressed: () => Utils.launchUrl("https://salessimplify.com/"),
                title: 'Our Website',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridTile({required String title, Function()? onTap, Widget? child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new RotationTransition(
              turns: new AlwaysStoppedAnimation(45 / 360),
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: <Color>[
                          deepblue.withOpacity(0.1),
                          blueColor.withOpacity(0.03)
                        ])),
                child: new RotationTransition(
                    turns: new AlwaysStoppedAnimation(315 / 360), child: child),
              ),
            ),
            AutoSizeText(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: black),
              maxFontSize: 16,
              minFontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
