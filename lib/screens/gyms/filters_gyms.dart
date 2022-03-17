import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class FiltersAndGyms extends StatefulWidget {
  const FiltersAndGyms({Key? key}) : super(key: key);

  @override
  State<FiltersAndGyms> createState() => _FiltersAndGymsState();
}

class _FiltersAndGymsState extends State<FiltersAndGyms> {
  double _value = 4.0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      children: [
        BootstrapContainer(
          fluid: true,
          // decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 50),
          children: <Widget>[
            BootstrapRow(
              height: 600,
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-2 col-lg-2 col-xl-2 col-sm-2 col-md-2',
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdaptiveText(
                          text: "Filters",
                          align: TextAlign.left,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        AdaptiveText(
                          text: "Location",
                          align: TextAlign.left,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 293,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Constants.cardBlackLight,
                            border: Border.all(width: 2, color: Constants.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                              decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter location',
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 172, 168, 168),
                            ),
                          )),
                        ),
                        SizedBox(height: 20),
                        AdaptiveText(
                          text: "Price",
                          align: TextAlign.left,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Constants.cardBlackLight,
                                border:
                                    Border.all(width: 2, color: Constants.grey),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Min',
                                hintStyle: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 172, 168, 168),
                                ),
                              )),
                            ),
                            Container(
                              width: 90,
                              height: 55,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Constants.cardBlackLight,
                                border:
                                    Border.all(width: 2, color: Constants.grey),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Max',
                                hintStyle: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 172, 168, 168),
                                ),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        AdaptiveText(
                          text: "Features",
                          align: TextAlign.left,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        RadioButtonGroup(
                          labels: <String>[
                            "Zumba Class",
                            "Crossfit Circuit",
                            'Cardio Zone',
                            'Pilates Studios',
                          ],
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          activeColor: Constants.primaryColor,
                          onSelected: (String selected) => print(selected),
                        ),
                        SizedBox(height: 20),
                        AdaptiveText(
                          text: "Distance in Km",
                          align: TextAlign.left,
                          minFontSize: 14,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        SfSlider(
                          min: 0.0,
                          max: 50.0,
                          value: _value,
                          interval: 2,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          activeColor: Constants.primaryColor,
                          inactiveColor: Constants.white,
                          minorTicksPerInterval: 1,
                          // labelPlacement: ,
                          onChanged: (dynamic value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-10 col-lg-10 col-xl-10 col-sm-10 col-md-10',
                  child: Container(
                    padding: EdgeInsets.only(right: 30),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext? context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          width: width,
                          height: 276,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Constants.cardBlackLight,
                          ),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/gym/gym1.png'),
                                  cardDetails(),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      // height: 40,
                                      decoration: BoxDecoration(
                                          color: Constants.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8.0))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 12.0),

                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdaptiveText(
                                            text: "Live Class",
                                            align: TextAlign.left,
                                            minFontSize: 14,
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          AdaptiveText(
                                            text: "Available @ 99",
                                            align: TextAlign.left,
                                            minFontSize: 14,
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 30, bottom: 30),
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18, top: 13, bottom: 13),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      color: Constants.primaryColor),
                                  child: AdaptiveText(
                                    text: 'Book Now',
                                    minFontSize: 14,
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget cardDetails() {
    return Container(
      height: 280,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: "Mass Monster",
                align: TextAlign.left,
                minFontSize: 14,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: "Noida Sector 8,C Block",
                align: TextAlign.left,
                minFontSize: 14,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: "₹ 1500 for 3 months",
                align: TextAlign.left,
                minFontSize: 14,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Constants.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          AdaptiveText(
            text: "Benifits",
            align: TextAlign.left,
            minFontSize: 14,
            maxLines: 2,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Constants.white,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 50,
            children: [
              cardIconText(
                  text: 'Modern \nEqipments',
                  icon: 'assets/gym/raphael_fitocracy.svg'),
              cardIconText(
                  text: 'Skilled \nTrainer',
                  icon: 'assets/gym/colorful_man.svg'),
              cardIconText(
                  text: 'Top class \nAmbiance', icon: 'assets/gym/Vector.svg'),
              cardIconText(
                  text: 'Sanitized \nGYMS',
                  icon: 'assets/gym/fluent_sanitize.svg'),
            ],
            direction: Axis.horizontal,
          )
        ],
      ),
    );
  }

  Widget cardIconText({required String text, required String icon}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          // height: 50,
        ),
        SizedBox(height: 4),
        AdaptiveText(
          text: text,
          align: TextAlign.center,
          minFontSize: 10,
          maxLines: 2,
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: Constants.white,
          ),
        ),
      ],
    );
  }
}
