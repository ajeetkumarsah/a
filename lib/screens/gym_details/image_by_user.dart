// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class ImageUploadedByUser extends StatelessWidget {
  const ImageUploadedByUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(88, 38, 0, 30),
      children: [
        AdaptiveText(
          text: "Images Uploaded by user",
          minFontSize: 14,
          style: GoogleFonts.openSans(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 70),
        Container(
          height: 202,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 15,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                height: 202,
                width: 277,
                margin: EdgeInsets.only(left: 12.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 277,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        color: Constants.cardBlackLight,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        Container(
          height: 1,
          color: Constants.white,
          margin: EdgeInsets.only(top: 60),
        ),
      ],
    );
  }
}
