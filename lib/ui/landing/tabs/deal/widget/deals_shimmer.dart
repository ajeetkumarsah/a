import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:shimmer/shimmer.dart';

class DealsShimmer extends StatefulWidget {
  const DealsShimmer({Key? key}) : super(key: key);

  @override
  _DealsShimmerState createState() => _DealsShimmerState();
}

class _DealsShimmerState extends State<DealsShimmer> {
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
    return Scaffold(
      body: AnimationLimiter(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 1.7,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: List.generate(
            itemCount,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: Container(
                        margin: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 1.0),
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
    return Scaffold(
      body: AnimationLimiter(
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 1.7,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: List.generate(
            9,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Shimmer.fromColors(
                      baseColor: grey.withOpacity(0.4),
                      highlightColor: white,
                      child: Container(
                        margin: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 1.0),
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
