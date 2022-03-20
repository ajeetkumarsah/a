// ignore_for_file: unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OfferingSection extends StatelessWidget {
  const OfferingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    bool isTablet() => Responsive.isTablet(context);
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(!isDesktop() ? 16 : 88, height * 0.1, 0, 20),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            if (!isMobile())
              BootstrapCol(
                sizes: 'col-12 col-sm-4 col-md-4',
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/home/offering.png',
                    height: isTablet()
                        ? 400
                        : isMobile()
                            ? 100
                            : 600,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            BootstrapCol(
              sizes: 'col-12 col-sm-8 col-md-8',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: !isMobile()
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      AdaptiveText(
                        text: 'Our Offerings',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: isMobile() ? 18 : 48,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      isMobile()
                          ? Container(
                              height: 3,
                              width: 64,
                              color: Colors.white,
                            )
                          : Expanded(
                              child: Divider(
                                thickness: 9,
                                height: 9,
                                color: Colors.white,
                              ),
                            )
                    ],
                  ),
                  const SizedBox(height: 60),
                  isMobile()
                      ? Container(
                          constraints: const BoxConstraints(
                              minHeight: 300, maxHeight: 380),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  'assets/home/offering.png',
                                  height: 230,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 48.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 134,
                                        height: 90,
                                        margin:
                                            const EdgeInsets.only(bottom: 28),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  isMobile() ? 9 : 19),
                                            ),
                                            border: Border.all(
                                                width: 2,
                                                color: Constants.primaryColor)),
                                      ),
                                      offeringCard(
                                          margin: EdgeInsets.only(
                                              top: 6.0, left: 16.0),
                                          width: 134,
                                          height: 90,
                                          isMobile: isMobile(),
                                          label: '100 +',
                                          extraHeight: false,
                                          description:
                                              'WTF Trained and \nCertified Gurus'),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: offeringCard(
                                      margin: EdgeInsets.all(0),
                                      width: 160,
                                      height: 90,
                                      isMobile: isMobile(),
                                      label: '1000 +',
                                      extraHeight: false,
                                      description: 'WTF Curated \ndiet plans'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        width: 117,
                                        height: 123,
                                        margin: const EdgeInsets.only(
                                            top: 4, left: 14),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  isMobile() ? 9 : 19),
                                            ),
                                            border: Border.all(
                                                width: 2,
                                                color: Constants.primaryColor)),
                                      ),
                                      offeringCard(
                                          width: 117,
                                          height: 123,
                                          margin: EdgeInsets.only(
                                              bottom: 4.0, right: 14.0),
                                          isMobile: isMobile(),
                                          label: '50 +',
                                          extraHeight: false,
                                          description:
                                              'In-App Hyper \nPersonalization feature'),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: offeringCard(
                                    width: 160,
                                    height: 90,
                                    label: '3000 +',
                                    extraHeight: false,
                                    description:
                                        'WTF Exclusive in-app \nworkout demos',
                                    isMobile: isMobile()),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              Stack(
                                children: [
                                  Container(
                                    width: 274,
                                    height: 170,
                                    margin: const EdgeInsets.only(bottom: 28),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(19),
                                        ),
                                        border: Border.all(
                                            width: 2,
                                            color: Constants.primaryColor)),
                                  ),
                                  offeringCard(
                                      margin: EdgeInsets.only(
                                          bottom: 4, right: 14.0),
                                      width: 274,
                                      height: 181,
                                      isMobile: isMobile(),
                                      label: '100 +',
                                      extraHeight: false,
                                      description:
                                          'WTF Trained and \nCertified Gurus'),
                                ],
                              ),
                              offeringCard(
                                  width: 326,
                                  height: 181,
                                  isMobile: isMobile(),
                                  label: '1000 +',
                                  extraHeight: false,
                                  description: 'WTF Curated \ndiet plans'),
                            ],
                          ),
                        ),
                  if (!isMobile())
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        offeringCard(
                            width: 326,
                            height: 181,
                            label: '3000 +',
                            extraHeight: false,
                            description: 'WTF Exclusive in-app \nworkout demos',
                            isMobile: isMobile()),
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.bottomRight,
                              width: 274,
                              height: 260,
                              margin: const EdgeInsets.only(top: 48, left: 52),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(19),
                                  ),
                                  border: Border.all(
                                      width: 2, color: Constants.primaryColor)),
                            ),
                            offeringCard(
                                width: 274,
                                height: 274,
                                margin: const EdgeInsets.all(18),
                                isMobile: isMobile(),
                                label: '50 +',
                                extraHeight: false,
                                description:
                                    'In-App Hyper \nPersonalization feature'),
                          ],
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

  Widget offeringCard(
      {required String label,
      required String description,
      bool extraHeight = false,
      bool giveTop = false,
      required double width,
      required double height,
      EdgeInsetsGeometry? margin,
      Gradient? gradient,
      required bool isMobile}) {
    return Container(
      width: width,
      height: height,
      margin: margin != null
          ? margin
          : EdgeInsets.only(left: 18, right: 18, top: 24, bottom: 18),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(isMobile ? 9.35 : 19),
        ),
        gradient: gradient != null
            ? gradient
            : LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Constants.gradientRed,
                  Constants.gradientPrimary,
                ],
              ),
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveText(
              text: label,
              align: TextAlign.center,
              maxLines: 3,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: isMobile ? 18 : 30,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal)),
          AdaptiveText(
              text: description,
              maxLines: 5,
              align: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal))
        ],
      ),
    );
  }
}
