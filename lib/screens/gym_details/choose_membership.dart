// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class ChooseMembership extends StatefulWidget {
  const ChooseMembership({Key? key}) : super(key: key);

  @override
  State<ChooseMembership> createState() => _ChooseMembershipState();
}

class _ChooseMembershipState extends State<ChooseMembership> {
  int _selection = 0;

  selectTime(int? timeSelected) {
    setState(() {
      _selection = timeSelected!;
    });
  }

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
              sizes: 'col-12 col-sm-12 col-md-7',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdaptiveText(
                    text: 'Description',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  AdaptiveText(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus massa, morbi habitasse posuere condimentum in mi nunc nunc. In fermentum ut nulla tempor amet, a nibh vitae. In laoreet lacus suspendisse duis senectus consectetur bibendum. Vitae sed ultrices sollicitudin sagittis. In nibh ac dolor hendrerit.',
                    maxLines: 6,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 70),
                  AdaptiveText(
                    text: 'Facilities',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  new Wrap(
                    direction: Axis.horizontal,
                    spacing: 60.0,
                    runAlignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      facilities(
                          label: 'Modern \nEqipments',
                          icon: 'assets/gym/raphael_fitocracy.svg'),
                      facilities(
                          label: 'Skilled \nTrainer',
                          icon: 'assets/gym/emojione_person.svg'),
                      facilities(
                          label: 'Top class \nAmbiance',
                          icon: 'assets/gym/Vector.svg',
                          height: 50),
                      facilities(
                          label: 'Sanitized \nGYMS',
                          icon: 'assets/gym/fluent_sanitize.svg'),
                    ],
                  ),
                  const SizedBox(height: 70),
                  AdaptiveText(
                    text: 'Why to choose WTF?',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  new Wrap(
                    direction: Axis.horizontal,
                    spacing: 30.0,
                    children: [
                      whyToChoose(
                          label: 'Earn WTF rewards coin',
                          icon: 'assets/gym_details/coins.svg'),
                      whyToChoose(
                          label: 'Fully Vaccinated\nStaff',
                          icon: 'assets/gym_details/vaccine.svg'),
                      whyToChoose(
                          label: 'Track Fitness \nJourney',
                          icon: 'assets/gym_details/fitness.svg'),
                      whyToChoose(
                          label: 'Pocket Friendly \nMembership',
                          icon: 'assets/gym_details/money.svg')
                    ],
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-5',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 539,
                    width: 440,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Constants.cardBlackLight,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        new AdaptiveText(
                          text: 'Choose Membership',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 12.0),
                          height: 1,
                          decoration: BoxDecoration(
                              color: Constants.white,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selection = 1;
                            });
                          },
                          child: pricingButton(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Constants.gradientGreenLight,
                                Constants.gradientGreen,
                              ],
                            ),
                            label: '₹ 1500 for 3 months',
                            value: 1,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selection = 2;
                            });
                          },
                          child: pricingButton(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Constants.gradientBlueLight,
                                Constants.gradientBlue,
                              ],
                            ),
                            label: '₹ 4500 for 6 months',
                            value: 2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selection = 3;
                            });
                          },
                          child: pricingButton(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Constants.gradientVioletLight,
                                Constants.gradientViolet,
                              ],
                            ),
                            label: '₹ 6000 for 12 months',
                            value: 3,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12.0),
                          child: Center(
                            child: new AdaptiveText(
                              text: 'Buy now',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(32),
                              border:
                                  Border.all(width: 1, color: Constants.white)),
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12.0),
                          child: Center(
                            child: new AdaptiveText(
                              text: 'Book 1 day free session',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        )
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

  Widget pricingButton({
    required String label,
    required int value,
    required Gradient? gradient,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(width: 30),
            Radio(
              focusColor: Colors.white,
              groupValue: _selection,
              onChanged: selectTime,
              value: value,
              activeColor: Constants.primaryColor,
              fillColor:
                  MaterialStateColor.resolveWith((states) => Constants.white),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: gradient != null
                      ? gradient
                      : LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            Constants.gradientBlueLight,
                            Constants.gradientBlue,
                          ],
                        ),
                ),
                child: Row(
                  children: [
                    new AdaptiveText(
                      text: label,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget facilities(
      {required String icon, required String label, double? height}) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          color: Constants.primaryColor,
          height: height != null ? height : 60,
        ),
        SizedBox(height: 10),
        new AdaptiveText(
          text: label,
          maxLines: 3,
          align: TextAlign.center,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              fontSize: 16,
              color: Colors.white),
        ),
      ],
    );
  }

  Widget whyToChoose(
      {required String label, required String icon, double? iconHeight}) {
    return new Container(
      height: 131,
      width: 131,
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: iconHeight != null ? iconHeight : 40,
          ),
          SizedBox(height: 10),
          new AdaptiveText(
            text: label,
            maxLines: 2,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
