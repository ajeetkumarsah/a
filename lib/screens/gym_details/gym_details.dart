import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/model/membership_plan.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/gym_details/bloc/gym_details_bloc.dart';
import 'package:wtf_web/screens/gym_details/train_live.dart';
import 'package:wtf_web/screens/membership/about_gym.dart';
import 'package:wtf_web/screens/membership/buy_or_book_button.dart';
import 'package:wtf_web/screens/membership/choose_plan.dart';
import 'package:wtf_web/screens/membership/works_and_offers.dart';
import 'package:wtf_web/screens/widgets/bottom_bar.dart';
import 'package:wtf_web/screens/helper/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/utils/const.dart';

import 'fun_session.dart';

class GymDetails extends StatefulWidget {
  static String routeName = '/GymDetails';

  const GymDetails({Key? key}) : super(key: key);

  @override
  _GymDetailsState createState() => _GymDetailsState();
}

class _GymDetailsState extends State<GymDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print('ID================>' + args['id'].toString());

    return BlocProvider(
      lazy: false,
      create: (context) => GymDetailsBloc()
        ..add(FetchGymDetailsEvent(uid: args['id'].toString())),
      child: Scaffold(
        backgroundColor: Constants.black,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    BlocBuilder<GymDetailsBloc, GymDetailsState>(
                      builder: (context, state) {
                        if (state is FetchGymDetailsState) {
                          GymDetailsModel data = state.gymDetails;
                          return Container(
                            constraints: const BoxConstraints(
                                minHeight: 400, maxHeight: 488),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                height: 488,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                              ),
                              items: data.gallery != null &&
                                      data.gallery!.isNotEmpty
                                  ? data.gallery!.map((gym) {
                                      return Container(
                                        constraints: const BoxConstraints(
                                            minHeight: 400, maxHeight: 488),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              gym.images!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      Container(
                                        constraints: const BoxConstraints(
                                            minHeight: 400, maxHeight: 488),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/membership/banner.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                            minHeight: 400, maxHeight: 488),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/membership/banner.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                            ),
                          );
                        }
                        return CustomLoader();
                      },
                    ),
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 400, maxHeight: 488),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.center,
                          colors: [
                            Color(0xff000000),
                            Color(0xff000000).withOpacity(0.3),
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 400, maxHeight: 488),
                      child: Stack(
                        // alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 12, right: 88, top: 60, bottom: 50),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                AdaptiveText(
                                  text: 'Back',
                                  minFontSize: 14,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.white,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocBuilder<GymDetailsBloc, GymDetailsState>(
                  builder: (context, state) {
                    if (state is FetchGymDetailsState) {
                      GymDetailsModel data = state.gymDetails;
                      if (data.id != null) {
                        // return MembershipAboutGym(gymDetails: data);
                        return Column(
                          children: [
                            MembershipAboutGym(gymDetails: data),
                            ChoosePlan(gymDetails: data)
                          ],
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text('No Data found'),
                          ),
                        );
                      }
                    }
                    return CustomLoader();
                  },
                ),

                // WorksAndOffers(gymId: args['id'].toString()),
                // const BuyOrbookScreen(),
                const TrainLive(),
                const FunSession(),
                const BottomBar(
                  color: Color(0xff292929),
                ),
              ],
            )
            // Column(
            //             mainAxisSize: MainAxisSize.max,
            //             children: [
            //               Container(
            //                 constraints:
            //                     const BoxConstraints(minHeight: 400, maxHeight: 700),
            //                 child: Stack(
            //                   children: [
            //                     Align(
            //                       alignment: Alignment.bottomRight,
            //                       child: Image.asset(
            //                         'assets/home/bg1.png',
            //                         fit: BoxFit.fitHeight,
            //                       ),
            //                     ),
            //                     Container(
            //                       padding: EdgeInsets.only(
            //                           left: 12, right: 88, top: 60, bottom: 50),
            //                       child: Row(
            //                         children: [
            //                           IconButton(
            //                             icon: const Icon(
            //                               Icons.arrow_back,
            //                               color: Colors.white,
            //                             ),
            //                             onPressed: () {
            //                               Navigator.pop(context);
            //                             },
            //                           ),
            //                           AdaptiveText(
            //                             text: 'Back',
            //                             minFontSize: 14,
            //                             style: const TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.w500,
            //                               color: Constants.white,
            //                             ),
            //                           ),
            //                           const Spacer(),
            //                         ],
            //                       ),
            //                     ),
            //                     Align(
            //                       alignment: Alignment.center,
            //                       child: AdaptiveText(
            //                         text: 'Multiple Photos can be added',
            //                         minFontSize: 14,
            //                         style: const TextStyle(
            //                           fontSize: 36,
            //                           fontWeight: FontWeight.w500,
            //                           color: Constants.white,
            //                         ),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               if (!isDesktop()) gymCountSection(width),
            //               const MassMonsterSection(),
            //               const ChooseMembership(),
            //               const TrainLive(),
            //               const FunSession(),
            //               const ImageUploadedByUser(),
            //               SimilarGymsNearby(),
            //               const BottomBar(),
            //             ],
            //           ),
            ),
      ),
    );
    // return BlocProvider(
    //     lazy: false,
    //     create: (context) =>
    //         GymDetailsBloc()..add(FetchGymDetailsEvent(uid: '')),
    //     child: BlocConsumer<GymDetailsBloc, GymDetailsState>(
    //       builder: (context, state) {
    //         // if (state is FetchMembershipPlanState) {
    //         //   MembershipPlan membershipData = state.membershipPlan;
    //         // }
    //         if (state is FetchGymDetailsState) {
    //           GymDetailsModel data = state.gymDetails;
    //           return Scaffold(
    //             backgroundColor: Constants.black,
    //             resizeToAvoidBottomInset: true,
    //             body: SingleChildScrollView(
    //                 physics: BouncingScrollPhysics(),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.max,
    //                   children: [
    //                     Stack(
    //                       children: [
    //                         Container(
    //                           constraints: const BoxConstraints(
    //                               minHeight: 400, maxHeight: 488),
    //                           child: CarouselSlider(
    //                             options: CarouselOptions(
    //                               autoPlay: true,
    //                               height: 488,
    //                               viewportFraction: 1,
    //                               enlargeCenterPage: true,
    //                               enlargeStrategy:
    //                                   CenterPageEnlargeStrategy.height,
    //                             ),
    //                             items: data.gallery != null &&
    //                                     data.gallery!.isNotEmpty
    //                                 ? data.gallery!.map((gym) {
    //                                     return Container(
    //                                       constraints: const BoxConstraints(
    //                                           minHeight: 400, maxHeight: 488),
    //                                       decoration: BoxDecoration(
    //                                         image: DecorationImage(
    //                                           image: NetworkImage(
    //                                             gym.images!,
    //                                           ),
    //                                           fit: BoxFit.cover,
    //                                         ),
    //                                       ),
    //                                     );
    //                                   }).toList()
    //                                 : [
    //                                     Container(
    //                                       constraints: const BoxConstraints(
    //                                           minHeight: 400, maxHeight: 488),
    //                                       decoration: BoxDecoration(
    //                                         image: DecorationImage(
    //                                           image: AssetImage(
    //                                             'assets/membership/banner.png',
    //                                           ),
    //                                           fit: BoxFit.cover,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     Container(
    //                                       constraints: const BoxConstraints(
    //                                           minHeight: 400, maxHeight: 488),
    //                                       decoration: BoxDecoration(
    //                                         image: DecorationImage(
    //                                           image: AssetImage(
    //                                             'assets/membership/banner.png',
    //                                           ),
    //                                           fit: BoxFit.cover,
    //                                         ),
    //                                       ),
    //                                     )
    //                                   ],
    //                           ),
    //                         ),
    //                         Container(
    //                           constraints: const BoxConstraints(
    //                               minHeight: 400, maxHeight: 488),
    //                           decoration: BoxDecoration(
    //                             gradient: LinearGradient(
    //                               begin: FractionalOffset.topCenter,
    //                               end: FractionalOffset.center,
    //                               colors: [
    //                                 Color(0xff000000),
    //                                 Color(0xff000000).withOpacity(0.3),
    //                               ],
    //                               stops: [0.0, 1.0],
    //                             ),
    //                           ),
    //                         ),
    //                         Container(
    //                           constraints: const BoxConstraints(
    //                               minHeight: 400, maxHeight: 488),
    //                           child: Stack(
    //                             // alignment: Alignment.center,
    //                             children: [
    //                               Container(
    //                                 padding: EdgeInsets.only(
    //                                     left: 12,
    //                                     right: 88,
    //                                     top: 60,
    //                                     bottom: 50),
    //                                 child: Row(
    //                                   children: [
    //                                     IconButton(
    //                                       icon: const Icon(
    //                                         Icons.arrow_back,
    //                                         color: Colors.white,
    //                                       ),
    //                                       onPressed: () {
    //                                         Navigator.pop(context);
    //                                       },
    //                                     ),
    //                                     AdaptiveText(
    //                                       text: 'Back',
    //                                       minFontSize: 14,
    //                                       style: GoogleFonts.montserrat(
    //                                         fontSize: 18,
    //                                         fontWeight: FontWeight.w500,
    //                                         color: Constants.white,
    //                                       ),
    //                                     ),
    //                                     const Spacer(),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     MembershipAboutGym(gymDetails: data),
    //                     ChoosePlan(gymDetails: data),
    //                     const WorksAndOffers(),
    //                     const BuyOrbookScreen(),
    //                     const TrainLive(),
    //                     const FunSession(),
    //                     const BottomBar(
    //                       color: Color(0xff292929),
    //                     ),
    //                   ],
    //                 )
    //                 // Column(
    //                 //             mainAxisSize: MainAxisSize.max,
    //                 //             children: [
    //                 //               Container(
    //                 //                 constraints:
    //                 //                     const BoxConstraints(minHeight: 400, maxHeight: 700),
    //                 //                 child: Stack(
    //                 //                   children: [
    //                 //                     Align(
    //                 //                       alignment: Alignment.bottomRight,
    //                 //                       child: Image.asset(
    //                 //                         'assets/home/bg1.png',
    //                 //                         fit: BoxFit.fitHeight,
    //                 //                       ),
    //                 //                     ),
    //                 //                     Container(
    //                 //                       padding: EdgeInsets.only(
    //                 //                           left: 12, right: 88, top: 60, bottom: 50),
    //                 //                       child: Row(
    //                 //                         children: [
    //                 //                           IconButton(
    //                 //                             icon: const Icon(
    //                 //                               Icons.arrow_back,
    //                 //                               color: Colors.white,
    //                 //                             ),
    //                 //                             onPressed: () {
    //                 //                               Navigator.pop(context);
    //                 //                             },
    //                 //                           ),
    //                 //                           AdaptiveText(
    //                 //                             text: 'Back',
    //                 //                             minFontSize: 14,
    //                 //                             style: const TextStyle(
    //                 //                               fontSize: 18,
    //                 //                               fontWeight: FontWeight.w500,
    //                 //                               color: Constants.white,
    //                 //                             ),
    //                 //                           ),
    //                 //                           const Spacer(),
    //                 //                         ],
    //                 //                       ),
    //                 //                     ),
    //                 //                     Align(
    //                 //                       alignment: Alignment.center,
    //                 //                       child: AdaptiveText(
    //                 //                         text: 'Multiple Photos can be added',
    //                 //                         minFontSize: 14,
    //                 //                         style: const TextStyle(
    //                 //                           fontSize: 36,
    //                 //                           fontWeight: FontWeight.w500,
    //                 //                           color: Constants.white,
    //                 //                         ),
    //                 //                       ),
    //                 //                     )
    //                 //                   ],
    //                 //                 ),
    //                 //               ),
    //                 //               if (!isDesktop()) gymCountSection(width),
    //                 //               const MassMonsterSection(),
    //                 //               const ChooseMembership(),
    //                 //               const TrainLive(),
    //                 //               const FunSession(),
    //                 //               const ImageUploadedByUser(),
    //                 //               SimilarGymsNearby(),
    //                 //               const BottomBar(),
    //                 //             ],
    //                 //           ),
    //                 ),
    //           );
    //         }

    //         return CustomLoader();
    //       },
    //       listener: (context, state) {
    //         if (state is GymDetailsInitial) {}
    //       },
    //     ));
  }

  bool isDesktop() => Responsive.isDesktop(context);
}
