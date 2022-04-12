// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wtf_web/model/post_order_id.dart';
import 'package:wtf_web/screens/membership_details/bloc/membership_details_bloc.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/service/payment_service.dart';
import 'package:wtf_web/utils/const.dart';

class PaymentMode extends StatefulWidget {
  const PaymentMode({Key? key}) : super(key: key);

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  int _selection = 1;
  static const platform = const MethodChannel("razorpay_flutter");

  selectTime(int? timeSelected) {
    setState(() {
      _selection = timeSelected!;
    });
  }

  DateTime selectedThirdDate = DateTime.now();
  DateTime selectedSecondDate = DateTime.now();

  var customFormat = DateFormat('dd-MM-yyyy');

  Future<Null> showPickerForSecond(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedSecondDate,
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

    if (picked != null && picked != selectedSecondDate)
      setState(() {
        selectedThirdDate = DateTime.now();

        selectedSecondDate = picked;
      });
  }

  Future<Null> showPickerForThird(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedSecondDate.add(Duration(days: 1)),
      firstDate: selectedSecondDate,
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

    if (picked != null && picked != selectedThirdDate)
      setState(() {
        selectedThirdDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.fromLTRB(66, 60, 90, 90),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-12',
              child: BlocProvider(
                lazy: false,
                create: (context) => MembershipDetailsBloc(),
                // ..add(PostMembershipDetailsEvent(
                //     postOrderIdModel: PostOrderIdModel(amount: '100'))),
                child:
                    BlocBuilder<MembershipDetailsBloc, MembershipDetailsState>(
                  builder: (context, state) {
                    if (state is FetchMembershipDetailsEvent) {
                      print('state called=====>');
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                Radio(
                                  focusColor: Colors.white,
                                  groupValue: _selection,
                                  onChanged: selectTime,
                                  value: 1,
                                  activeColor: Constants.primaryColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Constants.white),
                                ),
                                AdaptiveText(
                                  text: 'Full Payment',
                                  minFontSize: 14,
                                  align: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    color: Constants.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 108),
                            Wrap(
                              children: [
                                Radio(
                                  focusColor: Colors.white,
                                  groupValue: _selection,
                                  onChanged: selectTime,
                                  value: 2,
                                  activeColor: Constants.primaryColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Constants.white),
                                ),
                                AdaptiveText(
                                  text: 'Partial',
                                  minFontSize: 14,
                                  align: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    color: Constants.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        _selection == 2
                            ? Container(
                                // height: 322,
                                decoration: BoxDecoration(
                                    color: Constants.svgIconColor,
                                    borderRadius: BorderRadius.circular(16)),
                                padding: EdgeInsets.fromLTRB(130, 12, 130, 69),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AdaptiveText(
                                      text:
                                          'Pay 2999 now and choose EMI date for your next payment',
                                      minFontSize: 14,
                                      align: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                        color: Constants.white,
                                      ),
                                    ),
                                    SizedBox(height: 45),
                                    selectEMIDateButton(
                                      title: 'Select 1st EMI date',
                                      enabled: false,
                                      amount: '100',
                                      date:
                                          DateTime.now().add(Duration(days: 1)),
                                    ),
                                    SizedBox(height: 20),
                                    selectEMIDateButton(
                                      title: 'Select 2nd EMI date',
                                      enabled: true,
                                      amount: '100',
                                      date: selectedSecondDate,
                                      onTap: () {
                                        showPickerForSecond(context);
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    selectEMIDateButton(
                                      title: 'Select 3rd EMI date',
                                      enabled: selectedSecondDate.day !=
                                              DateTime.now().day
                                          ? true
                                          : false,
                                      amount: '100',
                                      date: selectedThirdDate,
                                      onTap: () {
                                        if (selectedSecondDate.day !=
                                            DateTime.now().day) {
                                          showPickerForThird(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        GestureDetector(
                          onTap: () {
                            print('========>getting start your payment');
                            // openCheckout();
                            // Navigator.pushNamed(context, RazorPayWeb.routeName);
                            // void toastMessage(bool success) {
                            //   ScaffoldMessenger.of(context)
                            //     ..removeCurrentSnackBar()
                            //     ..showSnackBar(
                            //       SnackBar(
                            //         content: Container(
                            //           color: success ? Colors.green : Colors.red,
                            //           padding: const EdgeInsets.all(10),
                            //           child: Text(
                            //             success
                            //                 ? 'Payment Successful'
                            //                 : 'Payment Failed',
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            // }
                            // DBProvider().getOrderId();
                            PaymentService().startPayment(
                              100,
                              'Naresh kukreti',
                              'kukreti12.naresh@gmail.com',
                              () {
                                print('payment success====>');
                              },
                              () {
                                print('payment failed====>');
                              },
                            );
                          },
                          child: Container(
                            height: 66,
                            // width: ,
                            margin: EdgeInsets.only(top: 64),
                            padding: EdgeInsets.symmetric(
                                horizontal: 144, vertical: 20),
                            decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(47)),
                            child: AdaptiveText(
                              text: 'Proceed',
                              minFontSize: 14,
                              align: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Constants.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget selectEMIDateButton(
      {required String title,
      required bool enabled,
      required String amount,
      required DateTime date,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66,
        decoration: BoxDecoration(
            color: enabled
                ? Constants.maroonLight
                : Color(0xffAF4949).withOpacity(0.5),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                date.day != DateTime.now().day
                    ? AdaptiveText(
                        text: '${customFormat.format(date)}',
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
            // Column(
            //   children: [
            //     AdaptiveText(
            //       text: title,
            //       minFontSize: 14,
            //       align: TextAlign.center,
            //       style: GoogleFonts.montserrat(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w300,
            //         fontStyle: FontStyle.normal,
            //         color: Constants.white,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(width: 24),
            Image.asset('assets/membership_details/date.png')
          ],
        ),
      ),
    );
  }
}
