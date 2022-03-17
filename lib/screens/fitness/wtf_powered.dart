// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class WTFPowered extends StatelessWidget {
  const WTFPowered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(0, height * 0.1, 0, height * 0.1),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-4',
              child: Container(
                margin: EdgeInsets.only(top: 200),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AdaptiveText(
                          text: 'WTF',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 48,
                              color: Colors.white),
                        ),
                        AdaptiveText(
                          text: ' Powered',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 48,
                              color: Color.fromARGB(66, 122, 120, 120)),
                        ),
                      ],
                    ),
                    options(),
                  ],
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
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, right: 90),
                    child: Row(
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: 312,
                              height: 418,
                              margin: const EdgeInsets.all(18),
                              decoration: const BoxDecoration(
                                color: Constants.blackCardColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: exploreCard(
                                  icon: 'assets/fitness/gyms.png',
                                  extraHeight: true,
                                  description:
                                      'All WTF Powered Gyms comes with Top class infrastructure and machinery at your rgular gym membership.All WTF Gyms gives you access to train from home witth the accessof trainer when pandemic hits.'),
                            ),
                            SizedBox(height: 50)
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 50),
                            Container(
                              width: 312,
                              height: 418,
                              margin: EdgeInsets.only(
                                  left: 18, right: 18, top: 24, bottom: 18),
                              decoration: const BoxDecoration(
                                color: Constants.blackCardColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(19),
                                ),
                              ),
                              padding: EdgeInsets.all(30),
                              child: exploreCard(
                                  extraHeight: false,
                                  icon: 'assets/fitness/studio.png',
                                  description:
                                      'WTF STUDIOS are one stop solution for all those who dont want to lift.We have Zumba,Pilates and Dance studios for you people out there.'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget options() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        wtfFitnessLeftItem(label: '200 + GYMS', width: 384, height: 58),
        wtfFitnessLeftItem(label: '85+ Studios', width: 243, height: 58),
        wtfFitnessLeftItem(label: '110+ Trainers', width: 290, height: 58),
      ],
    );
  }

  Widget wtfFitnessLeftItem(
      {required String label, required double height, required double width}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      constraints: BoxConstraints(minHeight: height, minWidth: width),
      decoration: new BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: new BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
          )),
      padding: EdgeInsets.only(right: 30),
      alignment: Alignment.center,
      child: AdaptiveText(
        text: label,
        maxLines: 3,
        style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal),
      ),
    );
  }

  Widget exploreCard(
      {required String description,
      bool extraHeight = false,
      bool giveTop = false,
      required String icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: 200,
        ),
        SizedBox(height: 12.0),
        AdaptiveText(
            text: description,
            maxLines: 7,
            align: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal)),
        SizedBox(height: 20),
        Container(
          child: AdaptiveText(
            text: "Explore",
            minFontSize: 14,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Constants.primaryColor,
            ),
          ),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Constants.white),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
