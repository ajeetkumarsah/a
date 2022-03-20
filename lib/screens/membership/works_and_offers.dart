// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/utils/const.dart';

import '../widgets/adaptiveText.dart';

class WorksAndOffers extends StatefulWidget {
  const WorksAndOffers({Key? key}) : super(key: key);

  @override
  State<WorksAndOffers> createState() => _WorksAndOffersState();
}

class _WorksAndOffersState extends State<WorksAndOffers> {
  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(48, height * 0.09, 67, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new AdaptiveText(
                    text: 'How it works?',
                    maxLines: 2,
                    minFontSize: 12,
                    align: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 240,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        howItWorks(
                            leadingIcon: 'assets/gym/emojione_person.svg',
                            text:
                                'Pick membership start ddate and complete your subscription process by clicking Buy Now below.'),
                        howItWorks(
                            leadingIcon: 'assets/gym/emojione_person.svg',
                            text:
                                'A dedicated general trainer will be assigned after you have taken your subscription.'),
                        howItWorks(
                            leadingIcon: 'assets/gym/emojione_person.svg',
                            text:
                                'Explore WTF and start your fitness journey.'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new AdaptiveText(
                    text: 'Offers Available for you',
                    maxLines: 2,
                    minFontSize: 12,
                    align: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 240,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Constants.cardBlackLight,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 44, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        offers(title: 'New member Offer'),
                        offers(title: '20% OFF for 1st month'),
                        offers(title: '30% OFF on 2nd month'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget howItWorks({required String text, required String leadingIcon}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Constants.white,
          ),
        ),
        ListTile(
          leading: SvgPicture.asset(leadingIcon),
          title: new AdaptiveText(
            text: text,
            maxLines: 2,
            minFontSize: 12,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget offers({required String title}) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: SvgPicture.asset('assets/gym/map_pin.svg'),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          new AdaptiveText(
            text: title,
            maxLines: 2,
            minFontSize: 12,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      trailing: Container(
        height: 46,
        width: 127,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Constants.primaryColor,
        ),
        child: Center(
          child: new AdaptiveText(
            text: 'Apply',
            minFontSize: 12,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}