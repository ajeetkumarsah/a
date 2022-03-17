import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class OfferingSection extends StatelessWidget {
  const OfferingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(88, height * 0.1, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-4',
              child: Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/home/offering.png',
                  height: 600,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-8',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      AdaptiveText(
                        text: 'Our Offerings',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 48,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Expanded(
                          child: Divider(
                        thickness: 9,
                        height: 9,
                        color: Colors.white,
                      ))
                    ],
                  ),
                  Padding(
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
                                      width: 2, color: Constants.primaryColor)),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: 274,
                              height: 181,
                              margin: const EdgeInsets.all(18),
                              decoration: const BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: <Color>[
                                    Constants.gradientRed,
                                    Constants.gradientPrimary,
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.all(30),
                              child: offeringCard(
                                  label: '100 +',
                                  extraHeight: false,
                                  description:
                                      'WTF Trained and \nCertified Gurus'),
                            ),
                          ],
                        ),
                        Container(
                          width: 326,
                          height: 181,
                          margin: EdgeInsets.only(
                              left: 18, right: 18, top: 24, bottom: 18),
                          decoration: const BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(19),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: <Color>[
                                Constants.gradientRed,
                                Constants.gradientPrimary,
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(30),
                          child: offeringCard(
                              label: '1000 +',
                              extraHeight: false,
                              description: 'WTF Curated \ndiet plans'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Container(
                        width: 326,
                        height: 181,
                        margin: EdgeInsets.only(
                            left: 18, right: 18, top: 24, bottom: 18),
                        decoration: const BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(19),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: <Color>[
                              Constants.gradientRed,
                              Constants.gradientPrimary,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(30),
                        child: offeringCard(
                            label: '3000 +',
                            extraHeight: false,
                            description:
                                'WTF Exclusive in-app \nworkout demos'),
                      ),
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
                          Container(
                            alignment: Alignment.center,
                            width: 274,
                            height: 274,
                            margin: const EdgeInsets.all(18),
                            decoration: const BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(19),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Constants.gradientRed,
                                  Constants.gradientPrimary,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(30),
                            child: offeringCard(
                                label: '50 +',
                                extraHeight: false,
                                description:
                                    'In-App Hyper \nPersonalization feature'),
                          ),
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
      bool giveTop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AdaptiveText(
            text: label,
            align: TextAlign.center,
            maxLines: 3,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal)),
        AdaptiveText(
            text: description,
            maxLines: 3,
            align: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal))
      ],
    );
  }
}
