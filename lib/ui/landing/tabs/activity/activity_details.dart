import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/activity_details_model.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/contact/widgets/popup_details_loader.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/time_ago_converter.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import 'package:provider/provider.dart';

class ActivityDetailsPage extends StatefulWidget {
  static String routeName = "ActivityDetailsPage";
  const ActivityDetailsPage({Key? key}) : super(key: key);

  @override
  _ActivityDetailsPageState createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  var f = DateFormat('d MMM,yyyy, hh:mm a');
  bool isUpdated = false;
  confirmDelete(Map<String, dynamic> params) {
    var baseDialog = BaseAlertDialog(
        title: "Are you sure?",
        content: "Do you want to delete this activity?",
        yesOnPressed: () {
          Navigator.pop(context);
          deleteRecord(context, params);
        },
        noOnPressed: () {
          Navigator.pop(context);
        },
        yes: "Delete",
        no: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        title: args["name"]!,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, isUpdated),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Map<String, dynamic> params = {};
                params["ids"] = [args["id"]];
                confirmDelete(params);
              },
              icon: Icon(
                Icons.delete,
                color: redColor,
              ))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, isUpdated);
          return isUpdated;
        },
        child: FutureBuilder(
          future:
              Repository.getInstance().getActivityDetails(args["id"], false),
          builder: (context, snapshot) {
            List<ActivityDetailsModel>? activityDetails;
            if (snapshot.connectionState == ConnectionState.done) {
              activityDetails = snapshot.data as List<ActivityDetailsModel>;
            }
            return snapshot.connectionState == ConnectionState.done
                ? activityDetails!.isEmpty
                    ? emptyListHelper.getEmptyList(
                        EmptyListHelper.contactList, context)
                    : ListView.builder(
                        itemCount: activityDetails.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: activityDetails![i].fieldInputType ==
                                    FieldInputType.INPUT.getType()
                                ? rowBuilder(activityDetails[i], args, false)
                                : activityDetails[i].fieldInputType ==
                                        FieldInputType.DATE_TIME.getType()
                                    ? rowBuilder(
                                        activityDetails[i], args, false)
                                    : activityDetails[i].fieldInputType ==
                                            FieldInputType.OWNER_SELECT
                                                .getType()
                                        ? rowBuilder(
                                            activityDetails[i], args, true)
                                        : activityDetails[i].fieldInputType ==
                                                FieldInputType.LEAD_SELECT
                                                    .getType()
                                            ? rowBuilder(
                                                activityDetails[i], args, false)
                                            : activityDetails[i].fieldInputType ==
                                                    FieldInputType.DEAL_SELECT
                                                        .getType()
                                                ? rowBuilder(activityDetails[i],
                                                    args, false)
                                                : activityDetails[i].fieldInputType ==
                                                        FieldInputType.COMPANY_SELECT
                                                            .getType()
                                                    ? rowBuilder(
                                                        activityDetails[i],
                                                        args,
                                                        false)
                                                    : activityDetails[i].fieldInputType ==
                                                            FieldInputType.PEOPLE_SELECT
                                                                .getType()
                                                        ? rowBuilder(
                                                            activityDetails[i],
                                                            args,
                                                            false)
                                                        : activityDetails[i].fieldInputType == FieldInputType.NUMBER.getType() ||
                                                                activityDetails[i].fieldInputType ==
                                                                    FieldInputType
                                                                        .OWNER_SELECT
                                                                        .getType() ||
                                                                activityDetails[i].fieldInputType == FieldInputType.MULTI_EMAIL_INPUT.getType() ||
                                                                activityDetails[i].fieldInputType == FieldInputType.ACTIVITY_TYPE_SELECT.getType() ||
                                                                activityDetails[i].fieldInputType == FieldInputType.ACTIVITY_LOST_REASONS_SELECT.getType()
                                                            ? rowBuilder(activityDetails[i], args, false)
                                                            : SizedBox(),
                          );
                        })
                : PopupDetailsLoader();
          },
        ),
      ),
    );
  }

  Widget rowBuilder(
      ActivityDetailsModel? activityDetails, final args, bool owner) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                (activityDetails!.apiKeyName.isEmpty
                    ? "NA"
                    : activityDetails.apiKeyName
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
          title: Text(activityDetails.fieldName),
          subtitle: activityDetails.fieldInputType ==
                  FieldInputType.DATE_TIME.getType()
              ? activityDetails.fieldName == 'Completed Time'
                  ? activityDetails.value == ''
                      ? Text('')
                      : Text(
                          timeAgoConverter.timeAgoString(activityDetails.value))
                  : activityDetails.fieldName == 'Created At' ||
                          activityDetails.fieldName == 'Last Updated'
                      ? Text(
                          timeAgoConverter.timeAgoString(activityDetails.value))
                      : Text("${activityDetails.value != null ? f.format(
                          DateTime.parse(activityDetails.value).toLocal(),
                        ) : "NA"} ")

              // ? Text(activityDetails.value)
              : activityDetails.fieldInputType ==
                      FieldInputType.LEAD_SELECT.getType()
                  ? Text(activityDetails.value != null
                      ? activityDetails.value.isNotEmpty
                          ? "${activityDetails.value['name'] != null ? activityDetails.value['name'] : 'NA'} "
                          : ''
                      : '')
                  : activityDetails.fieldInputType ==
                          FieldInputType.DEAL_SELECT.getType()
                      ? Text(activityDetails.value != null
                          ? activityDetails.value.isNotEmpty
                              ? "${activityDetails.value['name'] != null ? activityDetails.value['name'] : 'NA'} "
                              : ""
                          : '')
                      : activityDetails.fieldInputType ==
                              FieldInputType.PEOPLE_SELECT.getType()
                          ? Text(activityDetails.value != null
                              ? activityDetails.value.isNotEmpty
                                  ? "${activityDetails.value['name'] != null ? activityDetails.value['name'] : 'NA'} "
                                  : ''
                              : "")
                          : activityDetails.fieldInputType ==
                                  FieldInputType.COMPANY_SELECT.getType()
                              ? Text(activityDetails.value != null
                                  ? activityDetails.value.isNotEmpty
                                      ? "${activityDetails.value['name'] != null ? activityDetails.value['name'] : 'NA'} "
                                      : ""
                                  : '')
                              : activityDetails.fieldInputType ==
                                      FieldInputType.ACTIVITY_TYPE_SELECT
                                          .getType()
                                  ? Text(activityDetails.value['name'] != null
                                      ? activityDetails.value['name']
                                      : '')
                                  : activityDetails.fieldInputType ==
                                          FieldInputType.MULTI_EMAIL_INPUT
                                              .getType()
                                      ? activityDetails.value.isNotEmpty
                                          ? Container(
                                              // fit: FlexFit.tight,
                                              constraints: BoxConstraints.tight(
                                                  Size.fromHeight(40)),
                                              color: white,
                                              height: 32,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView.builder(
                                                  // shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: activityDetails
                                                      .value.length,
                                                  itemBuilder: (context, i) {
                                                    return FittedBox(
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 6.0,
                                                                vertical: 4.0),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4.0,
                                                                vertical: 4.0),
                                                        decoration: BoxDecoration(
                                                            color: activityDetails
                                                                            .value[
                                                                        i] ==
                                                                    ''
                                                                ? white
                                                                : bgColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.0)),
                                                        child: Text(
                                                            activityDetails
                                                                .value[i],
                                                            style: textHelper
                                                                .defaultText12),
                                                      ),
                                                    );
                                                  }),
                                            )
                                          : Text('')
                                      : Text(owner
                                          ? activityDetails.value['label']
                                          : activityDetails.value.toString()),
          trailing: activityDetails.fieldName == 'Last Updated'
              ? SizedBox()
              : activityDetails.fieldInputType ==
                      FieldInputType.OWNER_SELECT.getType()
                  ? SizedBox()
                  : activityDetails.fieldInputType ==
                          FieldInputType.DATE_TIME.getType()
                      ? SizedBox()
                      : EditButton(
                          onTap: () => CustomBottomSheet(
                                  handler: refresh, id: args["id"])
                              .activityBottomDialog(context, activityDetails),
                        ),
        ),
        Divider(),
      ],
    );
  }

  refresh() {
    setState(() {
      isUpdated = true;
    });
  }

  deleteRecord(BuildContext context, Map<String, dynamic> params) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deleteActivity(params);
    pr.hide().then((isHidden) {
      print(isHidden);
    });

    if (isSuccess is bool && isSuccess) {
      toastHelper.toastWithTitleAndColor("Deleted successfully!", greenColor);

      Navigator.pop(context, true);
    } else {
      toastHelper.toastWithTitleAndColor("Failed to delete!", redColor);
    }
  }
}
