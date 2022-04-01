import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/DealModel.dart';
import 'package:salessimplify/models/activity_details_model.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/contact/widgets/popup_details_loader.dart';
import 'package:salessimplify/ui/landing/tabs/deal/widget/product_categories.dart';
import 'package:salessimplify/ui/landing/tabs/lead/widgets/activities.dart';
import 'package:salessimplify/ui/landing/tabs/lead/widgets/notes.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/edit_button.dart';
import 'package:salessimplify/ui/widgetHelper/empty_screen_helper.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/widgetHelper/time_ago_converter.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

import 'DealsPage.dart';

class DealDetailsPage extends StatefulWidget {
  static String routeName = "DealDetailsPage";

  const DealDetailsPage({Key? key}) : super(key: key);

  @override
  _DealDetailsPageState createState() => _DealDetailsPageState();
}

class _DealDetailsPageState extends State<DealDetailsPage> {
  bool isProcessing = false, isUpdated = false;
  var f = DateFormat('d MMM,yyyy, hh:mm a');
  @override
  void initState() {
    super.initState();
    context.read<Repository>().getPipelines();
  }

  confirmDelete(Map<String, dynamic> params) {
    var baseDialog = BaseAlertDialog(
        title: "Are you sure?",
        content: "Do you want to delete this deal?",
        yesOnPressed: () {
          Navigator.pop(context);
          deleteDeal(context, params);
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
    DealModel itemObject = args['item'];
    print('Deal id ~~~~~~~ ' + itemObject.id.toString());
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
          title: itemObject.title,
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
                    convertLead(context, itemObject.id);

                    //convert the current deal to lead
                  } else if (result == 1) {
                    //delete the current deal
                    // deleteLead();
                  }
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Convert to Lead"),
                ),
                // PopupMenuItem<int>(
                //   value: 1,
                //   child: Text("Delete"),
                // ),
              ],
            )
          ]),
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
                decoration: BoxDecoration(
                  color: white,
                ),
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
                                    Icons.monetization_on_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              title: Text(
                                itemObject.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Map<String, dynamic> params = {};
                                  params["dealId"] = itemObject.id;
                                  // deleteDeal(context, params);
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
                              title: Text(itemObject.company.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: white)),
                              // subtitle: Text(  itemObject.people.name),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 0.0),
                              leading: Icon(
                                Boxicons.bx_rupee,
                                color: white,
                                size: 20,
                              ),
                              title: Text(
                                itemObject.dealCurrency,
                                style: TextStyle(color: white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: DefaultTabController(
                          length: 4,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints.expand(height: 50),
                                child: TabBar(
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  labelColor: Colors.blue,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorWeight: 3,
                                  indicatorColor: appColor.blue,
                                  tabs: const [
                                    FittedBox(child: Tab(text: "General")),
                                    FittedBox(child: Tab(text: "Activities")),
                                    FittedBox(child: Tab(text: "Notes")),
                                    FittedBox(child: Tab(text: "Products")),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    FutureBuilder(
                                      future: Repository.getInstance()
                                          .getActivityDetails(
                                              itemObject.id, true),
                                      builder: (context, snapshot) {
                                        List<ActivityDetailsModel>?
                                            activityDetails;
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          activityDetails = snapshot.data
                                              as List<ActivityDetailsModel>;
                                        }
                                        return snapshot.connectionState ==
                                                ConnectionState.done
                                            ? activityDetails!.isEmpty
                                                ? emptyListHelper.getEmptyList(
                                                    EmptyListHelper.contactList,
                                                    context)
                                                : ListView.builder(
                                                    itemCount:
                                                        activityDetails.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int i) {
                                                      return activityDetails![i]
                                                                  .fieldInputType ==
                                                              FieldInputType
                                                                  .INPUT
                                                                  .getType()
                                                          ? rowBuilder(
                                                              activityDetails[
                                                                  i],
                                                              false,
                                                              itemObject)
                                                          : activityDetails[i]
                                                                      .fieldInputType ==
                                                                  FieldInputType
                                                                      .DATE_TIME
                                                                      .getType()
                                                              ? rowBuilder(
                                                                  activityDetails[
                                                                      i],
                                                                  false,
                                                                  itemObject)
                                                              : activityDetails[i]
                                                                          .fieldInputType ==
                                                                      FieldInputType
                                                                          .LEAD_SELECT
                                                                          .getType()
                                                                  ? rowBuilder(
                                                                      activityDetails[
                                                                          i],
                                                                      false,
                                                                      itemObject)
                                                                  : activityDetails[i]
                                                                              .fieldInputType ==
                                                                          FieldInputType
                                                                              .DEAL_SELECT
                                                                              .getType()
                                                                      ? rowBuilder(
                                                                          activityDetails[
                                                                              i],
                                                                          false,
                                                                          itemObject)
                                                                      : activityDetails[i].fieldInputType ==
                                                                              FieldInputType.ORG_SELECT
                                                                                  .getType()
                                                                          ? rowBuilder(
                                                                              activityDetails[i],
                                                                              false,
                                                                              itemObject)
                                                                          : activityDetails[i].fieldInputType == FieldInputType.TAG_MULTI_SELECT.getType()
                                                                              ? rowBuilder(activityDetails[i], false, itemObject)
                                                                              : activityDetails[i].fieldInputType == FieldInputType.PERSON_SELECT.getType()
                                                                                  ? rowBuilder(activityDetails[i], false, itemObject)
                                                                                  : activityDetails[i].fieldInputType == FieldInputType.NUMBER.getType() || activityDetails[i].fieldInputType == FieldInputType.DATE.getType() || activityDetails[i].fieldInputType == FieldInputType.CURRENCY_SELECT.getType() || activityDetails[i].fieldName == 'Expected Close Date' || activityDetails[i].fieldInputType == FieldInputType.OWNER_SELECT.getType() || activityDetails[i].fieldInputType == FieldInputType.PIPELINE_SELECT.getType() || activityDetails[i].fieldInputType == FieldInputType.PIPELINE_STAGE_SELECT.getType()
                                                                                      ? rowBuilder(activityDetails[i], false, itemObject)
                                                                                      : SizedBox();
                                                    })
                                            : PopupDetailsLoader();
                                      },
                                    ),
                                    LinkedActivities(
                                        idType: 'dealId',
                                        id: itemObject.id,
                                        createTypeId: 'deal'),
                                    NotesList(
                                        id: itemObject.id, idType: 'dealId'),
                                    ProductsList(
                                        id: itemObject.id, idType: 'dealId')
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

  Widget rowBuilder(
      ActivityDetailsModel? activityDetails, bool owner, DealModel itemObject) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
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
                ? Text(timeAgoConverter.timeAgoString(activityDetails.value))
                // ? Text("${activityDetails.value != null ? f.format(
                //     DateTime.parse(activityDetails.value).toLocal(),
                //   ) : "NA"} ")
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
                                FieldInputType.PERSON_SELECT.getType()
                            ? Text(activityDetails.value != null
                                ? activityDetails.value.isNotEmpty
                                    ? "${activityDetails.value['name'] != null ? activityDetails.value['name'] : 'NA'} "
                                    : ''
                                : "")
                            : activityDetails.fieldInputType ==
                                    FieldInputType.ORG_SELECT.getType()
                                ? Text(activityDetails.value != null
                                    ? activityDetails.value.isNotEmpty
                                        ? "${activityDetails.value['name'] != null ? activityDetails.value['name'] : 'NA'} "
                                        : ""
                                    : '')
                                : activityDetails.fieldInputType ==
                                        FieldInputType.TAG_MULTI_SELECT
                                            .getType()
                                    ? activityDetails.value != null
                                        ? activityDetails.value.isNotEmpty
                                            ? SizedBox(
                                                height: 30,
                                                child: ListView.builder(
                                                  itemCount: activityDetails
                                                      .value.length,
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
                                                        color: getValue(
                                                            activityDetails
                                                                    .value ??
                                                                greenColor,
                                                            index),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          activityDetails
                                                                  .value[index]
                                                              ['label'],
                                                          style: TextStyle(
                                                              color: white),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : SizedBox()
                                        : SizedBox()
                                    : activityDetails.fieldInputType ==
                                                FieldInputType.PIPELINE_SELECT
                                                    .getType() ||
                                            activityDetails.fieldInputType ==
                                                FieldInputType.PIPELINE_STAGE_SELECT
                                                    .getType()
                                        ? Text(activityDetails.value['name'])
                                        : activityDetails.fieldInputType ==
                                                FieldInputType.CURRENCY_SELECT
                                                    .getType()
                                            ? Text(activityDetails.value
                                                .toString())
                                            : activityDetails.fieldInputType ==
                                                    FieldInputType.OWNER_SELECT
                                                        .getType()
                                                ? Text(activityDetails.value['label'] != null
                                                    ? activityDetails
                                                        .value['label']
                                                    : 'null')
                                                : activityDetails
                                                            .fieldInputType ==
                                                        FieldInputType.DATE
                                                            .getType()
                                                    ? Text(
                                                        "${activityDetails.value != '' ? activityDetails.value != null ? f.format(
                                                            DateTime.parse(
                                                                    activityDetails
                                                                        .value)
                                                                .toLocal(),
                                                          ) : "NA" : ''} ")
                                                    : (activityDetails.value
                                                            is List)
                                                        ? Text(activityDetails.value.isNotEmpty
                                                            ? activityDetails.value.toString()
                                                            : '')
                                                        : Text(activityDetails.value.toString()),
            trailing: activityDetails.fieldName == 'Last Updated'
                ? SizedBox()
                : activityDetails.fieldInputType ==
                        FieldInputType.OWNER_SELECT.getType()
                    ? SizedBox()
                    : activityDetails.fieldInputType ==
                            FieldInputType.DATE_TIME.getType()
                        ? SizedBox()
                        : activityDetails.fieldInputType ==
                                FieldInputType.CURRENCY_SELECT.getType()
                            ? SizedBox()
                            : activityDetails.fieldInputType ==
                                    FieldInputType.DATE.getType()
                                ? EditButton(
                                    onTap: () => CustomBottomSheet(
                                            handler: refresh, id: itemObject.id)
                                        .activityDateBottomDialog(
                                            context,
                                            activityDetails,
                                            activityDetails.value,
                                            () {}),
                                  )
                                : EditButton(
                                    onTap: () => CustomBottomSheet(
                                            handler: refresh, id: itemObject.id)
                                        .dealBottomDialog(
                                            context, activityDetails),
                                  ),
          ),
          Divider()
        ],
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

  refresh() {
    setState(() {
      isUpdated = true;
    });
  }

  deleteDeal(BuildContext context, Map<String, dynamic> params) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deleteDeal(params);
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

  convertLead(BuildContext context, String id) async {
    Map<String, String> params = {};
    params = {"dealId": id};
    setState(() {
      isProcessing = true;
    });
    var success = await context.read<Repository>().convertDealToLead(params);
    navigateToHome(context, success);
  }

  navigateToHome(BuildContext context, bool isSuccess) {
    if (isSuccess is bool && isSuccess) {
      toastHelper.toastWithTitleAndColor("Converted successfully!", greenColor);
      Navigator.pop(context, true);
    } else {
      toastHelper.toastWithTitleAndColor("Failed to convert!", redColor);
    }
  }
}
