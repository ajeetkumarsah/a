// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/diet.dart';
import 'package:wtf_web/model/onboarding4.dart';
import 'package:wtf_web/model/type1_type2.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/landing/argument/argument.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:wtf_web/screens/package/flutter_fluid_slider.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/alert_flash.dart';
import 'package:wtf_web/screens/widgets/custom_dropdown.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/session_manager/global_data.dart';
import 'package:wtf_web/utils/const.dart';
import 'package:wtf_web/utils/custom_painter.dart';

class OnboardingScreen extends StatelessWidget {
  static String routeName = '/OnboardingScreen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.black,
      body: Material(
        child: OnboardingFlow(),
      ),
    );
  }
}

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({Key? key}) : super(key: key);

  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  bool isDesktop() => Responsive.isDesktop(context);
  bool isMobile() => Responsive.isMobile(context);
  List<String> icons = [];
  double _value = 0.3;
  int selected = 0;
  bool smoke = false, drink = false;
  List<String> selectAge =
      new List<String>.generate(100, (i) => (i + 1).toString());
  List<String> selectHeight =
      new List<String>.generate(200, (i) => (i + 1).toString());
  var editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    icons = [
      'assets/signup/onboard1.png',
      'assets/signup/onboard2.png',
      'assets/signup/onboard3.png',
      'assets/signup/onboard4.png'
    ];
  }

  String? bmrResult;
  Type1Type2Model? type1, type2;
  List<Onboarding4> onboarding4 = [
    Onboarding4(
        title: 'Eat',
        subtitle: ' 1610 calories / day',
        icon: 'assets/onboarding/apple.gif'),
    Onboarding4(
        title: 'Drink',
        subtitle: '4L water / day',
        icon: 'assets/onboarding/glass.gif'),
    Onboarding4(
        title: 'Walk',
        subtitle: '8000 steps / day',
        icon: 'assets/onboarding/walking.gif'),
    Onboarding4(
        title: 'Burn',
        subtitle: '500 calories / day',
        icon: 'assets/onboarding/pushups.gif'),
  ];
  List<DietModel> diets = [
    DietModel(
        title: 'Eggeterian',
        icon: 'assets/onboarding/egg.svg',
        coloredIcon: 'assets/onboarding/Coloured_egg.svg'),
    DietModel(
        title: 'Non-vegeterian',
        icon: 'assets/onboarding/nonveg.svg',
        coloredIcon: 'assets/onboarding/Coloured_nonveg.svg'),
    DietModel(
        title: 'Vegeterian',
        icon: 'assets/onboarding/veg.svg',
        coloredIcon: 'assets/onboarding/Coloured_veg.svg'),
  ];
  String? selectedFitnessGoal = null, selectedDiet = null;
  List<String> fitnessGoal = ['Lean', 'Gain', 'Maintain'];
  List<String> condition = [
    'Diabeties',
    'Cholesterol',
    'Hypertension',
    'PCOS',
    'Thyroid',
    'Physical Injury',
    'Excessive Stress/Anxiety',
    'Depression',
    'Anger issue',
    'Other',
    'None of the above',
  ];
  List<String> selectedItems = [];
  final _bloc = OnboardingBloc();
  String userAge = 'Select your age',
      userBodyType = 'Select your body Type',
      userHeight = 'Height in cm',
      userWeight = 'Weight in kg',
      userGender = 'Gender',
      userTargetWeight = 'Target weight in kg',
      userExperience = 'Workout Experience',
      other = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final pages = [
      // onBoarding3(),
      onBoarding1(),
      onBoarding2(width),
      onBoarding3(),
      onBoarding4(),
    ];

    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
          // bloc: _bloc,
          listener: (context, state) async {
        if (state is PostOnboardingEvent) {
          print('Inside Listener====>');
          // if (state.) {
          // } else {
          //   print('=========>Login Failed');
          // }
        }
      }, builder: (context, state) {
        return Container(
          height: height,
          // width: double.infinity,
          child: PageView.builder(
            controller: controller,
            // pageSnapping: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: pages.length,
            itemBuilder: (_, index) {
              return baseContainer(
                  height: height, icon: icons[index], child: pages[index]);
            },
          ),
        );
      }),
    );
  }

  Widget onBoarding1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdaptiveText(
              text: 'Let us know more about You',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userAge = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userAge,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: selectAge.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userBodyType = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userBodyType,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>[
                    'Lean',
                    'Skinny',
                    'Average',
                    'Athletic',
                    'Overweight',
                    'Heavy'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userHeight = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userHeight,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: selectHeight.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userTargetWeight = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userTargetWeight,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: selectHeight.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userGender = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userGender,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items:
                      <String>['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userExperience = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userExperience,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: <String>['Almost never', 'Sometimes', 'Actively']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomDropDown(
                  onChanged: (String? value) {
                    if (value != null) {
                      userWeight = value;
                      setState(() {});
                    }
                  },
                  hint: Text(
                    userWeight,
                    style: GoogleFonts.openSans(
                      color: Constants.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  items: selectHeight.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 56)
              ],
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAge != 'Select your age' &&
                      userBodyType != 'Select your body Type' &&
                      userHeight != 'Height in cm' &&
                      userWeight != 'Weight in kg' &&
                      userGender != 'Gender' &&
                      userTargetWeight != 'Target weight in kg' &&
                      userExperience != 'Workout Experience') {
                    controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                  } else {
                    AlertFlash().showBasicsFlash(
                        context: context,
                        message: 'Please select all the required fields');
                  }
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBoarding2(double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.white,
              ),
            ),
            AdaptiveText(
              text: 'How Fast do you want to achieve this goal?',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
            SizedBox()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 106.0, vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '${_value.toStringAsFixed(2)}  kg/week',
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Constants.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  FluidSlider(
                    value: _value,
                    start: AutoSizeText(
                      '0.0',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Constants.white,
                      ),
                    ),
                    end: AutoSizeText(
                      '1.5',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Constants.white,
                      ),
                    ),
                    onChanged: (double newValue) {
                      setState(() {
                        _value = newValue;
                      });
                    },
                    sliderColor: Color(0xff424242).withOpacity(0.4),
                    min: 0.0,
                    max: 1.5,
                    thumbColor: Constants.primaryColor,
                    showDecimalValue: true,
                    valueTextStyle: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Constants.white,
                    ),
                    width: width * 0.45,
                  ),
                  SizedBox(height: 16),
                  AutoSizeText(
                    ' Do you have any special medical Condition?',
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Constants.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: width * 0.4,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 12,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: List<Widget>.generate(
                        condition.length,
                        (int index) {
                          bool isSelected =
                              selectedItems.contains(condition[index]);
                          return GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Constants.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: isSelected
                                    ? null
                                    : Border.all(
                                        width: 0.5, color: Constants.white),
                              ),
                              child: Text(condition[index],
                                  style: GoogleFonts.openSans(
                                      color: Constants.white)),
                            ),
                            onTap: () {
                              if (index == condition.length - 2) {
                                context.showFlashDialog(
                                    backgroundColor: Constants.blackCardColor,
                                    constraints: BoxConstraints(maxWidth: 300),
                                    persistent: true,
                                    title: Text(
                                      'Please enter Other reason',
                                      style: GoogleFonts.openSans(
                                          color: Constants.white),
                                    ),
                                    content: Form(
                                      child: TextFormField(
                                        cursorColor: Colors.white,
                                        controller: editingController,
                                        style: GoogleFonts.openSans(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        autofocus: true,
                                      ),
                                    ),
                                    negativeActionBuilder:
                                        (context, controller, _) {
                                      return FlatButton(
                                          color: Constants.white,
                                          onPressed: () {
                                            controller.dismiss();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.openSans(
                                                color: Constants.redIconColor),
                                          ));
                                    },
                                    positiveActionBuilder:
                                        (context, controller, _) {
                                      return FlatButton(
                                          color: Constants.redIconColor,
                                          onPressed: () {
                                            if (editingController
                                                .text.isNotEmpty) {
                                              selectedItems.clear();
                                              selectedItems
                                                  .add(condition[index]);

                                              setState(() {});
                                              controller.dismiss();
                                            } else {
                                              AlertFlash().showBasicsFlash(
                                                  context: context,
                                                  message:
                                                      'Please enter your medical condition');
                                            }
                                          },
                                          child: Text(
                                            'Next',
                                            style: GoogleFonts.openSans(
                                                color: Constants.white),
                                          ));
                                    });
                              } else if (index == condition.length - 1) {
                                selectedItems.clear();
                                selectedItems.add(condition[index]);
                              } else {
                                if (selectedItems
                                    .contains(condition[condition.length - 1]))
                                  selectedItems
                                      .remove(condition[condition.length - 1]);
                                if (selectedItems
                                    .contains(condition[condition.length - 2]))
                                  selectedItems
                                      .remove(condition[condition.length - 2]);
                                if (selectedItems.contains(condition[index])) {
                                  // print('Condition called item removed====>');
                                  selectedItems.remove(condition[index]);
                                } else {
                                  selectedItems.add(condition[index]);
                                  // print('Condition called item added====>');
                                }
                              }
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (selectedItems.isEmpty) {
                    AlertFlash().showBasicsFlash(
                        context: context,
                        message: 'Please select your medical condition');
                  } else
                    controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF9A0E0E),
                        Color(0xFFDE0000),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBoarding3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.white,
              ),
            ),
            AdaptiveText(
              text: 'What is your fitness goal?',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
            SizedBox()
          ],
        ),
        SizedBox(height: 24),
        BlocConsumer<OnboardingBloc, OnboardingState>(
          bloc: _bloc..add(FetchType1Event(type: 'type2')),
          listener: (context, state) {
            if (state is FetchedType1State) {
              print('<===================From State type1===========>');
            }
          },
          builder: (context, state) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 32,
              runSpacing: 2,
              children: List<Widget>.generate(
                globalData.typeList?.length ?? 3,
                (int index) {
                  bool isSelected = (selectedFitnessGoal == fitnessGoal[index]);
                  return GestureDetector(
                    onTap: () {
                      selectedFitnessGoal = fitnessGoal[index];
                      type1 = globalData.typeList?[index];
                      setState(() {});
                    },
                    child: Container(
                      // width: 374,
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 178),
                      height: 58,
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: isSelected
                            ? Constants.primaryColor
                            : Color(0xff424242),
                        gradient: isSelected
                            ? LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF9A0E0E),
                                  Color(0xFFDE0000),
                                ],
                                stops: [0.1, 1],
                              )
                            : null,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Center(
                        child: AdaptiveText(
                          text: globalData.typeList?[index].value ?? '',
                          minFontSize: 14,
                          align: TextAlign.center,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 32),
        AdaptiveText(
          text: 'Diet Preference',
          minFontSize: 14,
          align: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
        SizedBox(height: 24),
        BlocConsumer<OnboardingBloc, OnboardingState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is FetchedType1State) {
                // print('<===================From State type2===========>');
              }
            },
            builder: (context, state) {
              if (state is FetchedType1State) {
                List<Type1Type2Model> type2Data = state.type1type2model;
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 32,
                  runSpacing: 2,
                  children: List<Widget>.generate(
                    type2Data.length,
                    (int index) {
                      bool isSelected = (selectedDiet == diets[index].title);
                      return GestureDetector(
                        onTap: () {
                          selectedDiet = diets[index].title;
                          type2 = type2Data[index];
                          setState(() {});
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(minWidth: 60, maxWidth: 83),
                              height: 83,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: SvgPicture.asset(
                                isSelected
                                    ? diets[index].coloredIcon
                                    : diets[index].icon,
                                height: 83,
                                width: 83,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            AdaptiveText(
                              text: type2Data[index].value ?? '',
                              minFontSize: 10,
                              align: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return CustomLoader();
            }),
        SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AdaptiveText(
                  text: 'Smoke',
                  minFontSize: 10,
                  align: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
                Switch(
                  value: smoke,
                  activeColor: Constants.primaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      smoke = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AdaptiveText(
                  text: 'Drink',
                  minFontSize: 10,
                  align: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
                Switch(
                  value: drink,
                  activeColor: Constants.primaryColor,
                  onChanged: (bool value) {
                    setState(() {
                      drink = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (selectedFitnessGoal == null) {
                    AlertFlash().showBasicsFlash(
                        context: context,
                        message: 'Please select your Fitness goal');
                  } else if (selectedDiet == null) {
                    AlertFlash().showBasicsFlash(
                        context: context,
                        message: 'Please select your Diet preference');
                  } else
                    controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBoarding4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.white,
              ),
            ),
            AdaptiveText(
              text: 'To reach 0.25 kg per week you need to?',
              minFontSize: 14,
              align: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Constants.white,
              ),
            ),
            SizedBox()
          ],
        ),
        Container(
          height: 240,
          margin: EdgeInsets.only(top: 54),
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 0 : 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      height: 172,
                      width: 172,
                      decoration: BoxDecoration(
                        color: Color(0xff383838),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            onboarding4[index].icon,
                            height: 90,
                          ),
                          AdaptiveText(
                            text: onboarding4[index].title,
                            minFontSize: 14,
                            align: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              color: Constants.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AdaptiveText(
                      text: onboarding4[index].subtitle,
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: JumpingDotEffect(
                      radius: 12,
                      activeDotColor: Constants.redIconColor,
                      dotColor: Color(0xff3F3F3F),
                      dotHeight: 12,
                      dotWidth: 12,
                      jumpScale: .5,
                      verticalOffset: 15,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //navigate
                  _bloc.add(
                    PostOnboardingEvent(
                      memberShip: AddMembershipModel(
                        age: userAge,
                        gender: userGender,
                        height: userHeight + '_cm',
                        weight: userWeight + '_kg',
                        targetWeight: userTargetWeight,
                        targetDuration: _value.toString(),
                        bodyType: userBodyType,
                        existingDisease: selectedItems[0] == 'Other'
                            ? editingController.text
                            : selectedItems.join(","),
                        isSmoking: smoke.toString(),
                        isDrinking: drink.toString(),
                        howactive: userExperience,
                        type1: type1?.uid,
                        type2: type2?.uid,
                      ),
                      context: context,
                    ),
                  );
                  Navigator.pushReplacementNamed(
                      context, LandingScreen.routeName,
                      arguments: LandingPageArgumnet(userLoggedIn: true));
                },
                child: Container(
                  height: 46,
                  width: 126,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFDE0000),
                        Color(0xFF9A0E0E),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AdaptiveText(
                      text: 'Next',
                      minFontSize: 14,
                      align: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget baseContainer({double? height, required Widget child, String? icon}) {
    return Column(
      children: [
        BootstrapContainer(
          fluid: true,
          decoration: const BoxDecoration(color: Constants.black),
          padding: EdgeInsets.all(0),
          children: [
            Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Constants.black,
                image: DecorationImage(
                  image: AssetImage(
                      icon != null ? icon : 'assets/signup/onboard2.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              alignment: Alignment.center,
              // padding: EdgeInsets.only(top: isDesktop() ? 80 : 150),
              child: Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff000000),
                      Color(0xff000000).withOpacity(0.61),
                      Color(0xff000000)
                    ],
                    // stops: [0.1, 1, 0.1],
                  ),
                ),
                child: BootstrapRow(
                  children: <BootstrapCol>[
                    BootstrapCol(
                      sizes: 'col-12 col-md-12 col-sm-12',
                      child: Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 10,
                              left: 288,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 86,
                                    blurSigma: 1.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 350,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 20,
                                    blurSigma: 1.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              right: 284,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 104,
                                    blurSigma: 1.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              right: 204,
                              child: CustomPaint(
                                foregroundPainter: CircleBlurPainter(
                                    circleWidth: 40,
                                    blurSigma: 2.0,
                                    color: Constants.primaryColor),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: 538,
                                    minHeight: 400,
                                    maxWidth: 874,
                                    minWidth: 600),
                                // width: 874,
                                // height: 538,
                                margin:
                                    EdgeInsets.only(top: isDesktop() ? 90 : 30),
                                padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1D1D1D),
                                      Color(0xFF494949).withOpacity(0.31),
                                    ],
                                    stops: [0.1, 1],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: child,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  // bmrForMen(
  //     {required BuildContext context,
  //     required num weight,
  //     required num height,
  //     required num age,
  //     bool openBmtResult = true}) {
  //   this.weight = weight;
  //   this.height = height;
  //   this.age = age;

  //   bmrResult = (10 * weight / 1 + 6.25 * height / 1 - 5 * age / 1 + 5)
  //       .toStringAsFixed(2);
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     notifyListeners();
  //   });
  //   if (openBmtResult) {
  //     saveProgress(context: context);
  //   }
  // }

  // bmrForWoMen(
  //     {required BuildContext context,
  //     required num weight,
  //     required num height,
  //     required num age,
  //     bool openBmtResult = true}) {
  //   this.weight = weight;
  //   this.height = height;
  //   this.age = age;
  //   bmrResult = (10 * weight / 1 + 6.25 * height / 1 - 5 * age / 1 - 161)
  //       .toStringAsFixed(2);
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     notifyListeners();
  //   });
  //   if (openBmtResult) {
  //     saveProgress(
  //       context: context,
  //     );
  //   }
  // }
}
