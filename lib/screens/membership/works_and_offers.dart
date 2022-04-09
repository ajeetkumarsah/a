// ignore_for_file: unused_local_variable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/offers.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/bloc/gym_details_bloc.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/utils/const.dart';

import '../widgets/adaptiveText.dart';

class WorksAndOffers extends StatefulWidget {
  final String gymId;
  const WorksAndOffers({Key? key, required this.gymId}) : super(key: key);

  @override
  State<WorksAndOffers> createState() => _WorksAndOffersState();
}

class _WorksAndOffersState extends State<WorksAndOffers> {
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
      padding: EdgeInsets.fromLTRB(48, height * 0.09, 67, 0),
      children: [
        BootstrapRow(
          children: <BootstrapCol>[
            BootstrapCol(
              sizes: 'col-12 col-sm-12 col-md-6',
              child: BlocBuilder<GymDetailsBloc, GymDetailsState>(
                bloc: GymDetailsBloc()..add(FetchOffersEvent(id: widget.gymId)),
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
                            borderRadius:
                                BorderRadius.circular(isDesktop() ? 20.0 : 12),
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
            ),
          ],
        ),
      ],
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
}
