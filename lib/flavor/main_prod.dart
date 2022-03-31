import 'package:flutter/material.dart';
import 'package:wtf_web/config/flavor_config.dart';
import 'package:wtf_web/main.dart';
import 'package:wtf_web/utils/app_const.dart';



void main() {
  FlavorConfig(flavor: Flavor.PRODUCTION,
      values: FlavorValues(
        baseUrl: AppConstants.BASE_URL_PROD
      )
  );

  runApp(MyApp());
}