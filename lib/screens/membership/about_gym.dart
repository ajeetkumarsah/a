// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/new/responsive.dart';
import 'package:wtf_web/screens/widgets/adaptiveText.dart';
import 'package:wtf_web/utils/const.dart';

class MembershipAboutGym extends StatelessWidget {
  final GymDetailsModel gymDetails;
  const MembershipAboutGym({Key? key, required this.gymDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Constants.getPadding(context);
    bool isDesktop() => Responsive.isDesktop(context);
    bool isMobile() => Responsive.isMobile(context);
    // GymDetailsModel data=gymDetails;
    // print('Rating================>' + gymDetails.rating.toString());
    return BootstrapContainer(
      fluid: true,
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.fromLTRB(
          isDesktop() ? 56 : 12.0, isDesktop() ? 62 : 12.0, 0, 0),
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdaptiveText(
                text: gymDetails.gymName ?? '',
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize: isDesktop() ? 48 : 14,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
              Container(
                // height: 81,
                decoration: BoxDecoration(color: Constants.primaryColor),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingBar(
                      itemSize: 25,
                      initialRating: gymDetails.rating != null
                          ? gymDetails.rating!.toDouble()
                          : 1.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: true,
                      ratingWidget: RatingWidget(
                        full:
                            Icon(Icons.star, color: Constants.white, size: 18),
                        //  Image.asset('assets/heart.png'),
                        half: Icon(Icons.star_half,
                            color: Constants.white, size: 18),
                        empty: Icon(Icons.star_border_outlined,
                            color: Constants.white, size: 18),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    AdaptiveText(
                      text:
                          "${gymDetails.totalRatings != null ? gymDetails.totalRatings : 150} Ratings",
                      minFontSize: 14,
                      style: GoogleFonts.openSans(
                        fontSize: isDesktop() ? 18 : 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/gym/map_pin.svg'),
              SizedBox(width: 10),
              AdaptiveText(
                text: gymDetails.address1! + ', ' + gymDetails.address2!,
                minFontSize: 14,
                style: GoogleFonts.openSans(
                  fontSize: isDesktop() ? 24 : 12,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // trailing:
        ),
      ],
    );
  }
}
