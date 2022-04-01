import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/landing/tabs/contact/widgets/general_widget.dart';
import 'package:salessimplify/ui/widgetHelper/custom_alertdialog.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

class PeopleDetails extends StatefulWidget {
  static String ROUTE_LEAD_DETAILS = "route/PeopleDetails";

  @override
  _PeopleDetailsState createState() => _PeopleDetailsState();
}

class _PeopleDetailsState extends State<PeopleDetails> {
  bool isUpdated = false;
  confirmDelete(Map<String, dynamic> params) {
    var baseDialog = BaseAlertDialog(
        title: "Are you sure?",
        content: "Do you want to delete this contact?",
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
        appBar: CustomAppBar(
          title: args["name"]!,
          leading: IconButton(
            onPressed: () => Navigator.pop(context, isUpdated),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, isUpdated);
            return isUpdated;
          },
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 28.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [blueColor, deepblue],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(12.0)),
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Center(
                                    child: Icon(
                                      Boxicons.bx_user,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  args["name"] ?? 'Alex',
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
                                title: Text(args["company"] ?? 'Company',
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
                                title: Text(
                                    args["email"] ?? 'example@gmail.com',
                                    style: TextStyle(color: white)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.55,
                            child:
                                GeneralWidget(args: args, isUpdated: isUpdated),
                            // DefaultTabController(
                            //   length: 3,
                            //   child: Column(
                            //     children: <Widget>[
                            //       Container(
                            //         constraints: BoxConstraints.expand(height: 50),
                            //         child: TabBar(
                            //           labelStyle: TextStyle(
                            //               fontSize: 18, fontWeight: FontWeight.w400),
                            //           labelColor: Colors.blue,
                            //           unselectedLabelColor: Colors.grey,
                            //           indicatorWeight: 3,
                            //           tabs: [
                            //             Tab(text: "General"),
                            //             Tab(text: "Time Line"),
                            //             Tab(text: "Deals"),
                            //           ],
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: TabBarView(
                            //           children: [
                            //             GeneralWidget(args: args),
                            //             emptyListHelper.getEmptyList(
                            //                 EmptyListHelper.timeLineList, context),
                            //             emptyListHelper.getEmptyList(
                            //                 EmptyListHelper.dealsEmptyList, context),
                            //           ],
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  deleteRecord(BuildContext context, Map<String, dynamic> params) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await context.read<Repository>().deletePeople(params);
    pr.hide().then((isHidden) {
      print(isHidden);
    });

    if (isSuccess is bool && isSuccess) {
      toastHelper.toastWithTitleAndColor("Deleted successfully!", greenColor);

      Navigator.of(context).pop();
    } else {
      toastHelper.toastWithTitleAndColor("Failed to delete!", redColor);
    }
  }
}
