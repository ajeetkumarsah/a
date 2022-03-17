// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class ChoosePlan extends StatefulWidget {
  const ChoosePlan({Key? key}) : super(key: key);

  @override
  State<ChoosePlan> createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  int _selection = 2;

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
      padding: EdgeInsets.fromLTRB(48, height * 0.09, 0, 0),
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
                    style: GoogleFonts.openSans(
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
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 70),
                  AdaptiveText(
                    text: 'Facilities',
                    style: GoogleFonts.openSans(
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
                    style: GoogleFonts.openSans(
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
                    height: 566,
                    width: 642,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Constants.cardBlackLight,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new AdaptiveText(
                          text: 'Choose Membership',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16),
                          shrinkWrap: true,
                          children: [
                            plans(
                              titleColor: Constants.textLightGreen,
                              amount: '₹ 999',
                              offer1: '1 Month membership',
                              offer2: 'Trainer Support',
                              offer3: 'Access to free diet plans',
                              plan: 1,
                              subTitle: 'Best for person who frequently travel',
                              title: 'Active',
                              amountColor: Color(0xff669C75),
                            ),
                            plans(
                              titleColor: Constants.textLightPink,
                              amount: '₹ 999',
                              offer1: '3 Month membership',
                              offer2: 'Trainer Support',
                              offer3: 'Access to free diet plans',
                              plan: 2,
                              subTitle: 'Best for person who frequently travel',
                              title: 'Transform',
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xffB9789B),
                                  Color(0xff89506D),
                                ],
                              ),
                              amountColor: Color(0xffA46284),
                            ),
                            plans(
                              titleColor: Constants.textRedLight,
                              amount: '₹ 999',
                              offer1: '6 Month membership',
                              offer2: 'Trainer Support',
                              offer3: 'Access to free diet plans',
                              plan: 3,
                              subTitle: 'Best for person who frequently travel',
                              title: 'Consistent',
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xff965651),
                                  Color(0xffB43B3B),
                                ],
                              ),
                              amountColor: Color(0xffD24D4D),
                            ),
                            plans(
                              titleColor: Constants.textLightBlue,
                              amount: '₹ 999',
                              offer1: '12 Month membership',
                              offer2: 'Trainer Support',
                              offer3: 'Access to free diet plans',
                              plan: 4,
                              subTitle: 'Best for person who frequently travel',
                              title: 'Lifestyle',
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xff438373),
                                  Color(0xff3E74B4),
                                ],
                              ),
                              amountColor: Color(0xff4C92B5),
                            ),
                          ],
                        ),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border:
                                Border.all(width: 0.2, color: Constants.white),
                            color: Constants.greyLight,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AdaptiveText(
                                text: 'Choose Your starting date',
                                minFontSize: 14,
                                align: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: Constants.white,
                                ),
                              ),
                              SizedBox(width: 24),
                              Image.asset('assets/membership_details/date.png')
                            ],
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

  Widget plans({
    Gradient? gradient,
    required int plan,
    required String amount,
    required String title,
    required String subTitle,
    required String offer1,
    required String offer2,
    required String offer3,
    required Color titleColor,
    Color? amountColor,
  }) {
    return Container(
      width: 341,
      height: 164,
      // margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        gradient: gradient != null
            ? gradient
            : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Constants.gradientGreenLight,
                  Constants.gradientGreen,
                ],
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdaptiveText(
                text: 'PLAN $plan',
                minFontSize: 14,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: Constants.white,
                ),
              ),
              Container(
                height: 27,
                width: 87,
                decoration: BoxDecoration(
                  color: amountColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: AdaptiveText(
                    text: amount,
                    minFontSize: 14,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Constants.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/logo.png', height: 22),
              SizedBox(width: 8.0),
              AdaptiveText(
                text: title,
                minFontSize: 14,
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  color: titleColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AdaptiveText(
              text: subTitle,
              minFontSize: 10,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AdaptiveText(
                  text: '•  $offer1',
                  minFontSize: 10,
                  maxLines: 2,
                  align: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
                AdaptiveText(
                  text: '•  $offer2',
                  minFontSize: 10,
                  maxLines: 2,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
                AdaptiveText(
                  text: '•  $offer3',
                  minFontSize: 10,
                  maxLines: 2,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                        color: Colors.white,
                      ),
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
          style: GoogleFonts.openSans(
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
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
