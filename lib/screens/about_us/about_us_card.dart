// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

import '../../new/responsive.dart';

class AboutUsCard extends StatelessWidget {
  const AboutUsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop() => Responsive.isDesktop(context);
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(isDesktop()? 88:12.0,isDesktop()? height * 0.1:30, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 24),
                  cardView(                    
                    isDesktop: isDesktop(),
                    title: 'Our Mission',
                    subTitle:
                        'We aim to build an end to end User Experience driven by Technology - right from discovery to accede to the realization of a standardized fitness experience',
                    height: 204,
                    width: 576,
                  ),
                  SizedBox(height: 24),
                  cardView(                    
                    isDesktop: isDesktop(),
                    title: 'Summary',
                    subTitle:
                        'WTF is creating a global platform that empowers entrepreneurs and small businesses with Fitness Facilities to go digital providing full-stack technology that increases earnings and eases operations.\nBringing affordable and best-in-class experience that members can book instantly. We strive to make the lives of our patrons easier by multiplying revenue channels and using our technological expertise to maximize demand.',
                    height: 382,
                    width: 576,
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                children: [
                  SizedBox(height: 24),
                  cardView(                    
                    isDesktop: isDesktop(),
                    title: 'Our Vision',
                    subTitle:
                        'Our vision is to deliver simple Fitness Lifestyle for \ncommon living People on \nBUDGET',
                    height: 204,
                    width: 576,
                  ),
                  SizedBox(height: 24),
                  cardView(
                    isDesktop: isDesktop(),
                    title: 'Company History',
                    subTitle: '',
                    height: 204,
                    width: 576,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardView(
      {required String title,
      required String subTitle,
      required bool isDesktop,
      double? height,
      double? width}) {
    return Container(
      // height: height != null ? height : 204,
      // width: width != null ? width : 576,
      
      padding: EdgeInsets.all(24),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdaptiveText(
              text: title,
              minFontSize: 12,
              style: GoogleFonts.montserrat(
                fontSize:isDesktop? 24:14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
        subtitle: AdaptiveText(
          text: subTitle,
          minFontSize: 10,
          maxLines: 13,
          style: GoogleFonts.openSans(
            fontSize:isDesktop? 18:12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Constants.primaryColor),
      alignment: Alignment.center,
    );
  }  
}
