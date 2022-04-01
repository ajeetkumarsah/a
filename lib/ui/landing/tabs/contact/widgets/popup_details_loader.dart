import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class PopupDetailsLoader extends StatefulWidget {
  const PopupDetailsLoader({Key? key}) : super(key: key);

  @override
  _PopupDetailsLoaderState createState() => _PopupDetailsLoaderState();
}

class _PopupDetailsLoaderState extends State<PopupDetailsLoader> {
  int itemCount = 6;
  bool loading = false;
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);
  @override
  void initState() {
    super.initState();
    _buildNewState();
  }

  _buildNewState() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loading = !loading;
        itemCount = next(1, 10);
      });
    });
    _buildNewState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? _loading(itemCount: itemCount)
        : LoadingEffect(itemCount: itemCount);
  }

  Widget _loading({required int itemCount}) {
    return Container(
      child: AnimationLimiter(
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: ListTile(
                      leading: Shimmer.fromColors(
                        baseColor: grey.withOpacity(0.4),
                        highlightColor: white,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey.withOpacity(0.4),
                            highlightColor: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 16,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: appColor.grey,
                                  borderRadius: BorderRadius.circular(4.0)),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey.withOpacity(0.4),
                            highlightColor: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 8,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: appColor.grey,
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Row(
                                children: [],
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Shimmer.fromColors(
                        baseColor: grey.withOpacity(0.4),
                        highlightColor: white,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoadingEffect extends StatelessWidget {
  final int itemCount;
  const LoadingEffect({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimationLimiter(
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: ListTile(
                      leading: Shimmer.fromColors(
                        baseColor: grey.withOpacity(0.4),
                        highlightColor: white,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey.withOpacity(0.4),
                            highlightColor: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 16,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: appColor.grey,
                                  borderRadius: BorderRadius.circular(4.0)),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Shimmer.fromColors(
                            baseColor: grey.withOpacity(0.4),
                            highlightColor: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 8,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: appColor.grey,
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Row(
                                children: [],
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Shimmer.fromColors(
                        baseColor: grey.withOpacity(0.4),
                        highlightColor: white,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
