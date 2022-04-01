import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:salessimplify/controller/color.dart';
import 'package:url_launcher/url_launcher.dart';

class EmptyListHelper {
  static const num upcomingList = 0;
  static const num overDueList = 1;
  static const num completedList = 2;
  static const num activeLeadsList = 3;
  static const num junkLeadsList = 4;
  static const num emptyList = 5;
  static const num contactList = 6;
  static const num organizationLIst = 7;
  static const num dealsList = 8;
  static const num dealsEmptyList = 9;
  static const num timeLineList = 10;
  static const num helpFeedback = 11;
  static const num refersAndEarn = 12;
  static const num search = 13;
  static const num generalTab = 14;
  static const num activitiesTab = 15;
  static const num notesTab = 16;

  Widget getEmptyList(num listType, BuildContext context) {
    EmptyList data = _getLabel(listType);
    return Container(
      color: white,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: data.color != null
                      ? data.color
                      : blueColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(900),
                ),
                child: Lottie.asset(
                  data.iconPath!,
                  repeat: data.repeat != null ? data.repeat : true,
                  reverse: true,
                  animate: true,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    data.label!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 18, color: grey, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  data.deal == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tap on  ',
                              style: new TextStyle(color: Colors.grey.shade400),
                            ),
                            Icon(Boxicons.bx_slider_alt,
                                size: 18, color: lightBlue),
                            Text(
                              '  icon and select a deal.',
                              style: new TextStyle(color: Colors.grey.shade400),
                            ),
                          ],
                        )
                      : RichText(
                          text: new TextSpan(
                            children: [
                              new TextSpan(
                                text: data.subtitle,
                                style:
                                    new TextStyle(color: Colors.grey.shade400),
                              ),
                              data.url != null
                                  ? new TextSpan(
                                      text: ' Click here',
                                      style: new TextStyle(color: deepblue),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          launch(data.url!);
                                        },
                                    )
                                  : TextSpan(),
                            ],
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  EmptyList _getLabel(num listType) {
    switch (listType) {
      case upcomingList:
        return EmptyList(
          label: 'No Active Activity Found!',
          iconPath: 'assets/icons/empty_folder.json',
        );
        break;
      case overDueList:
        return EmptyList(
          label: 'No Due Activity Found!',
          iconPath: 'assets/icons/empty_folder.json',
        );
        break;
      case completedList:
        return EmptyList(
          label: 'No Completed Activity Found!',
          iconPath: 'assets/icons/empty_folder.json',
        );
        break;
      case activeLeadsList:
        return EmptyList(
          label: 'No Active Leads Found!',
          iconPath: 'assets/icons/empty_list.json',
        );
        break;
      case junkLeadsList:
        return EmptyList(
          label: 'No Junk Leads Found!',
          iconPath: 'assets/icons/empty_list.json',
        );
        break;
      case emptyList:
        return EmptyList(
          label: 'Nothing Found!',
          iconPath: 'assets/icons/list.json',
        );
        break;
      case contactList:
        return EmptyList(
          label: 'No Contacts Found!',
          iconPath: 'assets/icons/list.json',
        );
        break;
      case organizationLIst:
        return EmptyList(
          label: 'No Companies Found!',
          iconPath: 'assets/icons/list.json',
        );
        break;
      case dealsList:
        return EmptyList(
          label: 'Select any Deal',
          iconPath: 'assets/icons/list.json',
          subtitle: 'Select Deal.',
          deal: true,
        );
        break;
      case dealsEmptyList:
        return EmptyList(
          label: 'No Deals Found!',
          iconPath: 'assets/icons/empty_list.json',
          // subtitle: 'Select from Dropdown',
        );
        break;
      case timeLineList:
        return EmptyList(
          label: 'No Timeline Found!',
          iconPath: 'assets/icons/list.json',
        );
        break;
      case helpFeedback:
        return EmptyList(
          label: 'Users feedback',
          iconPath: 'assets/icons/bot.json',
          subtitle: 'support@salessimplify.com',
          url: 'mailto:support@salessimplify.com',
        );
        break;
      case refersAndEarn:
        return EmptyList(
          label: 'Refers & Earn',
          iconPath: 'assets/icons/gift.json',
          subtitle: 'Invite friends and earn rewards.',
        );
        break;
      case search:
        return EmptyList(
          label: 'Search anything here...',
          iconPath: 'assets/icons/search.json',
        );
        break;
      case generalTab:
        return EmptyList(
          label: 'No details found.',
          iconPath: 'assets/icons/list.json',
        );
        break;
      case activitiesTab:
        return EmptyList(
          repeat: false,
          label: 'No activities found.',
          iconPath: 'assets/icons/list.json',
        );
        break;
      case notesTab:
        return EmptyList(
          label: 'Empty Notes.',
          subtitle: 'Create a note first.',
          iconPath: 'assets/icons/list.json',
        );
        break;
      default:
        return EmptyList(
          label: 'Empty',
          iconPath: 'assets/icons/empty.json',
          subtitle: 'Nothing found!',
        );
    }
  }
}

class EmptyList {
  String? label;
  String? iconPath;
  String? subtitle;
  String? url;
  Color? color;
  bool? deal;
  bool? repeat;

  EmptyList({
    this.label,
    this.iconPath,
    this.subtitle,
    this.url,
    this.color,
    this.deal,
    this.repeat,
  });
}

EmptyListHelper emptyListHelper = EmptyListHelper();
