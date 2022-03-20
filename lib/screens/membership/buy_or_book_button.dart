// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/utils/const.dart';

import '../widgets/adaptiveText.dart';

class BuyOrbookScreen extends StatefulWidget {
  const BuyOrbookScreen({Key? key}) : super(key: key);

  @override
  State<BuyOrbookScreen> createState() => _BuyOrbookScreenState();
}

class _BuyOrbookScreenState extends State<BuyOrbookScreen> {
  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(48, height * 0.1, 67, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 66,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 141),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Constants.maroon,
                        ),
                        child: Row(
                          children: [
                            new AdaptiveText(
                              text: 'Buy now',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 66,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 64),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(width: 0.5, color: Constants.white)),
                        child: Row(
                          children: [
                            new AdaptiveText(
                              text: 'Book 1 day free session',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
