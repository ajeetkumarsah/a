import 'package:flutter/material.dart';

class ImageWrapper extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double? width;
  final double? height;

  const ImageWrapper(
      {Key? key,
      required this.image,
      this.fit = BoxFit.cover,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Listen to inherited widget width updates.
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Image.asset(
        image,
        width: width ?? w,
        height: height ?? w / 1.618,
        fit: fit,
      ),
    );
  }
}
