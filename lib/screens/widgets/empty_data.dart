import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class EmptyDataScreen extends StatelessWidget {
  const EmptyDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AdaptiveText(
            text: 'No data found!',
            minFontSize: 12,
          )
        ],
      ),
    );
  }
}
