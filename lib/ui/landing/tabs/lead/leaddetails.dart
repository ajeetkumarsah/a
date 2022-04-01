import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/Leads.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/activity_lost_reasons.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/models/lead_details.list.dart';
import 'package:salessimplify/models/next_activity_model.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/landing/tabs/lead/widgets/activities.dart';
import 'package:salessimplify/ui/landing/tabs/lead/widgets/notes.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:salessimplify/ui/widgetHelper/tab_loader.dart';
import 'package:salessimplify/ui/widgetHelper/time_ago_converter.dart';

import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

import 'widgets/convert_lead_to_deal.dart';

class LeadsDetails extends StatefulWidget {
  static String ROUTE_LEAD_DETAILS = "route/LeadsDetails";

  @override
  _LeadsDetailsState createState() => _LeadsDetailsState();
}

class _LeadsDetailsState extends State<LeadsDetails> {
  bool isProcessing = false, isUpdated = false;
  List<String> reasons = [];
  List<DropDownModel> modes = [];
  CompanyNewModel? company;
  List<SearchCompanyNew> selectedCompany = [];
  var f = DateFormat('d MMM,yyyy, hh:mm a');
  @override
  void initState() {
    setLostReasons();
    super.initState();
    context.read<Repository>().getPipelines();
  }

  setLostReasons() async {
    List<ActivityLostReasons> data =
        await Repository.getInstance().getLeadsLostReasons();
    data.forEach((element) {
      reasons.add(element.reason);
    });

    print("");
  }

