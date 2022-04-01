import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/models/CustomSelectModel.dart';
import 'package:salessimplify/repository/Repository.dart';

class SelectPersonWidget extends StatelessWidget {
  CustomSelectModel? selectedPerson;
  final Function handler;

  SelectPersonWidget({
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    selectedPerson = context.watch<Repository>().selectedPerson;
    if (selectedPerson != null) handler(selectedPerson);
    return Container(
      margin: EdgeInsets.all(14.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color:grey),
          color: white),
      child: Text(
        selectedPerson == null
            ? "Search Person"
            : "${selectedPerson!.name} selected!",
        style: TextStyle(color: black),
      ),
    );
  }
}
