import 'package:flutter/material.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/roles_wise_userL_lst.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/widget/role_wise_users.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class RoleWiseUserWidget extends StatelessWidget {
  RoleWiseUser? selectedModel;
  Function handler;
  List<RoleWiseUser> list = [];

  RoleWiseUserWidget(
    this.selectedModel,
    this.handler,
  );

  @override
  Widget build(BuildContext context) {
    list = context.read<Repository>().roleWiseUser;
    if (list.length > 0 && selectedModel == null) {
      handler(list[0]);
    }
    return list.length > 0
        ? RoleWiseUserDropDown(
            list,
            selectedModel ?? list[0],
            handler,
          )
        : Shimmer.fromColors(
            baseColor: grey.withOpacity(0.4),
            highlightColor: white,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 50,
              decoration: BoxDecoration(
                  color: appColor.grey,
                  borderRadius: BorderRadius.circular(4.0)),
            ),
          );

    /*return FutureBuilder(
      future: Repository.getRolesWiseUserList(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? RoleWiseUserDropDown(
                snapshot.data as List<RoleWiseUser>,
                Icons.person,
                selectedModel ?? (snapshot.data as List<RoleWiseUser>)[0],
                handler,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );*/
  }
}
