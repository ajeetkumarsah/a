import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/popupdetails.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_list_shimmer.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/time_ago_converter.dart';
import 'dart:ui' as color;

class GeneralWidget extends StatefulWidget {
  GeneralWidget({Key? key, required this.args, required this.isUpdated})
      : super(key: key);
  final Map<dynamic, dynamic> args;
  bool isUpdated;

  @override
  _GeneralWidgetState createState() => _GeneralWidgetState();
}

class _GeneralWidgetState extends State<GeneralWidget> {
  var f = DateFormat('d MMM,yyyy, hh:mm a');

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Repository.getInstance().getPeopleDetails(widget.args["id"], false),
      builder: (context, snapshot) {
        List<PopupDetailsList>? popupDetails;
        if (snapshot.connectionState == ConnectionState.done) {
          popupDetails = snapshot.data as List<PopupDetailsList>;
        }

        return snapshot.connectionState == ConnectionState.done
            ? popupDetails!.isEmpty
                ? emptyListHelper.getEmptyList(
                    EmptyListHelper.contactList, context)
                : Column(
                    children: <Widget>[
                      ...popupDetails.map((popupDetails) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  child: popupDetails.fieldName == "Email"
                                      ? Icon(
                                          Icons.email_outlined,
                                          color: blueColor,
                                          size: 22,
                                        )
                                      : popupDetails.fieldName == "Phone"
                                          ? Icon(
                                              Icons.call,
                                              color: blueColor,
                                              size: 22,
                                            )
                                          : popupDetails.fieldName ==
                                                  "Organization"
                                              ? Icon(
                                                  Boxicons.bx_building,
                                                  color: blueColor,
                                                  size: 22,
                                                )
                                              : popupDetails.fieldName == "Tag"
                                                  ? Icon(
                                                      Icons
                                                          .local_offer_outlined,
                                                      color: blueColor,
                                                      size: 22,
                                                    )
                                                  : popupDetails.fieldName ==
                                                          "Website"
                                                      ? Icon(
                                                          Boxicons.bx_world,
                                                          color: blueColor,
                                                          size: 22,
                                                        )
                                                      : popupDetails
                                                                  .fieldName ==
                                                              "Name"
                                                          ? Icon(
                                                              Boxicons.bx_user,
                                                              color: blueColor,
                                                              size: 22,
                                                            )
                                                          : popupDetails
                                                                      .fieldName ==
                                                                  "Country"
                                                              ? Icon(
                                                                  Boxicons
                                                                      .bxs_flag_alt,
                                                                  color:
                                                                      blueColor,
                                                                  size: 22,
                                                                )
                                                              : popupDetails
                                                                          .fieldName ==
                                                                      "City"
                                                                  ? Icon(
                                                                      Boxicons
                                                                          .bxs_city,
                                                                      color:
                                                                          blueColor,
                                                                      size: 22,
                                                                    )
                                                                  : popupDetails
                                                                              .fieldName ==
                                                                          "Description"
                                                                      ? Icon(
                                                                          Boxicons
                                                                              .bx_message_rounded,
                                                                          color:
                                                                              blueColor,
                                                                          size:
                                                                              22,
                                                                        )
                                                                      : popupDetails.fieldName ==
                                                                              "Owner"
                                                                          ? Icon(
                                                                              Icons.person_outline,
                                                                              color: blueColor,
                                                                              size: 22,
                                                                            )
                                                                          : Text(
                                                                              (popupDetails.apiKeyName.isEmpty ? "NA" : popupDetails.apiKeyName.toString().characters.first.toUpperCase()),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: blueColor,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                ),
                              ),
                              title: Text(popupDetails.fieldName),
                              subtitle: popupDetails.fieldInputType ==
                                      FieldInputType.TAG_MULTI_SELECT.getType()
                                  ? popupDetails.value.isNotEmpty
                                      ? SizedBox(
                                          height: 30,
                                          child: ListView.builder(
                                              itemCount: popupDetails
                                                  .valueWithColor.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10, right: 8.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 2.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      color: getValue(
                                                          popupDetails
                                                                  .valueWithColor ??
                                                              greenColor,
                                                          index),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      popupDetails
                                                              .valueWithColor[
                                                          index]["label"],
                                                      style: TextStyle(
                                                          color: white),
                                                    )));
                                              }),
                                        )
                                      : SizedBox()
                                  : popupDetails.fieldInputType ==
                                          FieldInputType.DATE_TIME.getType()
                                      ? popupDetails.fieldGroup ==
                                              FieldGroupType.CUSTOM.getType()
                                          ? popupDetails.value != ''
                                              ? Text(
                                                  "${popupDetails.value != null ? f.format(DateTime.parse(popupDetails.value.toString()).toLocal()) : "NA"} ")
                                              : SizedBox()
                                          : popupDetails.value != ''
                                              ? Text(popupDetails.value != null
                                                  ? popupDetails.value == ""
                                                      ? ''
                                                      : timeAgoConverter.timeAgoString(
                                                          popupDetails.value)
                                                  : '')
                                              : SizedBox()
                                      : popupDetails.fieldInputType ==
                                              FieldInputType.DATE.getType()
                                          ? popupDetails.value != ''
                                              ? Text(
                                                  "${popupDetails.value != null ? f.format(DateTime.parse(popupDetails.value.toString()).toLocal()) : "NA"} ")
                                              : SizedBox()
                                          : popupDetails.fieldInputType ==
                                                      FieldInputType
                                                          .DATE_TIME_RANGE
                                                          .getType() ||
                                                  popupDetails.fieldInputType ==
                                                      FieldInputType.DATE_RANGE
                                                          .getType()
                                              ? popupDetails.value != null
                                                  ? popupDetails.value != null
                                                      ? Text(
                                                          "${popupDetails.value.isNotEmpty ? f.format(DateTime.parse(popupDetails.value[0].toString()).toLocal()) + '  -  ' + f.format(DateTime.parse(popupDetails.value[1].toString()).toLocal()) : ""} ")
                                                      : SizedBox()
                                                  : SizedBox()
                                              : popupDetails.fieldInputType ==
                                                      FieldInputType.CHECKBOX
                                                          .getType()
                                                  ? Text(popupDetails.value !=
                                                          null
                                                      ? popupDetails.value == ""
                                                          ? ''
                                                          : popupDetails.value
                                                              .join(",")
                                                      : '')
                                                  : popupDetails.fieldInputType ==
                                                              FieldInputType
                                                                  .MULTI_EMAIL_INPUT
                                                                  .getType() ||
                                                          popupDetails.fieldInputType ==
                                                              FieldInputType.MULTI_PHONE_INPUT.getType()
                                                      ? Text(popupDetails.value != null
                                                          ? popupDetails.value == ""
                                                              ? ''
                                                              : popupDetails.value.join(",")
                                                          : '')
                                                      : popupDetails.fieldInputType == FieldInputType.SELECT.getType()
                                                          ? Text(popupDetails.value != null
                                                              ? popupDetails.value == ""
                                                                  ? ''
                                                                  : popupDetails.value.toString()
                                                              : '')
                                                          : popupDetails.fieldInputType == FieldInputType.RADIO.getType()
                                                              ? Text(popupDetails.value != null
                                                                  ? popupDetails.value == ""
                                                                      ? ''
                                                                      : popupDetails.value.toString()
                                                                  : '')
                                                              : popupDetails.fieldInputType == FieldInputType.TOGGLE_BUTTON.getType()
                                                                  ? Text(popupDetails.value != null
                                                                      ? (popupDetails.value is bool && popupDetails.value == true)
                                                                          ? 'Yes'
                                                                          : (popupDetails.value is bool && popupDetails.value == false)
                                                                              ? 'No'
                                                                              : '${popupDetails.value}'
                                                                      : 'null')
                                                                  : popupDetails.fieldInputType == FieldInputType.OWNER_SELECT.getType()
                                                                      ? Text((popupDetails.value is String) ? popupDetails.value : popupDetails.value.label)
                                                                      : Text(popupDetails.value.toString()),
                              trailing: popupDetails.fieldInputType ==
                                      FieldInputType.DATE_TIME.getType()
                                  ? SizedBox()
                                  : popupDetails.fieldInputType ==
                                          FieldInputType.TIMEZONE_SELECT
                                              .getType()
                                      ? SizedBox()
                                      : popupDetails.fieldInputType ==
                                                  FieldInputType.DATE_TIME_RANGE
                                                      .getType() ||
                                              popupDetails.fieldInputType ==
                                                  FieldInputType.DATE_RANGE
                                                      .getType()
                                          ? EditButton(
                                              onTap: () => CustomBottomSheet(
                                                      handler: refresh,
                                                      id: widget.args["id"])
                                                  .peopleDateRangeBottomDialog(
                                                      context,
                                                      popupDetails,
                                                      PageNavigatedFrom.PEOPLE
                                                          .getType()),
                                            )
                                          : popupDetails.fieldInputType ==
                                                  FieldInputType.CHECKBOX
                                                      .getType()
                                              ? EditButton(
                                                  onTap: () => CustomBottomSheet(
                                                          handler: refresh,
                                                          id: widget.args["id"])
                                                      .peopleCheckBoxBottomDialog(
                                                          context,
                                                          popupDetails,
                                                          PageNavigatedFrom
                                                              .PEOPLE
                                                              .getType()),
                                                )
                                              : popupDetails.fieldInputType ==
                                                      FieldInputType.RADIO
                                                          .getType()
                                                  ? EditButton(
                                                      onTap: () => CustomBottomSheet(
                                                              handler: refresh,
                                                              id: widget
                                                                  .args["id"])
                                                          .peopleRadioBottomDialog(
                                                              context,
                                                              popupDetails,
                                                              PageNavigatedFrom
                                                                  .PEOPLE
                                                                  .getType()),
                                                    )
                                                  : popupDetails.fieldInputType ==
                                                          FieldInputType.DATE
                                                              .getType()
                                                      ? EditButton(
                                                          onTap: () => CustomBottomSheet(
                                                                  handler:
                                                                      refresh,
                                                                  id: widget
                                                                          .args[
                                                                      "id"])
                                                              .peopleDateBottomDialog(
                                                                  context,
                                                                  popupDetails,
                                                                  selectedDate
                                                                      .toString(),
                                                                  () => _selectDate(
                                                                      context),
                                                                  PageNavigatedFrom
                                                                      .PEOPLE
                                                                      .getType()),
                                                        )
                                                      : popupDetails.fieldInputType ==
                                                              FieldInputType
                                                                  .TOGGLE_BUTTON
                                                                  .getType()
                                                          ? EditButton(
                                                              onTap: () => CustomBottomSheet(
                                                                      handler:
                                                                          refresh,
                                                                      id: widget
                                                                              .args[
                                                                          "id"])
                                                                  .peopleToggleButtonBottomDialog(
                                                                      context,
                                                                      popupDetails,
                                                                      PageNavigatedFrom
                                                                          .PEOPLE
                                                                          .getType()),
                                                            )
                                                          : popupDetails.fieldInputType ==
                                                                  FieldInputType
                                                                      .SELECT
                                                                      .getType()
                                                              ? EditButton(
                                                                  onTap: () =>
                                                                      CustomBottomSheet(handler: refresh, id: widget.args["id"])
                                                                          .peopleDropdownBottomDialog(context, popupDetails, PageNavigatedFrom.PEOPLE.getType()))
                                                              : popupDetails.fieldInputType == FieldInputType.OWNER_SELECT.getType()
                                                                  ? SizedBox()
                                                                  : popupDetails.isEditable
                                                                      ? EditButton(
                                                                          onTap: () => CustomBottomSheet(handler: refresh, id: widget.args["id"]).contactBottomDialog(
                                                                              context,
                                                                              popupDetails),
                                                                        )
                                                                      : SizedBox(),
                            ),
                            Divider()
                          ],
                        );
                      }).toList(),
                    ],
                  )
            : Center(
                child: EmptyListShimmer(tab: 4),
              );
      },
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

  refresh() {
    setState(() {
      widget.isUpdated = true;
    });
  }
}
// print(list.join(","));
