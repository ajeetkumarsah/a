import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/CustomSelectModel.dart';
import 'package:salessimplify/repository/Repository.dart';

class SelectOrgWidget extends StatelessWidget {
  CustomSelectModel? selectedOrg;
  final Function handler;

  SelectOrgWidget({
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    selectedOrg = context.watch<Repository>().selectedOrg;
    if (selectedOrg != null) handler(selectedOrg);
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: grey),
          color: white),
      child: Text(
        selectedOrg == null
            ? "Search Organization"
            : "${selectedOrg!.name} selected!",
        style: TextStyle(color: black),
      ),
    );
  }
}
