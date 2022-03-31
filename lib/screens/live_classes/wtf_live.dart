import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class WTFLive extends StatelessWidget {
  WTFLive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isSmallMobile() => Responsive.isSmallMobile(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Constants.black),
      padding: EdgeInsets.fromLTRB(0, isDesktop() ? 48 : 30, 0, 0),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, isSmallMobile() || isMobile() ? 20 : 0, 0, 0),
          child: BootstrapRow(
            children: [
              BootstrapCol(
                absoluteSizes: false,
                sizes: 'col-12 col-sm-12 col-md-12',
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          aspectRatio: 28 / 9),
                      itemCount: wtfLivedetails.length,
                      itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) =>
                          Container(
                        height: 452,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 361),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child:
                                  Image.asset('assets/live_classes/smoke.png'),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(wtfLivedetails[index].icon),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AdaptiveText(
                                  text: wtfLivedetails[index].text1,
                                  align: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 149,
                                    fontWeight: FontWeight.w900,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 3
                                      ..color = Constants.white,
                                    letterSpacing: -7,
                                  ),
                                ),
                                AdaptiveText(
                                  text: wtfLivedetails[index].text2,
                                  align: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 166,
                                    fontWeight: FontWeight.w900,
                                    color: Constants.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 114,
                        width: 361,
                        decoration:
                            BoxDecoration(color: Constants.svgIconColor),
                        alignment: Alignment.center,
                        child: AdaptiveText(
                          text: "Why to choose \nWTF Live ?",
                          maxLines: 2,
                          minFontSize: 8,
                          style: GoogleFonts.openSans(
                            fontSize: isDesktop()
                                ? 36
                                : isSmallMobile()
                                    ? 10
                                    : isMobile()
                                        ? 14
                                        : 18,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  final List<WTFLiveDetails> wtfLivedetails = [
    WTFLiveDetails(
      text1: 'TRAIN FROM',
      text2: 'ANYWHERE',
      icon: 'assets/live_classes/slider1.png',
    ),
    WTFLiveDetails(
      text1: 'BRING GYM',
      text2: 'HOME',
      icon: 'assets/live_classes/body.png',
    ),
    WTFLiveDetails(
      text1: 'TRAIN FROM ',
      text2: 'COSPACE',
      icon: 'assets/live_classes/slider3.png',
    ),
  ];
}

class WTFLiveDetails {
  final String text1;
  final String text2;
  final String icon;

  WTFLiveDetails({
    required this.text1,
    required this.text2,
    required this.icon,
  });
}

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          width: 600,
          color: Constants.white,
          child: _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container(),
        ),
      ],

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller!.value.isPlaying
      //           ? _controller!.pause()
      //           : _controller!.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
