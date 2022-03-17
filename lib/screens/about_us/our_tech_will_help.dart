// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OurTechWillHelp extends StatelessWidget {
  const OurTechWillHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(88, 0, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 60),
                  AdaptiveText(
                    text: 'Our Tech will help our',
                    maxLines: 2,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 64,
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
                          fontSize: 64,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 80)
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
                      text: 'Maximizing revenueFor maximizing revenue',
                      icon: 'assets/partner/rupee.png'),
                  SizedBox(height: 24),
                  cardView(
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
                      text:
                          'Reaching more members/users & optimize the experience',
                      icon: 'assets/about_us/group.png'),
                  SizedBox(height: 24),
                  cardView(
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

  Widget cardView({required String text, required String icon}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Image.asset(icon, color: Colors.white),
      ),
      title: AdaptiveText(
        text: text,
        maxLines: 3,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
