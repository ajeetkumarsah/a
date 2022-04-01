import 'package:flutter/material.dart';
import 'package:salessimplify/helper/bloc_provider.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/models/dropdownmodel.dart';

class AddDealBloc extends BlocBase {
  //Final Variable :D
  final BuildContext context;

  //Constructor
  AddDealBloc({required this.context});

  List<Stage> stages = [];
  String? stageId;
  String? email;
  String? phone;
  String? pipelineId;
  int? expectedCloseDate;
  List<String> selectedTagsValue = [];
  SearchCompanyNew? selectedCompany;
  String selectedEndDate = '';
  int? endDate;
  DropDownModel? selectedDropDown;
  String? selectedPeople;

  List<Stage> get getStages => this.stages;
  String? get getStageId => this.stageId;
  String? get getPipelineId => this.pipelineId;
  int? get getExpectedCloseDate => this.expectedCloseDate;
  List<String> get getSelectedTagsValue => this.selectedTagsValue;
  SearchCompanyNew? get getSelectedCompany => this.selectedCompany;
  String get getSelectedEndDate => this.selectedEndDate;
  int? get getEndDate => this.endDate;
  DropDownModel? get getSelectedDropDown => this.selectedDropDown;
  String? get getSelectedPeople => this.selectedPeople;
  String? get getEmail => this.email;
  String? get getPhone => this.phone;

  set setStages(List<Stage> stages) => this.stages = stages;
  set setStageId(String? stageId) => this.stageId = stageId;
  set setPipelineId(String? pipelineId) => this.pipelineId = pipelineId;
  set setExpectedCloseDate(int? expectedCloseDate) =>
      this.expectedCloseDate = expectedCloseDate;
  set setSelectedTagsValue(List<String> selectedTagsValue) =>
      this.selectedTagsValue = selectedTagsValue;
  set setSelectedCompany(SearchCompanyNew? selectedCompany) =>
      this.selectedCompany = selectedCompany;
  set setSelectedEndDate(String selectedEndDate) =>
      this.selectedEndDate = selectedEndDate;
  set setEndDate(int? endDate) => this.endDate = endDate;
  set setSelectedDropDown(DropDownModel? selectedDropDown) =>
      this.selectedDropDown = selectedDropDown;
  set setSelectedPeople(String? selectedPeople) =>
      this.selectedPeople = selectedPeople;
  set setEmail(String? email) => this.email = email;
  set setPhone(String? phone) => this.phone = phone;

  @override
  void dispose() {}
}
