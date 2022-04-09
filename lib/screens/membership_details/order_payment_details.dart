// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wtf_web/model/membership_plan.dart';
import 'package:wtf_web/model/offers.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/bloc/gym_details_bloc.dart';
import 'package:wtf_web/screens/membership_details/arguments/arguments.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/utils/const.dart';

class OrderPaymentDetails extends StatefulWidget {
  final String gymId;
  final MemberShipDetailsArgument? memberShipDetailsArgument;
  const OrderPaymentDetails(
      {Key? key, required this.gymId, required this.memberShipDetailsArgument})
      : super(key: key);

  @override
  State<OrderPaymentDetails> createState() => _OrderPaymentDetailsState();
}

class _OrderPaymentDetailsState extends State<OrderPaymentDetails> {
  DateTime selectedDate = DateTime.now();

  var customFormat = DateFormat('dd-MM-yyyy');

  Future<Null> showPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Constants.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Constants.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => showPicker(context),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 64, left: 48, right: 48),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Constants.primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AdaptiveText(
                                text: 'Choose Your starting date',
                                minFontSize: 14,
                                style: GoogleFonts.montserrat(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: Constants.white,
                                ),
                              ),
                              selectedDate.minute != DateTime.now().minute
                                  ? AdaptiveText(
                                      text:
                                          '${customFormat.format(selectedDate)}',
                                      minFontSize: 14,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: Constants.white,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(width: 24),
                          Image.asset('assets/membership_details/date.png',
                              height: 60)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Container(
                margin: EdgeInsets.only(left: 48, right: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: 'Order Details',
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                    Container(
                      height: 330,
                      width: 556,
                      margin: EdgeInsets.only(top: 33),
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Constants.cardBlackLight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          orderDetailsRow(
                              firstText: 'Booked at',
                              secondText: 'Mass Monster'),
                          orderDetailsRow(
                              firstText: 'Workout',
                              secondText: 'Gym Membership'),
                          orderDetailsRow(
                              firstText: 'Plan', secondText: 'WTF Active'),
                          orderDetailsRow(
                              firstText: 'WTF Active',
                              secondText: '26 feb 2022'),
                          orderDetailsRow(
                              firstText: 'Subscrition end date',
                              secondText: '26 Mar 2022'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // BootstrapRow(
            //   children: <BootstrapCol>[
            //     BootstrapCol(
            //       sizes: 'col-12 col-sm-12 col-md-6',
            //       child:
            //     ),
            //   ],
            // ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: Container(
                margin: EdgeInsets.only(left: 48, right: 80),
                padding: const EdgeInsets.only(left: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AdaptiveText(
                    //   text: 'Payment Details',
                    //   minFontSize: 14,
                    //   style: GoogleFonts.montserrat(
                    //     fontSize: 30,
                    //     fontWeight: FontWeight.w500,
                    //     fontStyle: FontStyle.normal,
                    //     color: Constants.white,
                    //   ),
                    // ),
                    // Container(
                    //   height: 160,
                    //   // width: 570,
                    //   margin: EdgeInsets.only(top: 33),
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Constants.cardBlackLight,
                    //     gradient: LinearGradient(
                    //       begin: Alignment.centerLeft,
                    //       end: Alignment.centerRight,
                    //       colors: <Color>[
                    //         Constants.gradientGreenLight,
                    //         Constants.gradientGreen,
                    //       ],
                    //     ),
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       paymentDetailsRow(
                    //           firstText: 'Plan Price', secondText: '₹ 2999'),
                    //       paymentDetailsRow(
                    //           firstText: 'GST ( 0%)', secondText: '₹ 0'),
                    //       Container(height: 1, color: Constants.white),
                    //       paymentDetailsRow(
                    //           firstText: 'Total Amount',
                    //           fontWeightFirst: FontWeight.w600,
                    //           secondText: '₹ 2999',
                    //           fontWeightSecond: FontWeight.w600),
                    //     ],
                    //   ),
                    // ),
                    BlocBuilder<GymDetailsBloc, GymDetailsState>(
                      bloc: GymDetailsBloc()
                        ..add(FetchOffersEvent(id: widget.gymId)),
                      builder: (context, state) {
                        // print('Getting offers============>');
                        if (state is FetchOfferState) {
                          List<OffersModel> offer = state.offers;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isDesktop()) SizedBox(height: 30),
                              new AdaptiveText(
                                text: 'Offers Available for you',
                                maxLines: 2,
                                minFontSize: 12,
                                align: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: isMobile() ? 200 : 240,
                                margin: EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      isDesktop() ? 20.0 : 12),
                                  color: Constants.cardBlackLight,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: isDesktop() ? 44 : 16,
                                    vertical: isDesktop() ? 32 : 12),
                                child: ListView.builder(
                                  itemCount: offer.length,
                                  itemBuilder: ((context, index) {
                                    return offers(
                                        title: offer[index].name ?? 'NA',
                                        isDesktop: isDesktop());
                                  }),
                                ),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     offers(
                                //         title: 'New member Offer',
                                //         isDesktop: isDesktop()),
                                //     offers(
                                //         title: '20% OFF for 1st month',
                                //         isDesktop: isDesktop()),
                                //     offers(
                                //         title: '30% OFF on 2nd month',
                                //         isDesktop: isDesktop()),
                                //   ],
                                // ),
                              )
                            ],
                          );
                        }
                        return CustomLoader();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      decoration: BoxDecoration(
                          color: Constants.cardBlackLight,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      height: 81,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Coupon code',
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            color: Constants.white,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AdaptiveText(
                                text: "Apply",
                                align: TextAlign.left,
                                minFontSize: 14,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: Container(
                margin: EdgeInsets.only(right: 48, left: 48, top: 40),
                // padding: const EdgeInsets.only(left: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      text: 'Payment Details',
                      minFontSize: 14,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Constants.white,
                      ),
                    ),
                    Container(
                      height: 160,
                      // width: 570,
                      margin: EdgeInsets.only(top: 33),
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.cardBlackLight,
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            Constants.gradientGreenLight,
                            Constants.gradientGreen,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          paymentDetailsRow(
                              firstText: 'Plan Price',
                              secondText:
                                  '₹ ${widget.memberShipDetailsArgument!.membershipPlan.price}'),
                          paymentDetailsRow(
                              firstText: 'GST ( 0%)', secondText: '₹ 0'),
                          Container(height: 1, color: Constants.white),
                          paymentDetailsRow(
                              firstText: 'Total Amount',
                              fontWeightFirst: FontWeight.w600,
                              secondText: '₹ 2999',
                              fontWeightSecond: FontWeight.w600),
                        ],
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

  Widget offers({required String title, required bool isDesktop}) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: SvgPicture.asset('assets/gym/map_pin.svg'),
      title: new AdaptiveText(
        text: title,
        maxLines: 2,
        minFontSize: 12,
        align: TextAlign.left,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          fontSize: isDesktop ? 20 : 14,
          color: Colors.white,
        ),
      ),
      trailing: Container(
        height: isDesktop ? 46 : 30,
        width: isDesktop ? 127 : 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDesktop ? 4.0 : 2.0),
          color: Constants.primaryColor,
        ),
        child: Center(
          child: new AdaptiveText(
            text: 'Apply',
            minFontSize: 12,
            align: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: isDesktop ? 18 : 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget orderDetailsRow({
    required String firstText,
    required String secondText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdaptiveText(
          text: firstText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
        AdaptiveText(
          text: secondText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
      ],
    );
  }

  Widget paymentDetailsRow(
      {required String firstText,
      required String secondText,
      FontWeight? fontWeightFirst,
      FontWeight? fontWeightSecond}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdaptiveText(
          text: firstText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight:
                fontWeightFirst != null ? fontWeightFirst : FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
        AdaptiveText(
          text: secondText,
          minFontSize: 14,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight:
                fontWeightSecond != null ? fontWeightSecond : FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Constants.white,
          ),
        ),
      ],
    );
  }
}
