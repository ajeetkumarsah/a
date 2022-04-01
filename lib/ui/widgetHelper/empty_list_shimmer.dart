import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class EmptyListShimmer extends StatefulWidget {
  final int tab;
  const EmptyListShimmer({Key? key, required this.tab}) : super(key: key);

  @override
  _EmptyListShimmerState createState() => _EmptyListShimmerState();
}

class _EmptyListShimmerState extends State<EmptyListShimmer> {
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
      setStateIfMounted(() {
        loading = !loading;
        itemCount = next(1, 10);
      });
    });
    _buildNewState();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? _loading(tab: widget.tab, itemCount: itemCount)
        : LoadingEffect(tab: widget.tab, itemCount: itemCount);
  }

  Widget _loading({required int tab, required int itemCount}) {
    return new Scaffold(
      backgroundColor: white,
      body: new AnimationLimiter(
        child: new ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return new AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: new FadeInAnimation(
                  child: new ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    leading: new Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: new Container(
                        height: 50,
                        width: 50,
                        decoration: new BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                    title: new Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: Container(
                        width: 150,
                        height: 10,
                        decoration: new BoxDecoration(
                          color: grey,
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    subtitle: new Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: new Container(
                        width: 300,
                        height: 5,
                        decoration: new BoxDecoration(
                          color: grey,
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    trailing: tab == 1
                        ? null
                        : new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              new Shimmer.fromColors(
                                baseColor: grey.withOpacity(0.4),
                                highlightColor: white,
                                child: new Container(
                                  height: 30,
                                  width: 30,
                                  decoration: new BoxDecoration(
                                    color: grey,
                                    borderRadius: new BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              tab == 4 ? Container() : SizedBox(width: 10),
                              tab == 4
                                  ? Container()
                                  : new Shimmer.fromColors(
                                      baseColor: grey.withOpacity(0.4),
                                      highlightColor: white,
                                      child: new Container(
                                        height: 30,
                                        width: 30,
                                        decoration: new BoxDecoration(
                                          color: grey,
                                          borderRadius:
                                              new BorderRadius.circular(22),
                                        ),
                                      ),
                                    ),
                              tab == 4 ? Container() : SizedBox(width: 10),
                              tab == 4
                                  ? Container()
                                  : new Shimmer.fromColors(
                                      baseColor: grey.withOpacity(0.4),
                                      highlightColor: white,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: new BoxDecoration(
                                          color: grey,
                                          borderRadius:
                                              new BorderRadius.circular(22),
                                        ),
                                      ),
                                    ),
                            ],
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
  final int tab;
  final int itemCount;
  const LoadingEffect({Key? key, required this.tab, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    leading: Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(30.0)),
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
                    trailing: tab == 1
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Shimmer.fromColors(
                                baseColor: grey.withOpacity(0.4),
                                highlightColor: white,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              tab == 4 ? Container() : SizedBox(width: 10),
                              tab == 4
                                  ? Container()
                                  : Shimmer.fromColors(
                                      baseColor: grey.withOpacity(0.4),
                                      highlightColor: white,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: grey,
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                      ),
                                    ),
                              tab == 4 ? Container() : SizedBox(width: 10),
                              tab == 4
                                  ? Container()
                                  : Shimmer.fromColors(
                                      baseColor: grey.withOpacity(0.4),
                                      highlightColor: white,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: grey,
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                      ),
                                    ),
                            ],
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
