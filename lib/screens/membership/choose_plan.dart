// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/model/membership_plan.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/bloc/gym_details_bloc.dart';
import 'package:wtf_web/screens/gyms/bloc/gym_bloc.dart';
import 'package:wtf_web/screens/landing/argument/argument.dart';
import 'package:wtf_web/screens/landing/landing_screen.dart';
import 'package:wtf_web/screens/membership_details/arguments/arguments.dart';
import 'package:wtf_web/screens/membership_details/membership_details.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/screens/widgets/empty_data.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/const.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

import '../order_summary/order_summary.dart';

class ChoosePlan extends StatefulWidget {
  final GymDetailsModel gymDetails;
  const ChoosePlan({Key? key, required this.gymDetails}) : super(key: key);

  @override
  State<ChoosePlan> createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  int _selection = 2;
  int selectedIndex = 0;

  selectTime(int? timeSelected) {
    setState(() {
      _selection = timeSelected!;
    });
  }

  MembershipPlan _plan = MembershipPlan();
  select(int index) {
    if (selectedIndex != index)
      setState(() {
        selectedIndex = index;
      });
  }

  void checkAuthForMembershipPlan() async {
    bool isUserLoggedIn =
        await SessionManager.getInstance().getIsUserLoggedIn() != null
            ? await SessionManager.getInstance().getIsUserLoggedIn()
            : false;
    if (isUserLoggedIn) {
      //user found

      Navigator.pushNamed(
        context,
        MembershipDetails.routeName,
        arguments: MemberShipDetailsArgument(
            membershipPlan: _plan, gymDetails: widget.gymDetails),
      );
    } else {
      //user not found
      Navigator.pushReplacementNamed(context, LandingScreen.routeName,
          arguments: LandingPageArgumnet(userLoggedIn: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    GymDetailsModel data = widget.gymDetails;
    var padding = Constants.getPadding(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDesktop() => Responsive.isDesktop(context);
    bool isFullDesktop() => Responsive.isFullDesktop(context);
    bool isMobile() => Responsive.isMobile(context);

    return BootstrapContainer(
      fluid: true,
      padding: EdgeInsets.fromLTRB(0, isDesktop() ? height * 0.09 : 30.0, 0, 0),
      children: [
        Container(
          padding: EdgeInsets.only(
              left: isDesktop() ? 48 : 12.0, right: isDesktop() ? 22 : 12.0),
          child: BootstrapRow(
            children: <BootstrapCol>[
              BootstrapCol(
                sizes: isFullDesktop()
                    ? 'col-12 col-sm-12 col-md-7'
                    : 'col-12 col-sm-12 col-md-12',
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
                    SizedBox(height: isDesktop() ? 30 : 12),
                    AdaptiveText(
                      text: data.description ?? '',
                      maxLines: 6,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          fontSize: isDesktop() ? 14 : 10,
                          color: Colors.white),
                    ),
                    SizedBox(height: isDesktop() ? 70 : 20),
                    AdaptiveText(
                      text: 'Facilities',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: isDesktop() ? 24 : 12,
                          color: Colors.white),
                    ),
                    SizedBox(height: isDesktop() ? 30 : 12.0),
                    data.benefits != null && data.benefits!.isNotEmpty
                        ? Container(
                            // padding: EdgeInsets.all(12.0),
                            height: 120,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: data.benefits!.length,
                              itemBuilder: ((context, index) {
                                return facilities(
                                    height: isDesktop() ? null : 30,
                                    isDesktop: isDesktop(),
                                    label: data.benefits![index].name ?? '',
                                    icon: data.benefits![index].image ?? '');
                              }),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: isDesktop() ? 40 : 20),
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
                    SizedBox(height: isDesktop() ? 40 : 20),
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
                              fontSize: isDesktop() ? 24 : 18,
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
                                    isDesktop: isDesktop(),
                                    leadingIcon:
                                        'assets/gym/emojione_person.svg',
                                    text:
                                        'Pick membership start ddate and complete your subscription process by clicking Buy Now below.'),
                                howItWorks(
                                    isDesktop: isDesktop(),
                                    leadingIcon:
                                        'assets/gym/emojione_person.svg',
                                    text:
                                        'A dedicated general trainer will be assigned after you have taken your subscription.'),
                                howItWorks(
                                    isDesktop: isDesktop(),
                                    leadingIcon:
                                        'assets/gym/emojione_person.svg',
                                    text:
                                        'Explore WTF and start your fitness journey.'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-sm-12 col-md-5',
                child: BlocBuilder<GymDetailsBloc, GymDetailsState>(
                  bloc: GymDetailsBloc()
                    ..add(FetchGymPlanEvent(id: widget.gymDetails.userId!)),
                  builder: (context, state) {
                    if (state is FetchMembershipPlanState) {
                      List<MembershipPlan> membershipPlan =
                          state.membershipPlan;
                      return membershipPlan.isEmpty
                          ? EmptyDataScreen()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // height: 566,
                                  width: 650,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Constants.cardBlackLight,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      SizedBox(height: 30),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: membershipPlan.length,
                                          itemBuilder: (BuildContext? context,
                                              int index) {
                                            return plans(
                                              index: index,
                                              isMobile: isMobile(),
                                              membershipPlan:
                                                  membershipPlan[index],
                                              titleColor: membershipoPlans[0]
                                                  .titleColor,
                                              amountColor: membershipoPlans[0]
                                                  .amountColor,
                                            );
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            );
                    }

                    return CustomLoader();
                  },
                ),
              ),
            ],
          ),
        ),
        BootstrapContainer(
          fluid: true,
          decoration: BoxDecoration(color: Color(0xff181818)),
          children: [
            BootstrapRow(
              children: <BootstrapCol>[
                BootstrapCol(
                  sizes: 'col-12 col-sm-12 col-md-6',
                  child: Container(
                    // padding: EdgeInsets.fromLTRB(isDesktop() ? 48 : 12.0,
                    //     height * 0.1, isDesktop() ? 67 : 12.0, 0),
                    margin: EdgeInsets.symmetric(vertical: height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                checkAuthForMembershipPlan();
                              },
                              child: Container(
                                height: isDesktop() ? 66 : 40,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal:
                                        isDesktop() || isMobile() ? 141 : 100),
                                margin: EdgeInsets.symmetric(
                                    horizontal: isDesktop() ? 10 : 0,
                                    vertical: isDesktop() ? 12.0 : 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Constants.maroon,
                                ),
                                child: Row(
                                  children: [
                                    new AdaptiveText(
                                      text: 'Buy now',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: isDesktop() ? 18 : 14,
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
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-12 col-sm-12 col-md-6',
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: isDesktop() ? 66 : 40,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal:
                                      isDesktop() || isMobile() ? 64 : 32),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 0.5, color: Constants.white)),
                              child: Row(
                                children: [
                                  new AdaptiveText(
                                    text: 'Book 1 day free session',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: isDesktop() ? 18 : 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    // return BlocProvider(
    //   create: (context) => GymDetailsBloc()..add(FetchGymDetailsEvent(uid: '')),
    //   child: BlocConsumer<GymDetailsBloc, GymDetailsState>(
    //     listener: (context, state) {
    //       if (state is GymDetailsInitial) {}
    //     },
    //     builder: (context, state) {
    //       if (state is MembershipPlan) return CircularProgressIndicator();
    //     },
    //   ),
    // );
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

  Widget plans({
    Gradient? gradient,
    // required Function(int) onTap,
    required MembershipPlan membershipPlan,
    required Color titleColor,
    required bool isMobile,
    required int index,
    Color? amountColor,
  }) {
    // amount:
    //     membershipPlan[index].price!,
    // offer1: '',
    // offer2: '',
    // offer3: '',
    // plan: index + 1,
    // subTitle: membershipPlan[index]
    //         .description ??
    //     '',
    // title: membershipPlan[index]
    //     .planName!,
    String htmlData = membershipPlan.description ?? '';
    dom.Document document = htmlparser.parse(htmlData);
    return GestureDetector(
      onTap: () {
        _plan = membershipPlan;
        select(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.fromLTRB(isMobile ? 8 : 12.0, isMobile ? 8 : 12.0,
            12.0, isMobile ? 8 : 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: selectedIndex == index
              ? Border.all(width: 2, color: Constants.white)
              : null,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdaptiveText(
                  text: 'PLAN ${index + 1}',
                  minFontSize: 10,
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile ? 12 : 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Constants.white,
                  ),
                ),
                Container(
                  // height: isMobile ? 17 : 27,
                  // width: isMobile ? 60 : 87,
                  decoration: BoxDecoration(
                    color: amountColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  margin: EdgeInsets.all(0),
                  child: Center(
                    child: AdaptiveText(
                      text: '\u{20B9} ' + '${membershipPlan.price}',
                      minFontSize: 10,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 10 : 16,
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
                Image.asset('assets/logo.png', height: isMobile ? 14 : 22),
                SizedBox(width: 8.0),
                Expanded(
                  // fit: BoxFit.cover,
                  child: AdaptiveText(
                    text: '${membershipPlan.planName}',
                    minFontSize: 10,
                    style: GoogleFonts.montserrat(
                      fontSize: isMobile ? 14 : 22,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      color: titleColor,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Expanded(
                child: Html(
                    defaultTextStyle: TextStyle(color: Constants.white),
                    data: """${membershipPlan.description ?? ''}"""),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       AdaptiveText(
            //         text: '•  $offer1',
            //         minFontSize: 10,
            //         maxLines: 2,
            //         align: TextAlign.left,
            //         style: GoogleFonts.montserrat(
            //           fontSize: isMobile ? 10 : 14,
            //           fontWeight: FontWeight.w300,
            //           fontStyle: FontStyle.normal,
            //           color: Constants.white,
            //         ),
            //       ),
            //       AdaptiveText(
            //         text: '•  $offer2',
            //         minFontSize: 10,
            //         maxLines: 2,
            //         style: GoogleFonts.montserrat(
            //           fontSize: isMobile ? 10 : 14,
            //           fontWeight: FontWeight.w300,
            //           fontStyle: FontStyle.normal,
            //           color: Constants.white,
            //         ),
            //       ),
            //       AdaptiveText(
            //         text: '•  $offer3',
            //         minFontSize: 10,
            //         maxLines: 2,
            //         style: GoogleFonts.montserrat(
            //           fontSize: isMobile ? 10 : 14,
            //           fontWeight: FontWeight.w300,
            //           fontStyle: FontStyle.normal,
            //           color: Constants.white,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
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
      {required String icon,
      required String label,
      double? height,
      required bool isDesktop}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Image.network(
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
                fontSize: isDesktop ? 16 : 12,
                color: Colors.white),
          ),
        ],
      ),
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

  List<MemberShip> membershipoPlans = [
    MemberShip(
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
    MemberShip(
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
    MemberShip(
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
    MemberShip(
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
  ];
}

class MemberShip {
  final Gradient? gradient;
  final int plan;
  final String amount;
  final String title;
  final String subTitle;
  final String offer1;
  final String offer2;
  final String offer3;
  final Color titleColor;
  final Color? amountColor;

  MemberShip({
    this.gradient,
    required this.plan,
    required this.amount,
    required this.title,
    required this.subTitle,
    required this.offer1,
    required this.offer2,
    required this.offer3,
    required this.titleColor,
    this.amountColor,
  });
}
