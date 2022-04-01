import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';

class ActivitySymbolWidget extends StatelessWidget {
  final String activityName;
  final Color? color;
  const ActivitySymbolWidget({
    Key? key,
    this.color,
    required this.activityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      activityName == 'Icons.people'
          ? Icons.people
          : activityName == 'Icons.watch_later'
              ? Icons.watch_later
              : activityName == 'Icons.call'
                  ? Icons.call
                  : activityName == 'Icons.flag'
                      ? Icons.flag
                      : activityName == 'Icons.calendar_today'
                          ? Icons.calendar_today
                          : activityName == 'Icons.arrow_circle_down'
                              ? Icons.arrow_circle_down
                              : activityName == 'Icons.folder'
                                  ? Icons.folder
                                  : activityName == 'Icons.smartphone'
                                      ? Icons.smartphone
                                      : activityName == 'Icons.local_see'
                                          ? Icons.local_see
                                          : activityName == 'Icons.content_cut'
                                              ? Icons.content_cut
                                              : activityName ==
                                                      'Icons.handyman_outlined'
                                                  ? Icons.handyman_outlined
                                                  : activityName == 'Icons.chat'
                                                      ? Icons.chat
                                                      : activityName ==
                                                              'Icons.shopping_basket'
                                                          ? Icons
                                                              .shopping_basket
                                                          : activityName ==
                                                                  'Icons.bookmark_outlined'
                                                              ? Icons
                                                                  .bookmark_outlined
                                                              : activityName ==
                                                                      'Icons.work'
                                                                  ? Icons.work
                                                                  : activityName ==
                                                                          'Icons.pest_control_outlined'
                                                                      ? Icons
                                                                          .pest_control_outlined
                                                                      : activityName ==
                                                                              'Icons.shopping_cart'
                                                                          ? Icons
                                                                              .shopping_cart
                                                                          : activityName == 'Icons.comment'
                                                                              ? Icons.comment
                                                                              : activityName == 'Icons.chat'
                                                                                  ? Icons.chat
                                                                                  : activityName == 'Icons.sports_esports_outlined'
                                                                                      ? Icons.sports_esports_outlined
                                                                                      : activityName == 'Icons.mail'
                                                                                          ? Icons.mail
                                                                                          : activityName == 'Icons.headphones'
                                                                                              ? Icons.headphones
                                                                                              : activityName == 'Icons.settings_outlined'
                                                                                                  ? Icons.settings_outlined
                                                                                                  : activityName == 'Icons.date_range'
                                                                                                      ? Icons.date_range
                                                                                                      : activityName == 'Icons.check_box'
                                                                                                          ? Icons.check_box
                                                                                                          : Icons.circle,
      color: color != null ? color : white,
    );
  }
}