  getDealsWithDefaultId(BuildContext ctx) async {
    var data = await Repository.getInstance().getPipelines();
    if (data is List<PipelineModel> && (data).length > 0) {
      ctx.read<Repository>().getDeals(data[0].id);
    }
  }

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
        content: "Do you want to delete this lead?",
        yesOnPressed: () {
          Navigator.pop(context);
          deleteLead(context, params);
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
    company = args['company'];
    selectedCompany.add(SearchCompanyNew(
      id: company!.id,
      name: company!.name,
      createdAddress: '',
      createdAt: '',
      email: [],
      owner: '',
      phone: [],
      website: '',
    ));

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: args["name"] != null ? args["name"] : 'NA',
        leading: IconButton(
          onPressed: () => Navigator.pop(context, isUpdated),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (int result) {
              setState(() {
                if (result == 0) {
                  if (args["type"] != "junk") {
                    customBottomSheet.convertLeadsBottomDialog(
                      context: context,
                      onTap: () {
                        convertLead(context, args["id"], args["type"] == "junk")
                            .then((value) => Navigator.pop(context, true));
                      },
                      reasons: reasons,
                    );
                  } else {
                    convertLead(context, args["id"], args["type"] == "junk")
                        .then((value) => Navigator.pop(context, true));
                  }

                  //convert the current lead to junk
                } else if (result == 1) {
                  // convertLeadToDeal(context, args["id"]);

                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => ConvertLeadToDeal(
                            leadId:args["id"],
                                dealName: args["name"] ?? 'name',
                                emailId: args["email"] ?? '',
                                phoneNumber: args["phone"] ?? '',
                                selectedCompany: selectedCompany[0].name == ''
                                    ? []
                                    : selectedCompany,
                                selectedPeople: [],
                                selectedTags: [],
                              ))).then((value) {
                    getDealsWithDefaultId(context);
                    print('~~~~~~~~~~Getting default deal');
                  });
                } else if (result == 2) {}
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: Text(args["type"] == "junk"
                    ? "Convert to Active"
                    : "Convert to Junk"),
              ),
              if (args["type"] != "junk")
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Convert to Deal"),
                ),
            ],
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, isUpdated);
          return isUpdated;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                decoration: BoxDecoration(color: white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 28.0),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [blueColor, deepblue],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Center(
                                  child: Icon(
                                    Boxicons.bx_bullseye,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              title: Text(
                                args["name"] ?? '',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Map<String, dynamic> params = {};
                                  params["ids"] = [args["id"]];
                                  confirmDelete(params);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: white,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 0.0),
                              leading: Icon(
                                Boxicons.bx_building,
                                color: white,
                                size: 20,
                              ),
                              title: Text(company?.name ?? '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: white)),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 0.0),
                              leading: Icon(
                                Icons.mail_outline,
                                color: white,
                                size: 20,
                              ),
                              title: Text(args["email"] ?? '',
                                  style: TextStyle(color: white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints.expand(height: 50),
                                child: TabBar(
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  labelColor: Colors.blue,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorWeight: 3,
                                  indicatorColor: appColor.blue,
                                  tabs: [
                                    Tab(text: "General"),
                                    Tab(text: "Activities"),
                                    Tab(text: "Notes"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    rowBuilder(args),
                                    LinkedActivities(
                                        id: args["id"],
                                        idType: 'leadId',
                                        createTypeId: 'lead'),
                                    NotesList(id: args['id'], idType: 'leadId'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteLead(BuildContext context, Map<String, dynamic> params) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deleteLead(params);
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

  convertLead(BuildContext context, String id, bool isJunk) async {
    Map<String, String> params = {};
    params["id"] = id;
    final ProgressDialog progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    progressDialog.show();
    setState(() {
      isProcessing = true;
    });
    if (isJunk) {
      var success =
          await context.read<Repository>().convertJunkToActive(params);
      navigateToHomeActivetoJunk(context, success, progressDialog,
          "Successfully Converted to Active", isJunk);
    } else {
      var success =
          await context.read<Repository>().convertActiveToJunk(params);
      navigateToHomeActivetoJunk(context, success, progressDialog,
          "Successfully Converted to Junk", isJunk);
    }
  }

  navigateToHomeActivetoJunk(BuildContext context, bool isSuccess,
      ProgressDialog progressDialog, String successText, bool isJunk) {
    if (isSuccess) {
      toastHelper.toastWithTitleAndColor(successText, greenColor);
      progressDialog.hide();
      if (isJunk) {
      } else {
        Navigator.pop(context);
      }
    } else {
      toastHelper.toastWithTitleAndColor("Failed to Convert", redColor);
      progressDialog.hide();
    }
  }

  convertLeadToDeal(BuildContext context, String leadid) async {
    Map<String, dynamic> params = {};

    setState(() {
      isProcessing = true;
    });

    var success = await context.read<Repository>().convertLeadToDeal(params);
    print(success.toString());
    toastHelper.toastWithTitleAndColor(success.toString(), greenColor);
  }

  late NextActivityModel nextActivityValue;
  Widget rowBuilder(args) {
    print('||=========>id:' + args["id"].toString());
    return FutureBuilder(
      future: Repository.getInstance().getLeadsDetailsList(args["id"]),
      builder: (context, snapshot) {
        List<LeadDetailsList>? leadDetails;
        if (snapshot.connectionState == ConnectionState.done) {
          leadDetails = snapshot.data as List<LeadDetailsList>?;
        }
        return snapshot.connectionState == ConnectionState.done
            ? leadDetails!.isEmpty
                ? emptyListHelper.getEmptyList(
                    EmptyListHelper.activeLeadsList, context)
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    color: white,
                    child: ListView.builder(
                      itemCount: leadDetails.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (leadDetails![i].fieldInputType ==
                            FieldInputType.ACTIVITY_SHOW.getType()) {
                          if (leadDetails[i].nextActivityValue
                              is NextActivityModel)
                            nextActivityValue =
                                leadDetails[i].nextActivityValue;
                          else
                            nextActivityValue = NextActivityModel(
                                activityStatus: '',
                                activityName: '',
                                activitySymbol: '',
                                mobileIcon: '');
                        }
                        return Container(
                          decoration: BoxDecoration(color: white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 0),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: leadDetails[i].fieldName == "Email"
                                        ? Icon(
                                            Icons.email_outlined,
                                            color: blueColor,
                                            size: 22,
                                          )
                                        : leadDetails[i].fieldName == "Phone"
                                            ? Icon(
                                                Icons.call,
                                                color: blueColor,
                                                size: 22,
                                              )
                                            : leadDetails[i].fieldName ==
                                                    "Organization"
                                                ? Icon(
                                                    Boxicons.bx_building,
                                                    color: blueColor,
                                                    size: 22,
                                                  )
                                                : leadDetails[i].fieldName ==
                                                        "Tag"
                                                    ? Icon(
                                                        Icons
                                                            .local_offer_outlined,
                                                        color: blueColor,
                                                        size: 22,
                                                      )
                                                    : leadDetails[i]
                                                                .fieldName ==
                                                            "Website"
                                                        ? Icon(
                                                            Boxicons.bx_world,
                                                            color: blueColor,
                                                            size: 22,
                                                          )
                                                        : leadDetails[i]
                                                                    .fieldName ==
                                                                "Name"
                                                            ? Icon(
                                                                Boxicons
                                                                    .bx_user,
                                                                color:
                                                                    blueColor,
                                                                size: 22,
                                                              )
                                                            : leadDetails[i]
                                                                        .fieldName ==
                                                                    "Country"
                                                                ? Icon(
                                                                    Boxicons
                                                                        .bxs_flag_alt,
                                                                    color:
                                                                        blueColor,
                                                                    size: 22,
                                                                  )
                                                                : leadDetails[i]
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
                                                                    : leadDetails[i].fieldName ==
                                                                            "Description"
                                                                        ? Icon(
                                                                            Boxicons.bx_message_rounded,
                                                                            color:
                                                                                blueColor,
                                                                            size:
                                                                                22,
                                                                          )
                                                                        : leadDetails[i].fieldName ==
                                                                                "Owner"
                                                                            ? Icon(
                                                                                Icons.person_outline,
                                                                                color: blueColor,
                                                                                size: 22,
                                                                              )
                                                                            : Text(
                                                                                (leadDetails[i].apiKeyName!.isEmpty ? "NA" : leadDetails[i].apiKeyName.toString().characters.first.toUpperCase()),
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  color: blueColor,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                  ),
                                ),
                                title: Text(leadDetails[i].fieldName!),
                                subtitle: leadDetails[i].fieldInputType ==
                                        FieldInputType.TAG_MULTI_SELECT
                                            .getType()
                                    ? leadDetails[i].value.isNotEmpty
                                        ? SizedBox(
                                            height: 30,
                                            child: ListView.builder(
                                                itemCount: leadDetails[i]
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
                                                          top: 10, right: 8.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 2.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        color: getHexValue(
                                                            leadDetails![i]
                                                                    .valueWithColor ??
                                                                greenColor,
                                                            index),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        leadDetails[i]
                                                                .valueWithColor[
                                                            index]["label"],
                                                        style: TextStyle(
                                                            color: white),
                                                      )));
                                                }),
                                          )
                                        : SizedBox()
                                    : leadDetails[i].fieldInputType ==
                                            FieldInputType.DATE_TIME.getType()
                                        ? leadDetails[i].fieldGroup ==
                                                FieldGroupType.CUSTOM.getType()
                                            ? leadDetails[i].value != ''
                                                ? Text(
                                                    "${leadDetails[i].value != null ? f.format(DateTime.parse(leadDetails[i].value.toString()).toLocal()) : "NA"} ")
                                                : SizedBox()
                                            : leadDetails[i].value != ''
                                                ? Text(leadDetails[i].value !=
                                                        null
                                                    ? leadDetails[i].value == ""
                                                        ? ''
                                                        : timeAgoConverter.timeAgoString(
                                                            leadDetails[i]
                                                                .value)
                                                    : '')
                                                : SizedBox()
                                        : leadDetails[i].fieldInputType ==
                                                FieldInputType.DATE.getType()
                                            ? leadDetails[i].value != ''
                                                ? Text(
                                                    "${leadDetails[i].value != null ? f.format(DateTime.parse(leadDetails[i].value.toString()).toLocal()) : "NA"} ")
                                                : SizedBox()
                                            : leadDetails[i].fieldInputType ==
                                                        FieldInputType.DATE_TIME_RANGE
                                                            .getType() ||
                                                    leadDetails[i].fieldInputType ==
                                                        FieldInputType.DATE_RANGE
                                                            .getType()
                                                ? leadDetails[i].value != null
                                                    ? leadDetails[i].value !=
                                                            null
                                                        ? Text(
                                                            "${leadDetails[i].value.isNotEmpty ? f.format(DateTime.parse(leadDetails[i].value[0].toString()).toLocal()) + '  -  ' + f.format(DateTime.parse(leadDetails[i].value[1].toString()).toLocal()) : ""} ")
                                                        : SizedBox()
                                                    : SizedBox()
                                                : leadDetails[i].fieldInputType ==
                                                        FieldInputType.ACTIVITY_SHOW.getType()
                                                    ? Text(nextActivityValue.activityName)
                                                    : leadDetails[i].fieldInputType == FieldInputType.CHECKBOX.getType()
                                                        ? Text(leadDetails[i].value != null
                                                            ? leadDetails[i].value == ""
                                                                ? ''
                                                                : leadDetails[i].value.join(",")
                                                            : '')
                                                        : leadDetails[i].fieldInputType == FieldInputType.MULTI_EMAIL_INPUT.getType() || leadDetails[i].fieldInputType == FieldInputType.MULTI_PHONE_INPUT.getType()
                                                            ? Text(leadDetails[i].value != null
                                                                ? leadDetails[i].value == ""
                                                                    ? ''
                                                                    : leadDetails[i].value.join(",")
                                                                : '')
                                                            : leadDetails[i].fieldInputType == FieldInputType.SELECT.getType()
                                                                ? Text(leadDetails[i].value != null
                                                                    ? leadDetails[i].value == ""
                                                                        ? ''
                                                                        : leadDetails[i].value.toString()
                                                                    : '')
                                                                : leadDetails[i].fieldInputType == FieldInputType.RADIO.getType()
                                                                    ? Text(leadDetails[i].value != null
                                                                        ? leadDetails[i].value == ""
                                                                            ? ''
                                                                            : leadDetails[i].value.toString()
                                                                        : '')
                                                                    : leadDetails[i].fieldInputType == FieldInputType.TOGGLE_BUTTON.getType()
                                                                        ? Text(leadDetails[i].value != null
                                                                            ? (leadDetails[i].value is bool && leadDetails[i].value == true)
                                                                                ? 'Yes'
                                                                                : (leadDetails[i].value is bool && leadDetails[i].value == false)
                                                                                    ? 'No'
                                                                                    : '${leadDetails[i].value}'
                                                                            : 'null')
                                                                        : leadDetails[i].fieldInputType == FieldInputType.OWNER_SELECT.getType()
                                                                            ? Text((leadDetails[i].value is String) ? leadDetails[i].value : leadDetails[i].value.label)
                                                                            : Text(leadDetails[i].value.toString()),
                                trailing: leadDetails[i].fieldInputType ==
                                        FieldInputType.DATE_TIME.getType()
                                    ? SizedBox()
                                    : leadDetails[i].fieldInputType ==
                                            FieldInputType.TIMEZONE_SELECT
                                                .getType()
                                        ? SizedBox()
                                        : leadDetails[i].fieldInputType ==
                                                    FieldInputType.DATE_TIME_RANGE
                                                        .getType() ||
                                                leadDetails[i].fieldInputType ==
                                                    FieldInputType.DATE_RANGE
                                                        .getType()
                                            ? EditButton(
                                                onTap: () => CustomBottomSheet(
                                                        handler: refresh,
                                                        id: args["id"])
                                                    .leadDateRangeBottomDialog(
                                                        context,
                                                        leadDetails![i]),
                                              )
                                            : leadDetails[i].fieldInputType ==
                                                    FieldInputType.CHECKBOX
                                                        .getType()
                                                ? EditButton(
                                                    onTap: () => CustomBottomSheet(
                                                            handler: refresh,
                                                            id: args["id"])
                                                        .leadCheckBoxBottomDialog(
                                                      context,
                                                      leadDetails![i],
                                                    ),
                                                  )
                                                : leadDetails[i].fieldInputType ==
                                                        FieldInputType.RADIO
                                                            .getType()
                                                    ? EditButton(
                                                        onTap: () =>
                                                            CustomBottomSheet(
                                                                    handler:
                                                                        refresh,
                                                                    id: args[
                                                                        "id"])
                                                                .leadRadioBottomDialog(
                                                                    context,
                                                                    leadDetails![
                                                                        i]),
                                                      )
                                                    : leadDetails[i].fieldInputType ==
                                                            FieldInputType.DATE
                                                                .getType()
                                                        ? EditButton(
                                                            onTap: () => CustomBottomSheet(
                                                                    handler:
                                                                        refresh,
                                                                    id: args[
                                                                        "id"])
                                                                .leadDateBottomDialog(
                                                                    context,
                                                                    leadDetails![
                                                                        i],
                                                                    selectedDate
                                                                        .toString(),
                                                                    () => _selectDate(
                                                                        context)),
                                                          )
                                                        : leadDetails[i].fieldInputType ==
                                                                FieldInputType
                                                                    .TOGGLE_BUTTON
                                                                    .getType()
                                                            ? EditButton(
                                                                onTap: () => CustomBottomSheet(
                                                                        handler:
                                                                            refresh,
                                                                        id: args[
                                                                            "id"])
                                                                    .leadToggleButtonBottomDialog(
                                                                  context,
                                                                  leadDetails![
                                                                      i],
                                                                ),
                                                              )
                                                            : leadDetails[i].fieldInputType ==
                                                                    FieldInputType
                                                                        .SELECT
                                                                        .getType()
                                                                ? EditButton(onTap: () => CustomBottomSheet(handler: refresh, id: args["id"]).leadDropdownBottomDialog(context, leadDetails![i]))
                                                                : leadDetails[i].fieldInputType == FieldInputType.OWNER_SELECT.getType()
                                                                    ? SizedBox()
                                                                    : leadDetails[i].isEditable == true
                                                                        ? EditButton(
                                                                            onTap: () =>
                                                                                CustomBottomSheet(handler: refresh, id: args["id"]).leadBottomDialog(context, leadDetails![i]),
                                                                          )
                                                                        : SizedBox(),
                              ),
                              Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  )
            : TabLoader();
      },
    );
  }

  refresh() {
    setState(() {
      isUpdated = true;
    });
  }

  getHexValue(dynamic value, int index) {
    if (value is List &&
        (value).length > 0 &&
        value[index]["colorCode"] != null) {
      return HexColor.fromHex(value[index]["colorCode"]);
    } else {
      return Colors.grey;
    }
  }
}
