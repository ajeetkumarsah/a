import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wtf_web/model/benefits.dart';
import 'package:wtf_web/model/gym_list_model.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/gym_details.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';
import 'package:wtf_web/utils/days_converter.dart';

class FiltersAndGyms extends StatefulWidget {
  List<GymListModel> gymList;
  FiltersAndGyms({Key? key, required this.gymList}) : super(key: key);

  @override
  State<FiltersAndGyms> createState() => _FiltersAndGymsState();
}

class _FiltersAndGymsState extends State<FiltersAndGyms> {
  double _value = 4.0;
  bool isDesktop() => Responsive.isDesktop(context);
  bool isMobile() => Responsive.isMobile(context);
  bool isTablet() => Responsive.isTablet(context);
  bool isMinDesktop() => Responsive.isMinDesktop(context);
  bool isMobileLarge() => Responsive.isMobileLarge(context);
  bool isSmallMobile() => Responsive.isSmallMobile(context);

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
                  sizes: 'col-12 col-md-3 col-sm-12',
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdaptiveText(
                          text: "Filters",
                          align: TextAlign.left,
                          minFontSize: 10,
                          style: GoogleFonts.montserrat(
                            fontSize: isDesktop() ? 36 : 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        AdaptiveText(
                          text: "Location",
                          align: TextAlign.left,
                          minFontSize: 10,
                          style: GoogleFonts.montserrat(
                            fontSize: isDesktop() ? 18 : 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: isDesktop() ? 293 : 180,
                          height: isDesktop() ? 55 : 30,
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
                              fontSize: isDesktop() ? 18 : 10,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 172, 168, 168),
                            ),
                          )),
                        ),
                        SizedBox(height: 20),
                        AdaptiveText(
                          text: "Price",
                          align: TextAlign.left,
                          minFontSize: 10,
                          style: GoogleFonts.montserrat(
                            fontSize: isDesktop() ? 18 : 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: isDesktop() ? 90 : 60,
                              height: isDesktop() ? 55 : 30,
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
                                  fontSize: isDesktop() ? 18 : 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 172, 168, 168),
                                ),
                              )),
                            ),
                            Container(
                              width: isDesktop() ? 90 : 60,
                              height: isDesktop() ? 55 : 30,
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
                                  fontSize: isDesktop() ? 18 : 10,
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
                          minFontSize: 10,
                          style: GoogleFonts.montserrat(
                            fontSize: isDesktop() ? 18 : 10,
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
                            fontSize: isDesktop() ? 18 : 10,
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
                          minFontSize: 10,
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
                  sizes: 'col-12 col-md-9 col-sm-12',
                  child: Container(
                    padding: EdgeInsets.only(right: isDesktop() ? 30 : 0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.gymList.length,
                      itemBuilder: (BuildContext? context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          width: width,
                          height: isMobile()
                              ? 170
                              : isTablet()
                                  ? height * 0.30
                                  : isSmallMobile()
                                      ? 140
                                      : height * 0.36,
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
                                  widget.gymList[index].coverImage != null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Constants.cardBlackLight,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8.0),
                                                bottomLeft:
                                                    Radius.circular(8.0)),
                                            child: Image.network(
                                              widget.gymList[index]
                                                      .coverImage ??
                                                  '',
                                              width: isMobile()
                                                  ? MediaQuery.of(context!)
                                                          .size
                                                          .width *
                                                      0.33
                                                  : isTablet()
                                                      ? 200
                                                      : isSmallMobile()
                                                          ? 100
                                                          : MediaQuery.of(
                                                                      context!)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                              height: double.infinity,
                                              fit: BoxFit.fill,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/gym/gym1.png',
                                          width: isMobile()
                                              ? MediaQuery.of(context!)
                                                      .size
                                                      .width *
                                                  0.33
                                              : isTablet()
                                                  ? 200
                                                  : isSmallMobile()
                                                      ? 100
                                                      : MediaQuery.of(context!)
                                                              .size
                                                              .width *
                                                          0.22,
                                          height: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                  cardDetails(
                                      width, widget.gymList[index], height),
                                ],
                              ),
                              if (widget.gymList[index].text1 != null &&
                                  widget.gymList[index].text2 != null)
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
                                                topRight:
                                                    Radius.circular(8.0))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 12.0),

                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AdaptiveText(
                                              text:
                                                  widget.gymList[index].text1 ??
                                                      '',
                                              align: TextAlign.left,
                                              minFontSize: 10,
                                              maxLines: 2,
                                              style: GoogleFonts.montserrat(
                                                fontSize: isDesktop() ? 18 : 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            AdaptiveText(
                                              text:
                                                  widget.gymList[index].text2 ??
                                                      '',
                                              align: TextAlign.left,
                                              minFontSize: 10,
                                              maxLines: 2,
                                              style: GoogleFonts.montserrat(
                                                fontSize: isDesktop() ? 18 : 10,
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
                                alignment: isMinDesktop()
                                    ? Alignment.centerRight
                                    : isMobile() || isSmallMobile()
                                        ? Alignment.centerRight
                                        : Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context!,
                                      GymDetails.routeName,
                                      arguments: {
                                        'id': widget.gymList[index].userId,
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: isDesktop() ? 30 : 8.0,
                                        bottom: isDesktop() ? 30 : 8.0),
                                    padding: isDesktop()
                                        ? const EdgeInsets.only(
                                            left: 18,
                                            right: 18,
                                            top: 13,
                                            bottom: 13)
                                        : EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8.0),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        color: Constants.primaryColor),
                                    child: AdaptiveText(
                                      text: 'Book Now',
                                      minFontSize: 10,
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: isDesktop() ? 18 : 10,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
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

  Widget cardDetails(double width, GymListModel gymList, double height) {
    return Container(
      height: isDesktop()
          ? 260
          : isSmallMobile()
              ? 140
              : 150,
      padding: isDesktop() ? EdgeInsets.all(20) : EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: gymList.gymName ?? '',
                align: TextAlign.left,
                minFontSize: 8,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: isDesktop()
                      ? 24
                      : isSmallMobile()
                          ? 8
                          : 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallMobile() ? 4 : 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: gymList.address1! + ', ' + gymList.address2!,
                align: TextAlign.left,
                minFontSize: 8,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: isDesktop()
                      ? 16
                      : isSmallMobile()
                          ? 8
                          : 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallMobile() ? 4 : 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveText(
                text: gymList.planPrice != null && gymList.planDuration != null
                    ? '₹ ${gymList.planPrice} ${daysConverter(int.parse(gymList.planDuration!))}'
                    : '',
                // "₹ ${gymList.planPrice} for ${gymList.planDuration} months",
                align: TextAlign.left,
                minFontSize: 8,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  fontSize: isDesktop()
                      ? 18
                      : isSmallMobile()
                          ? 8
                          : 10,
                  fontWeight: FontWeight.w500,
                  color: Constants.primaryColor,
                ),
              ),
            ],
          ),
          Spacer(),
          AdaptiveText(
            text: "Benifits",
            align: TextAlign.left,
            minFontSize: 8,
            maxLines: 2,
            style: GoogleFonts.montserrat(
              fontSize: isDesktop()
                  ? 18
                  : isSmallMobile()
                      ? 8
                      : 10,
              fontWeight: FontWeight.w500,
              color: Constants.white,
            ),
          ),
          SizedBox(height: isSmallMobile() ? 4 : 10),
          Container(
              height: height * 0.08,
              child: gymList.benefits!.length > 4
                  ? ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        cardIconText(
                            isDesktop: isDesktop(),
                            text: gymList.benefits![0].name ?? '',
                            icon: 'assets/gym/raphael_fitocracy.svg'),
                        cardIconText(
                            isDesktop: isDesktop(),
                            text: gymList.benefits![1].name ?? '',
                            icon: 'assets/gym/colorful_man.svg'),
                        cardIconText(
                            isDesktop: isDesktop(),
                            text: gymList.benefits![2].name ?? '',
                            icon: 'assets/gym/Vector.svg'),
                        Container(
                          height: 50,
                          child: Center(
                            child: AdaptiveText(
                              text: "Show \nMore",
                              align: TextAlign.center,
                              minFontSize: 8,
                              maxLines: 2,
                              style: GoogleFonts.montserrat(
                                fontSize: isDesktop()
                                    ? 18
                                    : isSmallMobile()
                                        ? 8
                                        : 10,
                                fontWeight: FontWeight.w500,
                                color: Constants.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: gymList.benefits!.length,
                      itemBuilder: ((context, i) {
                        Benefit data = gymList.benefits![i];

                        return cardIconText(
                            isDesktop: isDesktop(),
                            text: data.name ?? '',
                            icon: 'assets/gym/raphael_fitocracy.svg');
                      }),
                    )),
        ],
      ),
    );
  }

  Widget cardIconText(
      {required String text, required String icon, required bool isDesktop}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: isDesktop
                ? null
                : isSmallMobile()
                    ? 14
                    : 20,
          ),
          SizedBox(height: 4),
          FittedBox(
            child: AdaptiveText(
              text: text,
              align: TextAlign.center,
              minFontSize: 8,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                fontSize: isSmallMobile() ? 8 : 10,
                fontWeight: FontWeight.w300,
                color: Constants.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
