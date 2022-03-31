import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:wtf_web/utils/const.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.black,
      child: Center(
        child: AwesomeLoader(
          loaderType: AwesomeLoader.AwesomeLoader3,
          color: Constants.white,
        ),
      ),
    );
  }
}
