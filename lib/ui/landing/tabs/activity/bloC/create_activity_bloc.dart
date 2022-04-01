import 'package:flutter/material.dart';
import 'package:salessimplify/helper/bloc_provider.dart';
import 'package:salessimplify/models/ActivitySymbol.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/models/roles_wise_userL_lst.dart';

class CreateActivityBloc extends BlocBase {
  //Final Variable :D
  final BuildContext context;
  //Constructor
  CreateActivityBloc({required this.context});
  bool isProcessing = false;
  ActivitySymbol? activitySymbol;
  String? activityName = '';
  SearchResult? selectedSearch;
  String? selectedPeople;
  DropDownModel? selectedDropDown;
  String? selectedCompany;
  String? selectedLead;
  DateTimeRange? selectedDateRange;
  List<String> attendees = [];
  RoleWiseUser? roleWiseSelectedDropDown;

  List<String> get getAttendees => this.attendees;
  bool get getIsProcessing => this.isProcessing;
  ActivitySymbol? get getActivitySymbol => this.activitySymbol;
  String? get getActivityName => this.activityName;
  SearchResult? get getSelectedSearch => this.selectedSearch;
  get getSelectedDropDown => this.selectedDropDown;
  String? get getSelectedCompany => this.selectedCompany;
  DateTimeRange? get getSelectedDateRange => this.selectedDateRange;
  get getSelectedLead => this.selectedLead;
  RoleWiseUser? get getRoleWiseSelectedDropDown =>
      this.roleWiseSelectedDropDown;

  set setRoleWiseSelectedDropDown(RoleWiseUser? roleWiseSelectedDropDown) =>
      this.roleWiseSelectedDropDown = roleWiseSelectedDropDown;
  set setSelectedLead(selectedLead) => this.selectedLead = selectedLead;
  set setAttendees(List<String> attendees) => this.attendees = attendees;
  set setSelectedDateRange(DateTimeRange? selectedDateRange) =>
      this.selectedDateRange = selectedDateRange;
  set setSelectedCompany(String? selectedCompany) =>
      this.selectedCompany = selectedCompany;

  set setSelectedDropDown(selectedDropDown) =>
      this.selectedDropDown = selectedDropDown;
  set setIsProcessing(bool isProcessing) => this.isProcessing = isProcessing;
  set setActivitySymbol(ActivitySymbol? activitySymbol) =>
      this.activitySymbol = activitySymbol;
  set setActivityName(String? activityName) => this.activityName = activityName;
  set setSelectedSearch(SearchResult? selectedSearch) =>
      this.selectedSearch = selectedSearch;
  @override
  void dispose() {}
}
