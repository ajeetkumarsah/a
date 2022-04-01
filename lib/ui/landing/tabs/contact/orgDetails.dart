import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/popupdetails.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/time_ago_converter.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import 'dart:ui' as color;

import 'widgets/popup_details_loader.dart';

class OrgDetails extends StatefulWidget {
  static String ROUTE_ORG_DETAILS = "route/OrgDetails";
  const OrgDetails({Key? key}) : super(key: key);

  @override
  _OrgDetailsState createState() => _OrgDetailsState();
}

class _OrgDetailsState extends State<OrgDetails> {
  bool isUpdated = false;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  confirmDelete(Map<String, dynamic> params) {
    var baseDialog = BaseAlertDialog(
        title: "Are you sure?",
        content: "Do you want to delete this company?",
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

  var f = DateFormat('d MMM,yyyy, hh:mm a');
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
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
          future: Repository.getInstance().getPeopleDetails(args["id"], true),
          builder: (context, snapshot) {
            List<PopupDetailsList>? popupDetails;
            if (snapshot.connectionState == ConnectionState.done) {
              popupDetails = snapshot.data as List<PopupDetailsList>;
            }
            return snapshot.connectionState == ConnectionState.done
                ? popupDetails!.isEmpty
                    ? emptyListHelper.getEmptyList(
                        EmptyListHelper.contactList, context)
                    : ListView.builder(
                        itemCount: popupDetails.length,
                        itemBuilder: (BuildContext context, int i) {
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
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: popupDetails![i].fieldName ==
                                              "Email"
                                          ? Icon(
                                              Icons.email_outlined,
                                              color: blueColor,
                                              size: 22,
                                            )
                                          : popupDetails[i].fieldName == "Phone"
                                              ? Icon(
                                                  Icons.call,
                                                  color: blueColor,
                                                  size: 22,
                                                )
                                              : popupDetails[i].fieldName ==
                                                      "Organization"
                                                  ? Icon(
                                                      Boxicons.bx_building,
                                                      color: blueColor,
                                                      size: 22,
                                                    )
                                                  : popupDetails[i].fieldName ==
                                                          "Tag"
                                                      ? Icon(
                                                          Icons
                                                              .local_offer_outlined,
                                                          color: blueColor,
                                                          size: 22,
                                                        )
                                                      : popupDetails[i]
                                                                  .fieldName ==
                                                              "Website"
                                                          ? Icon(
                                                              Boxicons.bx_world,
                                                              color: blueColor,
                                                              size: 22,
                                                            )
                                                          : popupDetails[i]
                                                                      .fieldName ==
                                                                  "Name"
                                                              ? Icon(
                                                                  Boxicons
                                                                      .bxs_user,
                                                                  color:
                                                                      blueColor,
                                                                  size: 22,
                                                                )
                                                              : popupDetails[i]
                                                                          .fieldName ==
                                                                      "Country"
                                                                  ? Icon(
                                                                      Boxicons
                                                                          .bxs_flag_alt,
                                                                      color:
                                                                          blueColor,
                                                                      size: 22,
                                                                    )
                                                                  : popupDetails[i]
                                                                              .fieldName ==
                                                                          "City"
                                                                      ? Icon(
                                                                          Boxicons
                                                                              .bxs_city,
                                                                          color:
                                                                              blueColor,
                                                                          size:
                                                                              22,
                                                                        )
                                                                      : popupDetails[i].fieldName ==
                                                                              "Description"
                                                                          ? Icon(
                                                                              Boxicons.bx_message_rounded,
                                                                              color: blueColor,
                                                                              size: 22,
                                                                            )
                                                                          : popupDetails[i].fieldName == "Owner"
                                                                              ? Icon(
                                                                                  Icons.person_outline,
                                                                                  color: blueColor,
                                                                                  size: 22,
                                                                                )
                                                                              : Text(
                                                                                  (popupDetails[i].apiKeyName.isEmpty ? "NA" : popupDetails[i].apiKeyName.toString().characters.first.toUpperCase()),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: blueColor,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                    ),
                                  ),
                                  title: Text(popupDetails[i].fieldName),
                                  subtitle: popupDetails[i].fieldInputType ==
                                          FieldInputType.TAG_MULTI_SELECT
                                              .getType()
                                      ? popupDetails[i].value != ''
                                          ? SizedBox(
                                              height: 30,
                                              child: ListView.builder(
                                                  itemCount: popupDetails[i]
                                                      .valueWithColor
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10,
                                                            right: 8.0),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 2.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          color: getValue(
                                                              popupDetails?[i]
                                                                      .valueWithColor ??
                                                                  greenColor,
                                                              index),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          popupDetails![i]
                                                                  .valueWithColor[
                                                              index]["label"],
                                                          style: TextStyle(
                                                              color: white),
                                                        )));
                                                  }),
                                            )
                                          : SizedBox()
                                      : popupDetails[i].fieldInputType ==
                                              FieldInputType.DATE_TIME.getType()
                                          ? popupDetails[i].fieldGroup ==
                                                  FieldGroupType.CUSTOM
                                                      .getType()
                                              ? popupDetails[i].value != ''
                                                  ? Text(
                                                      "${popupDetails[i].value != null ? f.format(DateTime.parse(popupDetails[i].value.toString()).toLocal()) : "NA"} ")
                                                  : SizedBox()
                                              : popupDetails[i].value != ''
                                                  ? Text(popupDetails[i].value !=
                                                          null
                                                      ? popupDetails[i].value ==
                                                              ""
                                                          ? ''
                                                          : timeAgoConverter
                                                              .timeAgoString(
                                                                  popupDetails[i]
                                                                      .value)
                                                      : '')
                                                  : SizedBox()
                                          : popupDetails[i].fieldInputType ==
                                                  FieldInputType.DATE.getType()
                                              ? popupDetails[i].value != ''
                                                  ? Text(
                                                      "${popupDetails[i].value != null ? f.format(DateTime.parse(popupDetails[i].value.toString()).toLocal()) : "NA"} ")
                                                  : SizedBox()
                                              : popupDetails[i].fieldInputType ==
                                                          FieldInputType
                                                              .DATE_TIME_RANGE
                                                              .getType() ||
                                                      popupDetails[i]
                                                              .fieldInputType ==
                                                          FieldInputType
                                                              .DATE_RANGE
                                                              .getType()
                                                  ? popupDetails[i].value != null
                                                      ? popupDetails[i].value != null
                                                          ? Text("${popupDetails[i].value.isNotEmpty ? f.format(DateTime.parse(popupDetails[i].value[0].toString()).toLocal()) + '  -  ' + f.format(DateTime.parse(popupDetails[i].value[1].toString()).toLocal()) : ""} ")
                                                          : SizedBox()
                                                      : SizedBox()
                                                  : popupDetails[i].fieldInputType == FieldInputType.MULTI_EMAIL_INPUT.getType() || popupDetails[i].fieldInputType == FieldInputType.MULTI_PHONE_INPUT.getType()
                                                      ? Text(popupDetails[i].value != null
                                                          ? popupDetails[i].value == ""
                                                              ? ''
                                                              : popupDetails[i].value.join(",")
                                                          : '')
                                                      : popupDetails[i].fieldInputType == FieldInputType.SELECT.getType()
                                                          ? Text(popupDetails[i].value != null
                                                              ? popupDetails[i].value == ""
                                                                  ? ''
                                                                  : popupDetails[i].value.toString()
                                                              : '')
                                                          : popupDetails[i].fieldInputType == FieldInputType.RADIO.getType()
                                                              ? Text(popupDetails[i].value != null
                                                                  ? popupDetails[i].value == ""
                                                                      ? ''
                                                                      : popupDetails[i].value.toString()
                                                                  : '')
                                                              : popupDetails[i].fieldInputType == FieldInputType.TOGGLE_BUTTON.getType()
                                                                  ? Text(popupDetails[i].value != null
                                                                      ? (popupDetails[i].value is bool && popupDetails[i].value == true)
                                                                          ? 'Yes'
                                                                          : (popupDetails[i].value is bool && popupDetails[i].value == false)
                                                                              ? 'No'
                                                                              : '${popupDetails[i].value}'
                                                                      : 'null')
                                                                  : popupDetails[i].fieldInputType == FieldInputType.OWNER_SELECT.getType()
                                                                      ? Text((popupDetails[i].value is String) ? popupDetails[i].value : popupDetails[i].value.label)
                                                                      : Text(popupDetails[i].value.toString()),
                                  trailing: popupDetails[i].fieldInputType ==
                                          FieldInputType.DATE_TIME.getType()
                                      ? SizedBox()
                                      : popupDetails[i].fieldInputType ==
                                              FieldInputType.TIMEZONE_SELECT
                                                  .getType()
                                          ? SizedBox()
                                          : popupDetails[i].fieldInputType ==
                                                      FieldInputType
                                                          .DATE_TIME_RANGE
                                                          .getType() ||
                                                  popupDetails[i].fieldInputType ==
                                                      FieldInputType.DATE_RANGE
                                                          .getType()
                                              ? EditButton(
                                                  onTap: () => CustomBottomSheet(
                                                          handler: refresh,
                                                          id: args["id"])
                                                      .peopleDateRangeBottomDialog(
                                                          context,
                                                          popupDetails![i],
                                                          PageNavigatedFrom
                                                              .COMPANY
                                                              .getType()),
                                                )
                                              : popupDetails[i].fieldInputType ==
                                                      FieldInputType.CHECKBOX
                                                          .getType()
                                                  ? EditButton(
                                                      onTap: () => CustomBottomSheet(
                                                              handler: refresh,
                                                              id: args["id"])
                                                          .peopleCheckBoxBottomDialog(
                                                              context,
                                                              popupDetails![i],
                                                              PageNavigatedFrom
                                                                  .COMPANY
                                                                  .getType()),
                                                    )
                                                  : popupDetails[i].fieldInputType ==
                                                          FieldInputType.RADIO
                                                              .getType()
                                                      ? EditButton(
                                                          onTap: () => CustomBottomSheet(
                                                                  handler:
                                                                      refresh,
                                                                  id: args[
                                                                      "id"])
                                                              .peopleRadioBottomDialog(
                                                                  context,
                                                                  popupDetails![
                                                                      i],
                                                                  PageNavigatedFrom
                                                                      .COMPANY
                                                                      .getType()),
                                                        )
                                                      : popupDetails[i].fieldInputType ==
                                                              FieldInputType.DATE.getType()
                                                          ? EditButton(
                                                              onTap: () => CustomBottomSheet(
                                                                      handler:
                                                                          refresh,
                                                                      id: args[
                                                                          "id"])
                                                                  .peopleDateBottomDialog(
                                                                      context,
                                                                      popupDetails![
                                                                          i],
                                                                      selectedDate
                                                                          .toString(),
                                                                      () => _selectDate(
                                                                          context),
                                                                      PageNavigatedFrom
                                                                          .COMPANY
                                                                          .getType()),
                                                            )
                                                          : popupDetails[i].fieldInputType == FieldInputType.TOGGLE_BUTTON.getType()
                                                              ? EditButton(
                                                                  onTap: () => CustomBottomSheet(
                                                                          handler:
                                                                              refresh,
                                                                          id: args[
                                                                              "id"])
                                                                      .peopleToggleButtonBottomDialog(
                                                                          context,
                                                                          popupDetails![
                                                                              i],
                                                                          PageNavigatedFrom
                                                                              .COMPANY
                                                                              .getType()),
                                                                )
                                                              : popupDetails[i].fieldInputType == FieldInputType.SELECT.getType()
                                                                  ? EditButton(onTap: () => CustomBottomSheet(handler: refresh, id: args["id"]).peopleDropdownBottomDialog(context, popupDetails![i], PageNavigatedFrom.COMPANY.getType()))
                                                                  : popupDetails[i].fieldInputType == FieldInputType.OWNER_SELECT.getType()
                                                                      ? SizedBox()
                                                                      : popupDetails[i].isEditable
                                                                          ? EditButton(
                                                                              onTap: () => CustomBottomSheet(handler: refresh, id: args["id"]).companyBottomDialog(context, popupDetails![i]),
                                                                            )
                                                                          : SizedBox(),
                                ),
                                Divider()
                              ],
                            ),
                          );
                        })
                : PopupDetailsLoader();
          },
        ),
      ),
    );
  }

  getValue(dynamic value, int index) {
    if (value is List &&
        (value).length > 0 &&
        value[index]["colorCode"] != null) {
      return HexColor.fromHex(value[index]["colorCode"]);
    } else {
      return Colors.grey;
    }
  }

  deleteRecord(BuildContext context, Map<String, dynamic> params) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deleteCompany(params);
    pr.hide().then((isHidden) {
      print(isHidden);
    });

    if (isSuccess is bool && isSuccess) {
      toastHelper.toastWithTitleAndColor("Deleted Successfully!", greenColor);

      Navigator.pop(context, true);
    } else {
      toastHelper.toastWithTitleAndColor("Failed to delete!", redColor);
    }
  }

  refresh() {
    setState(() {
      isUpdated = true;
    });
  }
}
