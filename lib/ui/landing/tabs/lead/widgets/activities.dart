import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/short_activity_model.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/activity/activity_details.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/dotted_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';

class LinkedActivities extends StatefulWidget {
  final String idType;
  final String createTypeId;
  final String id;
  LinkedActivities(
      {Key? key,
      required this.idType,
      required this.id,
      required this.createTypeId})
      : super(key: key);

  @override
  _LinkedActivitiesState createState() => _LinkedActivitiesState();
}

class _LinkedActivitiesState extends State<LinkedActivities> {
  var f = DateFormat('d MMM,yyyy, hh:mm a');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.getInstance().getLinkedActivities(
        params: {
          widget.idType: widget.id.toString(),
          'limit': ' 10',
          'pageNo': '1',
        },
      ),
      builder: (context, snapshot) {
        List<ShortActivityModel>? activities;

        if (snapshot.connectionState == ConnectionState.done) {
          activities = snapshot.data as List<ShortActivityModel>;
        }
        return snapshot.connectionState == ConnectionState.done
            ? activities!.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: new DottedButton(
                          title: 'Add a new activity',
                          onTap: () {
                            customBottomSheet
                                .addShortActivityBottomDialog(
                                    context, widget.createTypeId, widget.id)
                                .then((value) => setState(() {}));
                          },
                        ),
                      ),
                      Expanded(
                        child: emptyListHelper.getEmptyList(
                            EmptyListHelper.activitiesTab, context),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: activities == null ? 1 : activities.length + 1,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      if (i == 0) {
                        // return the header
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: new DottedButton(
                            title: 'Add a new activity',
                            onTap: () {
                              new CustomBottomSheet(
                                      id: widget.id, handler: refresh)
                                  .addShortActivityBottomDialog(
                                      context, widget.createTypeId, widget.id)
                                  .then((value) => setState(() {}));
                            },
                          ),
                        );
                      }
                      i -= 1;
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ActivityDetailsPage.routeName,
                                    arguments: {
                                      "name": activities![i].name,
                                      "id": activities[i].id,
                                    }).then((value) => setState(() {}));
                              },
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: Text(
                                    (activities![i].name.isEmpty
                                        ? "NA"
                                        : activities[i]
                                            .name
                                            .toString()
                                            .characters
                                            .first
                                            .toUpperCase()),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: blueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                activities[i].name,
                                overflow: TextOverflow.ellipsis,
                                style: textHelper.title16,
                              ),
                              subtitle: Text(
                                "${activities[i].scheduleAt.toString() != null ? f.format(
                                    DateTime.parse(
                                            activities[i].scheduleAt.toString())
                                        .toLocal(),
                                  ) : "NA"} ",
                                overflow: TextOverflow.ellipsis,
                                style: textHelper.subtitle13,
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    },
                  )
            : TabLoader();
      },
    );
  }

  refresh() {
    setState(() {});
  }
}
