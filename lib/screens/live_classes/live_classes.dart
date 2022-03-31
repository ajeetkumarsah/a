import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gyms/experience.dart';
import 'package:wtf_web/screens/live_classes/what_is_live_class.dart';
import 'package:wtf_web/screens/live_classes/wtf_live.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import 'gyms_nearby.dart';

class LiveClassesScreen extends StatefulWidget {
  static String routeName = '/LiveClassesScreen';

  const LiveClassesScreen({Key? key}) : super(key: key);

  @override
  _LiveClassesScreenState createState() => _LiveClassesScreenState();
}

class _LiveClassesScreenState extends State<LiveClassesScreen> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        _controller!.setLooping(true);
        setState(() {
          _controller!.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Constants.gradientRedLight, Constants.black],
            ),
          ),
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 542),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.only(top: 110.0, left: 50),
                  child: AdaptiveText(
                    text: "Powered",
                    minFontSize: 14,
                    style: GoogleFonts.montserrat(
                      fontSize: 161,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 224.0, top: 30),
                  child: Container(
                    height: 296,
                    width: 607,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Constants.cardBlackLight,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 7, color: Constants.black),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/live_classes/mobile.png'),
                      // ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _controller!.value.isInitialized
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                // width: _controller!.value.size.width,
                                child: VideoPlayer(_controller!),
                                //     AspectRatio(
                                //   aspectRatio: 18 / 10,
                                //   // aspectRatio: _controller!.value.aspectRatio,
                                //   child: VideoPlayer(_controller!),
                                // ),
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              });
                            },
                            icon: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 50,
                              color: Constants.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset('assets/live_classes/Notch.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(88, height * 0.2, height * 0.2, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/live_classes/Live.png'),
                      AdaptiveText(
                        text: "CLASS",
                        minFontSize: 14,
                        style: GoogleFonts.montserrat(
                          fontSize: 176,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const WhatIsLiveClass(),
        WTFLive(),
        const GymsNearby(),
        const BottomBar(),
      ],
    );
    // return BlocProvider(
    //   lazy: false,
    //   create: (context) => GymBloc()..add(FetchGymsEvent(userId: '')),
    //   child: BlocConsumer<GymBloc, GymState>(
    //     listener: (context, state) {
    //       if (state is GymInitial) {}
    //     },
    //     builder: (context, state) {
    //       if (state is FetchGymListState) {

    //       }
    //       return CustomLoader();
    //     },
    //   ),
    // );
  }

  double getPadding() {
    return ResponsiveWidget.isSmallScreen(context) ? 16 : 100;
  }

  Widget gymCountSection(double width) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: !isDesktop() ? Colors.white12.withOpacity(0.1) : Colors.black),
      padding: EdgeInsets.all(!isDesktop() ? 30 : 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: !isDesktop()
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'GYMS', count: '200'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'TRAINERS', count: '110'),
          SizedBox(
            width: width * 0.04,
          ),
          gymCount(label: 'DIETITIANS', count: '95'),
          SizedBox(
            width: width * 0.01,
          ),
        ],
      ),
    );
  }

  bool isSmallMobile() => Responsive.isSmallMobile(context);
  bool isDesktop() => Responsive.isDesktop(context);

  Widget gymCount({required String count, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdaptiveText(
          text: count,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        AdaptiveText(
          text: label,
          minFontSize: 14,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
