// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OurTechWillHelp extends StatelessWidget {
  const OurTechWillHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
     bool isDesktop() => Responsive.isDesktop(context);
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(isDesktop() ?88:12.0,isDesktop()? 0:30, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   SizedBox(height:isDesktop() ? 60:0),
                  AdaptiveText(
                    text: 'Our Tech will help our',
                    maxLines: 2,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize:isDesktop() ? 64:24,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      AdaptiveText(
                        text: 'partners in',
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize:isDesktop() ? 64:24,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height:isDesktop()? 80:30)
                ],
              ),
            ),
          ],
        ),
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  cardView(
                    isDesktop: isDesktop(),
                      text: 'Maximizing revenueFor maximizing revenue',
                      icon: 'assets/partner/rupee.png',height:isDesktop()?null: 16),
                  SizedBox(height: 24),
                  cardView(
                    
                    isDesktop: isDesktop(),
                      text:
                          'Building a brand loved by both fitness enthusiasts & fitness dwellers.',
                      icon: 'assets/about_us/brand.png'),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  cardView(                    
                    isDesktop: isDesktop(),
                      text:
                          'Reaching more members/users & optimize the experience',
                      icon: 'assets/about_us/group.png'),
                  SizedBox(height: 24),
                  cardView(
                    
                    isDesktop: isDesktop(),
                      text: 'Building an online presence across channels.',
                      icon: 'assets/about_us/customer.png'),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-4',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  cardView(
                    isDesktop: isDesktop(),
                      text: 'Hassle-free operations',
                      icon: 'assets/about_us/web.png'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardView({required String text, required String icon,required bool isDesktop,double? height}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Image.asset(icon, color: Colors.white,height:height!=null?height: isDesktop?null:25),
      ),
      title: AdaptiveText(
        text: text,
        maxLines: 3,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          fontSize:isDesktop? 24:16,
          color: Colors.white,
        ),
      ),
    );
  }
}
