// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/custom_dropdown.dart';
import 'package:wtf_web/utils/const.dart';

class ChoosePlan extends StatefulWidget {
  const ChoosePlan({Key? key}) : super(key: key);

  @override
  State<ChoosePlan> createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  int _selection = 2;
  int _selected = 0;
  int selectedIndex = 0;
  bool grpValue = false;
  selectTime(int? timeSelected) {
    setState(() {
      _selection = timeSelected!;
    });
  }

  select(int index) {
    if (selectedIndex != index)
      setState(() {
        selectedIndex = index;
      });
  }

  String? selectedTimeRange = null;
  List<String> timeRange = [
    '06:00-07:00 AM',
    '07:00-08:00 AM',
    '08:00-09:00 AM',
    '09:00-10:00 AM',
    '10:00-11:00 AM',
    '11:00-12:00 AM',
  ];

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    bool isFullDesktop() => Responsive.isFullDesktop(context);
    bool isMobile() => Responsive.isMobile(context);

    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(isDesktop() ? 48 : 12.0,
          isDesktop() ? height * 0.09 : 30.0, 0, isDesktop() ? 90 : 30),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: isFullDesktop()
                  ? 'col-12 col-sm-12 col-md-7'
                  : 'col-12 col-sm-12 col-md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdaptiveText(
                    text: 'Why to choose WTF?',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: isDesktop() ? 24 : 16,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  new Wrap(
                    direction: Axis.horizontal,
                    spacing: isDesktop() ? 30.0 : 16,
                    runSpacing: 30,
                    children: [
                      whyToChoose(
                          isDesktop: isDesktop(),
                          label: 'Earn WTF rewards coin',
                          icon: 'assets/gym_details/coins.svg'),
                      whyToChoose(
                          isDesktop: isDesktop(),
                          label: 'Fully Vaccinated\nStaff',
                          icon: 'assets/gym_details/vaccine.svg'),
                      whyToChoose(
                          isDesktop: isDesktop(),
                          label: 'Track Fitness \nJourney',
                          icon: 'assets/gym_details/fitness.svg'),
                      whyToChoose(
                          isDesktop: isDesktop(),
                          label: 'Pocket Friendly \nMembership',
                          icon: 'assets/gym_details/money.svg')
                    ],
                  ),
                  SizedBox(height: isDesktop() ? 70 : 30),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 240,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        howItWorks(
                            isDesktop: isDesktop(),
                            leadingIcon: 'assets/gym/emojione_person.svg',
                            text:
                                'Pick membership start ddate and complete your subscription process by clicking Buy Now below.'),
                        howItWorks(
                            isDesktop: isDesktop(),
                            leadingIcon: 'assets/gym/emojione_person.svg',
                            text:
                                'A dedicated general trainer will be assigned after you have taken your subscription.'),
                        howItWorks(
                            isDesktop: isDesktop(),
                            leadingIcon: 'assets/gym/emojione_person.svg',
                            text:
                                'Explore WTF and start your fitness journey.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-5',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectPlan()
                  // chooseTrainer(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget selectPlan() {
    return Container(
      width: 498,
      height: 564,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color(0xff474747).withOpacity(0.59),
      ),
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Column(
        children: [
          AdaptiveText(
            text: 'Select your Plan',
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: ((context, index) {
                return memberPlans(index);
              }),
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 48,
                width: 184,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Color(0xff2F2F2F),
                    border: Border.all(width: 2, color: Constants.white)),
                child: Center(
                  child: AdaptiveText(
                    text: 'Back',
                    minFontSize: 10,
                    align: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Constants.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 48,
                width: 184,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Color(0xff2F2F2F),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xff9A0E0E),
                      Color(0xffDE0000),
                    ],
                  ),
                ),
                child: Center(
                  child: AdaptiveText(
                    text: 'Proceed',
                    minFontSize: 10,
                    align: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Constants.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget memberPlans(int index) {
    return Stack(
      children: [
        Container(
          height: 83,
          margin: EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xff6FAF81),
                Color(0xff598966),
              ],
            ),
          ),
          child: Center(
            child: RadioListTile(
              // toggleable: _selected == index,
              value: _selected != index,
              dense: true,

              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              groupValue: grpValue,
              // selected: _selected == index,
              onChanged: (bool? value) {
                if (_selected != index) {
                  grpValue = value!;
                  //
                  _selected = index;
                  print('Selected plan ===>' + _selected.toString());
                  setState(() {});
                }
              },
              activeColor: Constants.redIconColor,
              title: AdaptiveText(
                text: 'Trial session',
                minFontSize: 10,
                align: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Constants.white,
                ),
              ),
              subtitle: AdaptiveText(
                text: 'Validity : 1 days',
                minFontSize: 10,
                align: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Constants.white,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(top: 12.0),
            height: 48,
            width: 88,
            decoration: BoxDecoration(
              color: Color(0xff7BC18F),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: AdaptiveText(
                text: 'Free',
                minFontSize: 10,
                align: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Constants.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseTrainer() {
    return Container(
      width: 498,
      height: 564,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Constants.cardBlackLight,
      ),
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 32),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdaptiveText(
            text: 'Choose Trainer',
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
          SizedBox(height: 16),
          CustomDropDown(
            width: double.infinity,
            // alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(0),
            onChanged: (String? value) {
              if (value != null) {}
            },
            hint: Text(
              'Mritunjay Saxena',
              style: GoogleFonts.openSans(
                color: Constants.white,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            items: <String>[
              'Mritunjay Saxena',
              'Satinder',
              'Naresh',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 24),
          AdaptiveText(
            text: 'Choose Trainer',
            minFontSize: 14,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: Constants.white,
            ),
          ),
          SizedBox(height: 16),
          CustomDropDown(
            width: double.infinity,
            margin: EdgeInsets.all(0),
            onChanged: (String? value) {},
            hint: AdaptiveText(
              text: 'DD/MM/YY',
              style: GoogleFonts.openSans(
                color: Constants.white,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            items: <String>[].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AdaptiveText(
                  text: 'Choose Trainer',
                  minFontSize: 14,
                  align: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: List<Widget>.generate(
                timeRange.length,
                (int index) {
                  bool isSelected = selectedTimeRange == timeRange[index];
                  return GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Color(0xff5B5B5B) : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: isSelected
                            ? null
                            : Border.all(width: 0.5, color: Constants.white),
                      ),
                      child: AdaptiveText(
                        text: timeRange[index],
                        minFontSize: 10,
                        align: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Constants.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      selectedTimeRange = timeRange[index];

                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 304,
                margin: EdgeInsets.only(top: 33),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Constants.cardBlackLight,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color(0xff9A0E0E),
                      Color(0xffDE0000),
                    ],
                  ),
                ),
                child: Center(
                  child: AdaptiveText(
                    text: 'Proceed',
                    minFontSize: 14,
                    align: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Constants.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget howItWorks(
      {required String text,
      required String leadingIcon,
      required bool isDesktop}) {
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
              fontSize: isDesktop ? 16 : 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget whyToChoose(
      {required String label,
      required String icon,
      double? iconHeight,
      required bool isDesktop}) {
    return new Container(
      height: isDesktop ? 131 : 100,
      width: isDesktop ? 131 : 100,
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
            height: iconHeight != null
                ? iconHeight
                : isDesktop
                    ? 40
                    : 30,
          ),
          SizedBox(height: 10),
          new AdaptiveText(
            text: label,
            maxLines: 2,
            align: TextAlign.center,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              fontSize: isDesktop ? 14 : 8,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
