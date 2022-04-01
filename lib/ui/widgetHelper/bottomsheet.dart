import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/ActivitySymbol.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/PipelineModel.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/models/activity_details_model.dart';
import 'package:salessimplify/models/companymodel.dart';
import 'package:salessimplify/models/deal_product.dart';
import 'package:salessimplify/models/dropdown_option.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/models/lead_details.list.dart';
import 'package:salessimplify/models/popupdetails.dart';
import 'package:salessimplify/models/roles_wise_userL_lst.dart';
import 'package:salessimplify/models/search_product.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/activity/ActivityTypeList.dart';
import 'package:salessimplify/ui/landing/tabs/activity/role_wise_users.dart';
import 'package:salessimplify/ui/landing/tabs/deal/Pipelines.dart';
import 'package:salessimplify/ui/landing/tabs/deal/adddeal/StageList.dart';
import 'package:salessimplify/ui/widgetHelper/custom_tag.dart';
import 'package:salessimplify/ui/widgetHelper/dotted_button.dart';
import 'package:salessimplify/ui/widgetHelper/people_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/product_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/save_button.dart';
import 'package:salessimplify/ui/widgetHelper/searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import 'beauty_text_form_field.dart';
import 'bottomsheet_header.dart';
import 'custom_form_button.dart';
import 'deal_searchable_dropdown.dart';
import 'lead_searchable_dropdown.dart';
import 'package:salessimplify/package/date_range_picker.dart'
    as DateRangePicker;

class CustomBottomSheet {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String value = "";
  Map<String, dynamic> params = {};
  Function? handler;
  String id = "";
  var f = DateFormat('dd MMM,yy');
  // SearchCompanyNew? selectedCompany;
  CustomBottomSheet({this.handler, required this.id});
  List<String> selectedTagsValue = [], emails = [];
  final TextEditingController _searchBarController = TextEditingController();
  List<Option> selectedTags = [], filteredTags = [], allTags = [];
  String countryCode = '+91';
  bool orgSelected = false;
  static List<SearchCompanyNew> selectedCompany = [], allCompanies = [];
  final TextEditingController _companySearchBarController =
      TextEditingController();
  bool isSearching = false;
  late int phone;

  //shortActivity
  // late FocusNode activityNameFocusNode;

  DateTimeRange? selectedDateRange;
  DateTime dateNow = DateTime.now();
  int dateType = 0;
  String selectedEndDate = '';
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  //shortActivity

  final TextEditingController _leadSearchBarController =
      TextEditingController();
  final TextEditingController _peopleSearchBarController =
      TextEditingController();
  final TextEditingController _dealSearchBarController =
      TextEditingController();

  List<SearchLeadNew> selectedLead = [], allLeads = [];
  List<SearchPeopleNew> selectedPeople = [], allPeoples = [];
  List<SearchResult> selectedDeal = [], allDeals = [];
  RoleWiseUser? roleWiseSelectedDropDown;
  List<Stage>? stages;
  Future<String?> contactBottomDialog(
      BuildContext context, PopupDetailsList popupDetailsList) {
    if (popupDetailsList.fieldInputType ==
        FieldInputType.ORG_SELECT.getType()) {
      if (popupDetailsList.value is String) {
        if (popupDetailsList.value == '') {
          selectedCompany = [];
        } else
          selectedCompany = [
            SearchCompanyNew(
                name: popupDetailsList.value,
                id: '',
                createdAddress: '',
                createdAt: '',
                email: [],
                owner: '',
                phone: [],
                website: '')
          ];
      } else {
        selectedCompany = [
          SearchCompanyNew(
            name: popupDetailsList.value['name'],
            id: popupDetailsList.value['_id'],
            createdAddress: '',
            createdAt: '',
            email: [],
            owner: '',
            phone: [],
            website: '',
          )
        ];
      }
    }

    if (popupDetailsList.fieldInputType ==
        FieldInputType.TAG_MULTI_SELECT.getType()) {
      for (var i = 0; i < popupDetailsList.valueWithColor.length; i++) {
        allSelectedTags.add(Option(
            colorCode: popupDetailsList.valueWithColor[i]["colorCode"],
            name: popupDetailsList.valueWithColor[i]["name"],
            label: popupDetailsList.valueWithColor[i]["label"],
            value: popupDetailsList.valueWithColor[i]["value"]));
      }
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          popupDetailsList.options.forEach((element) {
            allTags.add(Option(
                label: element.label,
                value: element.value,
                colorCode: element.colorCode,
                name: element.name != null ? element.name : element.label));
          });
          if (popupDetailsList.fieldInputType ==
              FieldInputType.TAG_MULTI_SELECT.getType()) {
            allTags.forEach((element) {
              for (var i = 0; i < allSelectedTags.length; i++) {
                if (element.value == allSelectedTags[i].value) {
                  selectedTags.add(element);
                }
              }
            });
          }
          if (popupDetailsList.fieldInputType ==
              FieldInputType.LEAD_SELECT.getType()) {
            if (popupDetailsList.value is String) {
              if (popupDetailsList.value == '') {
                selectedCompany = [];
              } else
                selectedLead = [
                  SearchLeadNew(
                      company: CompanyModel(name: ''),
                      email: [],
                      id: '',
                      name: popupDetailsList.value,
                      phone: [])
                ];
            } else {
              selectedLead = [
                SearchLeadNew(
                    company: CompanyModel(name: ''),
                    email: [],
                    id: popupDetailsList.value['_id'],
                    name: popupDetailsList.value['name'],
                    phone: [])
              ];
            }
          }

          if (popupDetailsList.fieldInputType ==
              FieldInputType.DEAL_SELECT.getType()) {
            if (popupDetailsList.value is String) {
              if (popupDetailsList.value == '') {
                selectedDeal = [];
              } else
                selectedDeal = [SearchResult('', popupDetailsList.value)];
            } else {
              selectedDeal = [
                SearchResult(
                  popupDetailsList.value['_id'],
                  popupDetailsList.value['name'],
                )
              ];
            }
          }

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              context.read<Repository>().getRolesWiseUserList();
              stages = context.watch<Repository>().stages;
              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, popupDetailsList.fieldName),
                      popupDetailsList.fieldInputType ==
                              FieldInputType.DATE_TIME.getType()
                          ? SizedBox()
                          : popupDetailsList.fieldInputType ==
                                  FieldInputType.TAG_MULTI_SELECT.getType()
                              ? Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        top: 4.0,
                                        right: 12.0,
                                        bottom: 6.0),
                                    child: CustomTag(
                                      allTags: allTags,
                                      selectedTags: selectedTags,
                                    ),
                                  ),
                                )
                              : popupDetailsList.fieldInputType ==
                                      FieldInputType.OWNER_SELECT.getType()
                                  ? RoleWiseUserWidget(roleWiseSelectedDropDown,
                                      onUsersDropDownSelect)
                                  : popupDetailsList.fieldInputType ==
                                          FieldInputType.ORG_SELECT.getType()
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SearchableDropdown(
                                              key: const ValueKey('Company'),
                                              searchBarTitle: 'Search Company',
                                              searchBarController:
                                                  _companySearchBarController,
                                              onSearchTextChanged:
                                                  (value) async {
                                                setState(() {
                                                  isSearching = true;
                                                });
                                                allCompanies = await Repository
                                                    .getCompanyNewSearch(value);
                                                setState(() {
                                                  isSearching = false;
                                                });
                                              },
                                              searching: isSearching,
                                              onSelected: () {
                                                orgSelected = true;
                                                params = {
                                                  popupDetailsList.apiKeyName:
                                                      selectedCompany[0].id,
                                                };
                                              },
                                              selected: selectedCompany,
                                              all: allCompanies),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 12.0,
                                                top: 4.0,
                                                right: 12.0,
                                                bottom: 6.0),
                                            child: Form(
                                              key: _formKey,
                                              child: BeautyTextfield(
                                                width: double.maxFinite,
                                                height: 50,
                                                initialSelection: (popupDetailsList
                                                            .fieldInputType ==
                                                        FieldInputType
                                                            .MULTI_PHONE_INPUT
                                                            .getType())
                                                    ? '+${popupDetailsList.value != null && popupDetailsList.value != '' ? popupDetailsList.value.toString().substring(0, 2) : 91}'
                                                    : '+91',

                                                countryCode: (popupDetailsList
                                                        .fieldInputType ==
                                                    FieldInputType
                                                        .MULTI_PHONE_INPUT
                                                        .getType()),
                                                countryOnChanged:
                                                    (CountryCode value) {
                                                  if (popupDetailsList
                                                          .fieldInputType ==
                                                      FieldInputType
                                                          .MULTI_PHONE_INPUT
                                                          .getType())
                                                    countryCode =
                                                        value.dialCode!;
                                                  phone = int.parse(countryCode +
                                                      popupDetailsList.value
                                                          .toString()
                                                          .substring(
                                                              2,
                                                              popupDetailsList
                                                                  .value
                                                                  .toString()
                                                                  .length));
                                                  setState(() {
                                                    params = {
                                                      popupDetailsList
                                                          .apiKeyName: phone,
                                                    };
                                                  });
                                                  _formKey.currentState!
                                                      .validate();
                                                },

                                                // autofocus: false,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                inputType: popupDetailsList
                                                            .fieldInputType ==
                                                        FieldInputType
                                                            .MULTI_PHONE_INPUT
                                                            .getType()
                                                    ? TextInputType.number
                                                    : popupDetailsList
                                                                .fieldInputType ==
                                                            FieldInputType
                                                                .NUMBER
                                                                .getType()
                                                        ? TextInputType.number
                                                        : popupDetailsList
                                                                    .fieldInputType ==
                                                                FieldInputType
                                                                    .MULTI_EMAIL_INPUT
                                                                    .getType()
                                                            ? TextInputType
                                                                .emailAddress
                                                            : TextInputType
                                                                .text,
                                                placeholder:
                                                    'Enter ${popupDetailsList.fieldName} ',
                                                initialValue: (popupDetailsList
                                                            .fieldInputType ==
                                                        FieldInputType
                                                            .MULTI_PHONE_INPUT
                                                            .getType())
                                                    ? phoneInitValue(
                                                        popupDetailsList.value)
                                                    : popupDetailsList.value
                                                            is List
                                                        ? popupDetailsList
                                                            .value[0]
                                                            .toString()
                                                        : popupDetailsList.value
                                                            .toString(),
                                                onChanged: (String value) {
                                                  if (popupDetailsList
                                                          .fieldInputType ==
                                                      FieldInputType
                                                          .MULTI_PHONE_INPUT
                                                          .getType()) {
                                                    if (popupDetailsList
                                                                .value !=
                                                            null &&
                                                        popupDetailsList
                                                                .value !=
                                                            '') {
                                                      String phoneCode =
                                                          popupDetailsList.value
                                                              .toString()
                                                              .substring(0, 2);
                                                    }

                                                    if (value != null &&
                                                        countryCode != null)
                                                      phone = int.parse(
                                                          countryCode + value);
                                                    setState(() {
                                                      params = {
                                                        popupDetailsList
                                                            .apiKeyName: phone,
                                                      };
                                                    });
                                                    _formKey.currentState!
                                                        .validate();
                                                  } else {
                                                    if (value.isNotEmpty)
                                                      setState(() {
                                                        params = {
                                                          popupDetailsList
                                                                  .apiKeyName:
                                                              value,
                                                        };
                                                      });
                                                    _formKey.currentState!
                                                        .validate();
                                                  }
                                                },
                                                isRequired: isError,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      isError = true;
                                                    });

                                                    return null;
                                                  } else {
                                                    setState(() {
                                                      isError = false;
                                                    });
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                      SizedBox(height: 8.0),
                      Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            left: 16,
                            right: 16,
                          ),
                          child: SaveButton(
                            title: 'Update',
                            onTap: () {
                              if (popupDetailsList.fieldInputType ==
                                  FieldInputType.ORG_SELECT.getType()) {
                                if (orgSelected) {
                                  updatePeople(context, id, params, true);
                                } else {
                                  toastHelper.toastWithTitleAndColor(
                                      "Select company!", black);
                                }
                              } else if (popupDetailsList.fieldInputType ==
                                  FieldInputType.TAG_MULTI_SELECT.getType()) {
                                if (selectedTags != null &&
                                    selectedTags.isNotEmpty) {
                                  selectedTags.forEach(
                                      (v) => selectedTagsValue.add(v.value));

                                  params = {
                                    popupDetailsList.apiKeyName:
                                        selectedTagsValue,
                                  };
                                  updatePeople(context, id, params, false);
                                } else {
                                  toastHelper.toastWithTitleAndColor(
                                      "Select tags!", black);
                                }
                              } else if (_formKey.currentState!.validate()) {
                                updatePeople(
                                    context,
                                    id,
                                    params,
                                    popupDetailsList.fieldName == 'Name' ||
                                            popupDetailsList.fieldName ==
                                                'Email'
                                        ? true
                                        : false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Enter value!", black);
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.88,
                          )),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  String phoneInitValue(dynamic value) {
    return value != ''
        ? value is String
            ? value.toString().substring(2, value.toString().length)
            : value[0].toString().substring(2, value[0].toString().length)
        : '$value';
  }

  onUsersDropDownSelect(RoleWiseUser value) {
    roleWiseSelectedDropDown = value;
  }

  int count = 0;
  updatePeople(BuildContext context, String id, Map<String, dynamic> params,
      bool name) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess =
        await Repository.getInstance().updatePeopleDetails(params, id);
    pr.hide();

    if (isSuccess) {
      Timer(Duration(seconds: 1), () {
        toastHelper.toastWithTitleAndColor("Successfully Updated ", greenColor);
      });

      if (handler != null) {
        handler!();
      }
      Navigator.pop(context);
      if (name) {
        Navigator.pop(context, true);
      }
    } else {
      toastHelper.toastWithTitleAndColor("Failed to Update ", redColor);
    }
  }

  Iterable<Widget> get companyPosition sync* {
    for (Option option in allTags) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: grey,
          // avatar: CircleAvatar(
          //   backgroundColor: Colors.cyan,
          //   child: Text(
          //     company.name[0].toUpperCase(),
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          label: Text(
            option.name,
          ),
          selected: filteredTags.contains(option.name),
          // selectedColor: Colors.purpleAccent,
          onSelected: (bool selected) {
            if (selected) {
              filteredTags.add(option);
            } else {
              filteredTags.removeWhere((Option name) {
                return name == option;
              });
            }
          },
        ),
      );
    }
  }

  Future<String?> companyBottomDialog(
      BuildContext context, PopupDetailsList popupDetailsList) {
    if (popupDetailsList.fieldInputType ==
        FieldInputType.TAG_MULTI_SELECT.getType()) {
      for (var i = 0; i < popupDetailsList.valueWithColor.length; i++) {
        allSelectedTags.add(Option(
            colorCode: popupDetailsList.valueWithColor[i]["colorCode"],
            name: popupDetailsList.valueWithColor[i]["name"],
            label: popupDetailsList.valueWithColor[i]["label"],
            value: popupDetailsList.valueWithColor[i]["value"]));
      }
    }
    if (popupDetailsList.fieldInputType ==
        FieldInputType.LEAD_SELECT.getType()) {
      if (popupDetailsList.value is String) {
        if (popupDetailsList.value == '') {
          selectedCompany = [];
        } else
          selectedLead = [
            SearchLeadNew(
                company: CompanyModel(name: ''),
                email: [],
                id: '',
                name: popupDetailsList.value,
                phone: [])
          ];
      } else {
        selectedLead = [
          SearchLeadNew(
              company: CompanyModel(name: ''),
              email: [],
              id: popupDetailsList.value['_id'],
              name: popupDetailsList.value['name'],
              phone: [])
        ];
      }
    }

    if (popupDetailsList.fieldInputType ==
        FieldInputType.DEAL_SELECT.getType()) {
      if (popupDetailsList.value is String) {
        if (popupDetailsList.value == '') {
          selectedDeal = [];
        } else
          selectedDeal = [SearchResult('', popupDetailsList.value)];
      } else {
        selectedDeal = [
          SearchResult(
            popupDetailsList.value['_id'],
            popupDetailsList.value['name'],
          )
        ];
      }
    }
    if (popupDetailsList.fieldInputType ==
        FieldInputType.PEOPLE_SELECT.getType()) {
      if (popupDetailsList.value is String) {
        if (popupDetailsList.value == '') {
          selectedPeople = [];
        } else
          selectedPeople = [
            SearchPeopleNew('', popupDetailsList.value, [], []),
          ];
      } else {
        selectedPeople = [
          SearchPeopleNew(popupDetailsList.value['_id'],
              popupDetailsList.value['name'], [], [])
        ];
      }
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              allTags = popupDetailsList.options;
              if (popupDetailsList.fieldInputType ==
                  FieldInputType.TAG_MULTI_SELECT.getType()) {
                allTags.forEach((element) {
                  for (var i = 0; i < allSelectedTags.length; i++) {
                    if (element.value == allSelectedTags[i].value) {
                      selectedTags.add(element);
                    }
                  }
                });
              }

              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    bottomSheetHeader(context, popupDetailsList.fieldName),
                    popupDetailsList.fieldInputType ==
                            FieldInputType.DATE_TIME.getType()
                        ? SizedBox()
                        : popupDetailsList.fieldInputType ==
                                FieldInputType.TAG_MULTI_SELECT.getType()
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 12.0,
                                    top: 4.0,
                                    right: 12.0,
                                    bottom: 6.0),
                                child: CustomTag(
                                  allTags: allTags,
                                  selectedTags: selectedTags,
                                ),
                              )
                            : popupDetailsList.fieldInputType ==
                                    FieldInputType.ORG_SELECT.getType()
                                ? SearchableDropdown(
                                    key: const ValueKey('Company'),
                                    searchBarTitle: 'Search Company',
                                    searchBarController:
                                        _companySearchBarController,
                                    onSearchTextChanged: (value) async {
                                      setState(() {
                                        isSearching = true;
                                      });
                                      allCompanies =
                                          await Repository.getCompanyNewSearch(
                                              value);
                                      setState(() {
                                        isSearching = false;
                                      });
                                    },
                                    searching: isSearching,
                                    onSelected: () {
                                      orgSelected = true;
                                      params = {
                                        popupDetailsList.apiKeyName:
                                            selectedCompany[0].id,
                                      };
                                    },
                                    selected: selectedCompany,
                                    all: allCompanies)
                                : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 12.0,
                                          top: 4.0,
                                          right: 12.0,
                                          bottom: 6.0),
                                      child: Form(
                                        key: _formKey,
                                        child: BeautyTextfield(
                                          width: double.maxFinite,
                                          height: 50,
                                          duration: Duration(milliseconds: 300),
                                          initialSelection: (popupDetailsList
                                                      .fieldInputType ==
                                                  FieldInputType
                                                      .MULTI_PHONE_INPUT
                                                      .getType())
                                              ? '+${popupDetailsList.value != null && popupDetailsList.value != '' ? popupDetailsList.value.toString().substring(0, 2) : 91}'
                                              : '+91',
                                          countryCode: (popupDetailsList
                                                  .fieldInputType ==
                                              FieldInputType.MULTI_PHONE_INPUT
                                                  .getType()),
                                          countryOnChanged:
                                              (CountryCode value) {
                                            if (popupDetailsList
                                                    .fieldInputType ==
                                                FieldInputType.MULTI_PHONE_INPUT
                                                    .getType())
                                              countryCode = value.dialCode!;
                                            phone = int.parse(countryCode +
                                                popupDetailsList.value
                                                    .toString()
                                                    .substring(
                                                        2,
                                                        popupDetailsList.value
                                                            .toString()
                                                            .length));
                                            setState(() {
                                              params = {
                                                popupDetailsList.apiKeyName:
                                                    phone,
                                              };
                                            });
                                            _formKey.currentState!.validate();
                                          },
                                          inputType: popupDetailsList
                                                      .fieldInputType ==
                                                  FieldInputType
                                                      .MULTI_PHONE_INPUT
                                                      .getType()
                                              ? TextInputType.number
                                              : popupDetailsList
                                                          .fieldInputType ==
                                                      FieldInputType.NUMBER
                                                          .getType()
                                                  ? TextInputType.number
                                                  : popupDetailsList
                                                              .fieldInputType ==
                                                          FieldInputType
                                                              .MULTI_EMAIL_INPUT
                                                              .getType()
                                                      ? TextInputType
                                                          .emailAddress
                                                      : TextInputType.text,
                                          placeholder:
                                              'Enter ${popupDetailsList.fieldName}',
                                          initialValue: (popupDetailsList
                                                      .fieldInputType ==
                                                  FieldInputType
                                                      .MULTI_PHONE_INPUT
                                                      .getType())
                                              ? phoneInitValue(
                                                  popupDetailsList.value)
                                              : popupDetailsList.value is List
                                                  ? popupDetailsList.value[0]
                                                      .toString()
                                                  : popupDetailsList.value
                                                      .toString(),
                                          onChanged: (String value) {
                                            if (popupDetailsList
                                                    .fieldInputType ==
                                                FieldInputType.MULTI_PHONE_INPUT
                                                    .getType()) {
                                              if (value != null &&
                                                  countryCode != null)
                                                phone = int.parse(
                                                    countryCode + value);
                                              setState(() {
                                                params = {
                                                  popupDetailsList.apiKeyName:
                                                      phone,
                                                };
                                              });
                                              _formKey.currentState!.validate();
                                            } else {
                                              setState(() {
                                                params = {
                                                  popupDetailsList.apiKeyName:
                                                      value,
                                                };
                                              });
                                              _formKey.currentState!.validate();
                                            }
                                          },
                                          isRequired: isError,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                isError = true;
                                              });

                                              return null;
                                            } else {
                                              setState(() {
                                                isError = false;
                                              });
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                      ),
                      child: SaveButton(
                        title: 'Update',
                        onTap: () {
                          if (popupDetailsList.fieldInputType ==
                              FieldInputType.ORG_SELECT.getType()) {
                            if (orgSelected) {
                              updateCompany(context, id, params, true);
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select company!", black);
                            }
                          } else if (popupDetailsList.fieldInputType ==
                              FieldInputType.TAG_MULTI_SELECT.getType()) {
                            // ignore: unnecessary_null_comparison
                            if (selectedTags != null &&
                                selectedTags.isNotEmpty) {
                              selectedTags.forEach(
                                  (v) => selectedTagsValue.add(v.value));
                              params = {
                                popupDetailsList.apiKeyName: selectedTagsValue
                              };
                              updateCompany(context, id, params, false);
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select tags!", black);
                            }
                          } else if (_formKey.currentState!.validate()) {
                            updateCompany(
                                context,
                                id,
                                params,
                                popupDetailsList.fieldName ==
                                            "Organization Name" ||
                                        popupDetailsList.fieldName == "Website"
                                    ? true
                                    : false);
                          } else {
                            toastHelper.toastWithTitleAndColor(
                                "Enter value!", black);
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.88,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          );
        });
  }

  updateCompany(BuildContext context, String id, Map<String, dynamic> params,
      bool name) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess =
        await Repository.getInstance().updateCompanyDetails(params, id);
    pr.hide();

    if (isSuccess) {
      toastHelper.toastWithTitleAndColor("Successfully Updated ", greenColor);

      if (handler != null) {
        handler!();
      }
      Navigator.pop(context);
      if (name) {
        Navigator.pop(context, true);
      }
    } else {
      toastHelper.toastWithTitleAndColor("Failed to Update ", redColor);
    }
  }

  List<Option> allSelectedTags = [];
  Future<String?> leadBottomDialog(
      BuildContext context, LeadDetailsList leadDetailsList) {
    if (leadDetailsList.fieldInputType == FieldInputType.ORG_SELECT.getType()) {
      if (leadDetailsList.value is String) {
        if (leadDetailsList.value == '') {
          selectedCompany = [];
        } else
          selectedCompany = [
            SearchCompanyNew(
                name: leadDetailsList.value,
                id: '',
                createdAddress: '',
                createdAt: '',
                email: [],
                owner: '',
                phone: [],
                website: '')
          ];
      } else {
        selectedCompany = [
          SearchCompanyNew(
              name: leadDetailsList.value['name'],
              id: leadDetailsList.value['_id'],
              createdAddress: '',
              createdAt: '',
              email: [],
              owner: '',
              phone: [],
              website: '')
        ];
      }
    }
    if (leadDetailsList.fieldInputType ==
        FieldInputType.TAG_MULTI_SELECT.getType()) {
      for (var i = 0; i < leadDetailsList.valueWithColor.length; i++) {
        allSelectedTags.add(Option(
            colorCode: leadDetailsList.valueWithColor[i]["colorCode"],
            name: leadDetailsList.valueWithColor[i]["name"],
            label: leadDetailsList.valueWithColor[i]["label"],
            value: leadDetailsList.valueWithColor[i]["value"]));
      }
    }

    if (leadDetailsList.fieldInputType ==
        FieldInputType.DEAL_SELECT.getType()) {
      if (leadDetailsList.value is String) {
        if (leadDetailsList.value == '') {
          selectedDeal = [];
        } else
          selectedDeal = [SearchResult('', leadDetailsList.value)];
      } else {
        selectedDeal = [
          SearchResult(
            leadDetailsList.value['_id'],
            leadDetailsList.value['name'],
          )
        ];
      }
    }
    if (leadDetailsList.fieldInputType ==
        FieldInputType.PEOPLE_SELECT.getType()) {
      if (leadDetailsList.value is String) {
        if (leadDetailsList.value == '') {
          selectedPeople = [];
        } else
          selectedPeople = [
            SearchPeopleNew(
              '',
              leadDetailsList.value,
              [],
              [],
            ),
          ];
      } else {
        selectedPeople = [
          SearchPeopleNew(
            leadDetailsList.value['_id'],
            leadDetailsList.value['name'],
            [],
            [],
          )
        ];
      }
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              allTags = leadDetailsList.options!.cast<Option>();
              if (leadDetailsList.fieldInputType ==
                  FieldInputType.TAG_MULTI_SELECT.getType()) {
                allTags.forEach((element) {
                  for (var i = 0; i < allSelectedTags.length; i++) {
                    if (element.value == allSelectedTags[i].value) {
                      selectedTags.add(element);
                    }
                  }
                });
              }

              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    bottomSheetHeader(context, leadDetailsList.fieldName!),
                    leadDetailsList.fieldInputType ==
                            FieldInputType.DATE_TIME.getType()
                        ? SizedBox()
                        : leadDetailsList.fieldInputType ==
                                FieldInputType.TAG_MULTI_SELECT.getType()
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 12.0,
                                    top: 4.0,
                                    right: 12.0,
                                    bottom: 6.0),
                                child: CustomTag(
                                  allTags: allTags,
                                  selectedTags: selectedTags,
                                ),
                              )
                            : leadDetailsList.fieldInputType ==
                                    FieldInputType.ORG_SELECT.getType()
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SearchableDropdown(
                                        key: const ValueKey('Company'),
                                        searchBarTitle: 'Search Company',
                                        searchBarController:
                                            _companySearchBarController,
                                        onSearchTextChanged: (value) async {
                                          setState(() {
                                            isSearching = true;
                                          });
                                          allCompanies = await Repository
                                              .getCompanyNewSearch(value);
                                          setState(() {
                                            isSearching = false;
                                          });
                                        },
                                        searching: isSearching,
                                        onSelected: () {
                                          orgSelected = true;
                                          params = {
                                            leadDetailsList.apiKeyName!:
                                                selectedCompany[0].id,
                                          };
                                        },
                                        selected: selectedCompany,
                                        all: allCompanies),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 12.0,
                                          top: 4.0,
                                          right: 12.0,
                                          bottom: 6.0),
                                      child: Form(
                                        key: _formKey,
                                        child: BeautyTextfield(
                                          width: double.maxFinite,
                                          height: 50,
                                          duration: Duration(milliseconds: 300),
                                          inputType: leadDetailsList
                                                      .fieldInputType ==
                                                  FieldInputType
                                                      .MULTI_PHONE_INPUT
                                                      .getType()
                                              ? TextInputType.number
                                              : leadDetailsList
                                                          .fieldInputType ==
                                                      FieldInputType.NUMBER
                                                          .getType()
                                                  ? TextInputType.number
                                                  : leadDetailsList
                                                              .fieldInputType ==
                                                          FieldInputType
                                                              .MULTI_EMAIL_INPUT
                                                              .getType()
                                                      ? TextInputType
                                                          .emailAddress
                                                      : TextInputType.text,
                                          placeholder:
                                              'Enter ${leadDetailsList.fieldName} ',
                                          initialValue: (leadDetailsList
                                                      .fieldInputType ==
                                                  FieldInputType
                                                      .MULTI_PHONE_INPUT
                                                      .getType())
                                              ? phoneInitValue(
                                                  leadDetailsList.value)
                                              : leadDetailsList.value is List
                                                  ? leadDetailsList.value[0]
                                                      .toString()
                                                  : leadDetailsList.value
                                                      .toString(),
                                          initialSelection: (leadDetailsList
                                                      .fieldInputType ==
                                                  FieldInputType
                                                      .MULTI_PHONE_INPUT
                                                      .getType())
                                              ? '+${leadDetailsList.value != null && leadDetailsList.value != '' ? leadDetailsList.value.toString().substring(0, 2) : 91}'
                                              : '+91',
                                          countryCode: (leadDetailsList
                                                  .fieldInputType ==
                                              FieldInputType.MULTI_PHONE_INPUT
                                                  .getType()),
                                          countryOnChanged:
                                              (CountryCode value) {
                                            if (leadDetailsList
                                                    .fieldInputType ==
                                                FieldInputType.MULTI_PHONE_INPUT
                                                    .getType())
                                              countryCode = value.dialCode!;
                                            phone = int.parse(countryCode +
                                                leadDetailsList.value
                                                    .toString()
                                                    .substring(
                                                        2,
                                                        leadDetailsList.value
                                                            .toString()
                                                            .length));
                                            setState(() {
                                              params = {
                                                leadDetailsList.apiKeyName!:
                                                    phone,
                                              };
                                            });
                                            _formKey.currentState!.validate();
                                          },
                                          onChanged: (String value) {
                                            if (leadDetailsList
                                                    .fieldInputType ==
                                                FieldInputType.MULTI_PHONE_INPUT
                                                    .getType()) {
                                              if (value != null &&
                                                  countryCode != null)
                                                phone = int.parse(
                                                    countryCode + value);
                                              setState(() {
                                                params = {
                                                  leadDetailsList.apiKeyName!:
                                                      phone,
                                                };
                                              });
                                              _formKey.currentState!.validate();
                                            } else {
                                              setState(() {
                                                params = {
                                                  leadDetailsList.apiKeyName!:
                                                      value,
                                                };
                                              });
                                              _formKey.currentState!.validate();
                                            }
                                          },
                                          isRequired: isError,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                isError = true;
                                              });

                                              return null;
                                            } else {
                                              setState(() {
                                                isError = false;
                                              });
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                      ),
                      child: SaveButton(
                        title: 'Update',
                        onTap: () {
                          if (leadDetailsList.fieldInputType ==
                              FieldInputType.ORG_SELECT.getType()) {
                            if (orgSelected) {
                              updateLead(context, id, params, true);
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select company", black);
                            }
                          } else if (leadDetailsList.fieldInputType ==
                              FieldInputType.TAG_MULTI_SELECT.getType()) {
                            if (selectedTags != null &&
                                selectedTags.isNotEmpty) {
                              selectedTags.forEach(
                                  (v) => selectedTagsValue.add(v.value));
                              params["tags"] = selectedTagsValue;
                              updateLead(context, id, params, false);
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select tags", black);
                            }
                          } else if (_formKey.currentState!.validate()) {
                            updateLead(
                                context,
                                id,
                                params,
                                leadDetailsList.fieldName == "Name" ||
                                        leadDetailsList.fieldName == "Email"
                                    ? true
                                    : false);
                          } else {
                            toastHelper.toastWithTitleAndColor(
                                "Enter value", black);
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.88,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          );
        });
  }

  onDropDownClicked(Option option) {
    params["tags"] = option.label;
  }

  onDatePickerSelected(DateTimeRange dateTimeRange) {
    selectedDateRange = dateTimeRange;
  }

  updateLead(BuildContext context, String id, Map<String, dynamic> params,
      bool name) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess =
        await Repository.getInstance().updateLeadDetails(params, id);
    pr.hide();

    if (isSuccess) {
      toastHelper.toastWithTitleAndColor("Successfully Updated ", greenColor);
      if (handler != null) {
        handler!();
      }
      Navigator.pop(context);
      if (name) {
        Navigator.pop(context, true);
      }
    } else {
      toastHelper.toastWithTitleAndColor("Failed to Update ", redColor);
    }
  }

  Future<String?> convertLeadsBottomDialog(
      {required BuildContext context,
      required Function() onTap,
      required List<String> reasons}) {
    String _selectedReason = reasons[0];
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: new BoxDecoration(
                  color: white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(8.0),
                      topRight: const Radius.circular(8.0))),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 0.0, right: 12.0, bottom: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Convert To Junk',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close))
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 4.0, right: 16.0, bottom: 6.0),
                      child: Text(
                        'Are you sure want to convert in Junk?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        'Select lost reason',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Select lost reason'),
                            value: _selectedReason,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedReason = newValue!;
                              });
                            },
                            items: reasons.map((reason) {
                              return DropdownMenuItem(
                                child: new Text(reason),
                                value: reason,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      child: BeautyTextfield(
                        width: double.maxFinite,
                        height: 50,
                        duration: Duration(milliseconds: 300),
                        inputType: TextInputType.text,
                        placeholder: "Comments",
                        maxLines: 5,
                        onChanged: (String s) {
                          // value = s;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16,
                      right: 16,
                    ),
                    child: SaveButton(
                      onTap: onTap,
                      title: 'Convert',
                      color: yellowColor,
                      color1: yellowColor,
                      width: MediaQuery.of(context).size.width * 0.88,
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<String?> settingsBottomDialog(
          BuildContext context, String title, String value) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, title),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 4.0, right: 12.0, bottom: 6.0),
                          child: Form(
                            key: _formKey,
                            child: BeautyTextfield(
                              width: double.maxFinite,
                              height: 50,
                              duration: Duration(milliseconds: 300),
                              inputType: TextInputType.text,
                              placeholder: 'Enter $title',
                              initialValue: value,
                              onChanged: (String s) {
                                value = s;
                                setState(() {
                                  params = {};
                                });
                              },
                              isRequired: isError,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    isError = true;
                                  });

                                  return null;
                                } else {
                                  setState(() {
                                    isError = false;
                                  });
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            left: 16,
                            right: 16,
                          ),
                          child: SaveButton(
                            title: 'Update',
                            onTap: () {
                              // updatePeople(context, id, params);
                              toastHelper.toastWithTitleAndColor(
                                  'API is not available!', black);

                              Navigator.pop(context);
                            },
                          )),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  Future<String?> imageBottomDialog(BuildContext context,
          Function() cameraOnTap, Function() galleryOnTap) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0.0, right: 12.0, bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Profile photo',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          right: 16,
                        ),
                        child: Wrap(
                          direction: Axis.horizontal,
                          // spacing: 12.0,
                          children: [
                            SizedBox(width: 20),
                            _getImage(onTap: cameraOnTap, title: 'Camera'),
                            SizedBox(width: 30),
                            _getImage(onTap: galleryOnTap, title: 'Gallery'),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  Future<String?> addNoteBottomDialog(
          BuildContext context, String pageType, String id) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          var content = '';
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0.0, right: 12.0, bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Add a note',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BeautyTextfield(
                          width: double.maxFinite,
                          height: 90,
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.text,
                          placeholder: "Write here",
                          maxLines: 5,
                          onTap: () {},
                          onChanged: (data) {
                            content = data;
                            _formKey.currentState!.validate();
                          },
                          isRequired: isError,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                isError = true;
                              });

                              return null;
                            } else {
                              setState(() {
                                isError = false;
                              });
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Create',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final ProgressDialog pr = ProgressDialog(
                                context,
                                type: ProgressDialogType.Normal,
                                isDismissible: false,
                                showLogs: false,
                              );

                              await pr.show();
                              Repository.getInstance()
                                  .createNote(params = {
                                pageType: id,
                                'content': content,
                              })
                                  .then((value) {
                                Navigator.pop(context);
                                toastHelper.toastWithTitleAndColor(
                                    'Created successfully!', greenColor);
                                pr.hide().then((isHidden) {
                                  // print(isHidden);
                                });
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
  Future<String?> updateNoteBottomDialog(
          BuildContext context, String id, String initialValue) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          var content = '';
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, 'note'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BeautyTextfield(
                          width: double.maxFinite,
                          height: 90,
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.text,
                          initialValue: initialValue,
                          placeholder: "Write here",
                          maxLines: 5,
                          onTap: () {},
                          onChanged: (data) {
                            content = data;
                            _formKey.currentState!.validate();
                          },
                          isRequired: isError,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                isError = true;
                              });

                              return null;
                            } else {
                              setState(() {
                                isError = false;
                              });
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Create',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final ProgressDialog pr = ProgressDialog(
                                context,
                                type: ProgressDialogType.Normal,
                                isDismissible: false,
                                showLogs: false,
                              );
                              await pr.show();
                              var success = await context
                                  .read<Repository>()
                                  .updateNote(params = {
                                    'id': id,
                                    'content': content,
                                  })
                                  .then((value) {
                                Navigator.pop(context);
                                toastHelper.toastWithTitleAndColor(
                                    'Updated successfully!', greenColor);
                              });
                              pr.hide();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
  bool isPreviousFilled = true;

  Future<String?> activityBottomDialog(
      BuildContext context, ActivityDetailsModel activityDetailsModel) {
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.COMPANY_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        if (activityDetailsModel.value == '') {
          selectedCompany = [];
        } else
          selectedCompany = [
            SearchCompanyNew(
                name: activityDetailsModel.value,
                id: '',
                createdAddress: '',
                createdAt: '',
                email: [],
                owner: '',
                phone: [],
                website: '')
          ];
      } else {
        selectedCompany = [
          SearchCompanyNew(
              name: activityDetailsModel.value['name'],
              id: activityDetailsModel.value['_id'],
              createdAddress: '',
              createdAt: '',
              email: [],
              owner: '',
              phone: [],
              website: '')
        ];
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.LEAD_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        if (activityDetailsModel.value == '') {
          selectedCompany = [];
        } else
          selectedLead = [
            SearchLeadNew(
                company: CompanyModel(name: ''),
                email: [],
                id: '',
                name: activityDetailsModel.value,
                phone: [])
          ];
      } else {
        selectedLead = [
          SearchLeadNew(
              company: CompanyModel(name: ''),
              email: [],
              id: activityDetailsModel.value['_id'],
              name: activityDetailsModel.value['name'],
              phone: [])
        ];
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.TAG_MULTI_SELECT.getType()) {
      for (var i = 0; i < activityDetailsModel.valueWithColor.length; i++) {
        allSelectedTags.add(Option(
            colorCode: activityDetailsModel.valueWithColor[i]["colorCode"],
            name: activityDetailsModel.valueWithColor[i]["name"],
            label: activityDetailsModel.valueWithColor[i]["label"],
            value: activityDetailsModel.valueWithColor[i]["value"]));
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.DEAL_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        if (activityDetailsModel.value == '') {
          selectedDeal = [];
        } else
          selectedDeal = [SearchResult('', activityDetailsModel.value)];
      } else {
        selectedDeal = [
          SearchResult(
            activityDetailsModel.value['_id'],
            activityDetailsModel.value['name'],
          )
        ];
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.PEOPLE_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        if (activityDetailsModel.value == '') {
          selectedPeople = [];
        } else
          selectedPeople = [
            SearchPeopleNew('', activityDetailsModel.value, [], [])
          ];
      } else {
        selectedPeople = [
          SearchPeopleNew(activityDetailsModel.value['_id'],
              activityDetailsModel.value['name'], [], [])
        ];
      }
    }
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          emails = [];

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              // allTags = activityDetailsModel.activityDetailsModelOptions
              //     as List<Option>;
              allTags = activityDetailsModel.activityDetailsModelOptions;

              if (activityDetailsModel.fieldInputType ==
                  FieldInputType.TAG_MULTI_SELECT.getType()) {
                allTags.forEach((element) {
                  for (var i = 0; i < allSelectedTags.length; i++) {
                    if (element.value == allSelectedTags[i].value) {
                      selectedTags.add(element);
                    }
                  }
                });
              }
              activitySymbol =
                  context.watch<Repository>().selectedActivitySymbol;

              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(
                          context, activityDetailsModel.fieldName),
                      activityDetailsModel.fieldInputType ==
                              FieldInputType.DATE_TIME.getType()
                          ? SizedBox()
                          : activityDetailsModel.fieldInputType ==
                                  FieldInputType.ACTIVITY_TYPE_SELECT.getType()
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ActivityTypeList(),
                                )
                              : activityDetailsModel.fieldInputType ==
                                      FieldInputType.MULTI_EMAIL_INPUT.getType()
                                  ? activityDetailsModel.value != null
                                      ? Form(
                                          key: _formKey,
                                          child: ListView.builder(
                                              itemCount: activityDetailsModel
                                                  .value.length,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, i) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0,
                                                          top: 0.0,
                                                          right: 12.0,
                                                          bottom: 4.0),
                                                  child: BeautyTextfield(
                                                    width: double.maxFinite,
                                                    height: 50,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    inputType: TextInputType
                                                        .emailAddress,
                                                    placeholder:
                                                        'Enter ${activityDetailsModel.fieldName} ',
                                                    initialValue:
                                                        activityDetailsModel
                                                            .value[i]
                                                            .toString(),
                                                    onChanged:
                                                        (String value) {},
                                                    onSaved: (String? value) {
                                                      if (value != null) {
                                                        if (value != '')
                                                          setState(() {
                                                            emails.add(value);
                                                            params = {
                                                              activityDetailsModel
                                                                      .apiKeyName:
                                                                  emails,
                                                            };
                                                          });
                                                      }
                                                    },
                                                    isRequired: isError,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        if (i ==
                                                            activityDetailsModel
                                                                    .value
                                                                    .length -
                                                                1) {
                                                          setState(() {
                                                            isPreviousFilled =
                                                                false;
                                                          });
                                                        }
                                                        setState(() {
                                                          isError = true;
                                                        });

                                                        return null;
                                                      } else {
                                                        if (i ==
                                                            activityDetailsModel
                                                                    .value
                                                                    .length -
                                                                1) {
                                                          setState(() {
                                                            isPreviousFilled =
                                                                true;
                                                          });
                                                        }
                                                        setState(() {
                                                          isError = false;
                                                        });
                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                );
                                              }),
                                        )
                                      : Text('')
                                  : activityDetailsModel.fieldInputType ==
                                          FieldInputType.TAG_MULTI_SELECT
                                              .getType()
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              left: 12.0,
                                              top: 4.0,
                                              right: 12.0,
                                              bottom: 6.0),
                                          child: CustomTag(
                                            allTags: allTags,
                                            selectedTags: selectedTags,
                                          ),
                                        )
                                      : activityDetailsModel.fieldInputType ==
                                              FieldInputType.COMPANY_SELECT
                                                  .getType()
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  right: 12.0,
                                                  bottom: 8.0),
                                              child: SearchableDropdown(
                                                  key:
                                                      const ValueKey('Company'),
                                                  searchBarTitle:
                                                      'Search Company',
                                                  searchBarController:
                                                      _companySearchBarController,
                                                  onSearchTextChanged:
                                                      (value) async {
                                                    setState(() {
                                                      isSearching = true;
                                                    });
                                                    allCompanies =
                                                        await Repository
                                                            .getCompanyNewSearch(
                                                                value);
                                                    setState(() {
                                                      isSearching = false;
                                                    });
                                                  },
                                                  searching: isSearching,
                                                  onSelected: () {
                                                    orgSelected = true;
                                                    params = {
                                                      activityDetailsModel
                                                              .apiKeyName:
                                                          selectedCompany[0].id,
                                                    };
                                                  },
                                                  selected: selectedCompany,
                                                  all: allCompanies),
                                            )
                                          : activityDetailsModel
                                                      .fieldInputType ==
                                                  FieldInputType.LEAD_SELECT
                                                      .getType()
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0,
                                                          right: 12.0,
                                                          bottom: 8.0),
                                                  child: LeadSearchableDropdown(
                                                      key: const ValueKey(
                                                          'Lead'),
                                                      searchBarTitle:
                                                          'Search Lead',
                                                      searchBarController:
                                                          _leadSearchBarController,
                                                      onSearchTextChanged:
                                                          (value) async {
                                                        setState(() {
                                                          isSearching = true;
                                                        });
                                                        allLeads =
                                                            await Repository
                                                                .getLeadNewSearch(
                                                                    value);
                                                        setState(() {
                                                          isSearching = false;
                                                        });
                                                      },
                                                      searching: isSearching,
                                                      onSelected: () {
                                                        params = {
                                                          activityDetailsModel
                                                                  .apiKeyName:
                                                              selectedLead[0]
                                                                  .id,
                                                        };
                                                      },
                                                      selected: selectedLead,
                                                      all: allLeads),
                                                )
                                              : activityDetailsModel
                                                          .fieldInputType ==
                                                      FieldInputType.DEAL_SELECT
                                                          .getType()
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0,
                                                              right: 12.0,
                                                              bottom: 8.0),
                                                      child:
                                                          DealSearchableDropdown(
                                                              key:
                                                                  const ValueKey(
                                                                      'Deal'),
                                                              searchBarTitle:
                                                                  'Search Deal',
                                                              searchBarController:
                                                                  _dealSearchBarController,
                                                              onSearchTextChanged:
                                                                  (value) async {
                                                                setState(() {
                                                                  isSearching =
                                                                      true;
                                                                });
                                                                allDeals = await Repository
                                                                    .getDealNewSearch(
                                                                        value);
                                                                setState(() {
                                                                  isSearching =
                                                                      false;
                                                                });
                                                              },
                                                              searching:
                                                                  isSearching,
                                                              onSelected: () {
                                                                params = {
                                                                  activityDetailsModel
                                                                          .apiKeyName:
                                                                      selectedDeal[
                                                                              0]
                                                                          .id,
                                                                };
                                                              },
                                                              selected:
                                                                  selectedDeal,
                                                              all: allDeals),
                                                    )
                                                  : activityDetailsModel
                                                              .fieldInputType ==
                                                          FieldInputType
                                                              .PEOPLE_SELECT
                                                              .getType()
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0,
                                                                  right: 12.0,
                                                                  bottom: 8.0),
                                                          child:
                                                              PeopleSearchableDropdown(
                                                            key: const ValueKey(
                                                                'People'),
                                                            searchBarTitle:
                                                                'Search People',
                                                            searchBarController:
                                                                _peopleSearchBarController,
                                                            onSearchTextChanged:
                                                                (value) async {
                                                              setState(() {
                                                                isSearching =
                                                                    true;
                                                              });
                                                              allPeoples =
                                                                  await Repository
                                                                      .getPeopleNewSearch(
                                                                          value);
                                                              setState(() {
                                                                isSearching =
                                                                    false;
                                                              });
                                                            },
                                                            searching:
                                                                isSearching,
                                                            onSelected: () {
                                                              params = {
                                                                activityDetailsModel
                                                                        .apiKeyName:
                                                                    selectedPeople[
                                                                            0]
                                                                        .id,
                                                              };
                                                            },
                                                            selected:
                                                                selectedPeople,
                                                            all: allPeoples,
                                                            onClear: () {
                                                              setState(() {
                                                                selectedPeople
                                                                    .clear();
                                                              });
                                                            },
                                                            newPerson:
                                                                (bool) {},
                                                            withNew: false,
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0,
                                                                  top: 4.0,
                                                                  right: 12.0,
                                                                  bottom: 6.0),
                                                          child: Form(
                                                            key: _formKey,
                                                            child:
                                                                BeautyTextfield(
                                                              width: double
                                                                  .maxFinite,
                                                              height: 50,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              inputType: activityDetailsModel
                                                                          .fieldInputType ==
                                                                      FieldInputType
                                                                          .NUMBER
                                                                          .getType()
                                                                  ? TextInputType
                                                                      .number
                                                                  : TextInputType
                                                                      .text,
                                                              placeholder:
                                                                  'Enter ${activityDetailsModel.fieldName} ',
                                                              initialValue: (activityDetailsModel
                                                                          .fieldInputType ==
                                                                      FieldInputType
                                                                          .MULTI_PHONE_INPUT
                                                                          .getType())
                                                                  ? phoneInitValue(
                                                                      activityDetailsModel
                                                                          .value)
                                                                  : activityDetailsModel
                                                                              .value
                                                                          is List
                                                                      ? activityDetailsModel
                                                                          .value[
                                                                              0]
                                                                          .toString()
                                                                      : activityDetailsModel
                                                                          .value
                                                                          .toString(),
                                                              initialSelection: (activityDetailsModel
                                                                          .fieldInputType ==
                                                                      FieldInputType
                                                                          .MULTI_PHONE_INPUT
                                                                          .getType())
                                                                  ? '+${activityDetailsModel.value != null && activityDetailsModel.value != '' ? activityDetailsModel.value.toString().substring(0, 2) : 91}'
                                                                  : '+91',
                                                              countryCode: (activityDetailsModel
                                                                      .fieldInputType ==
                                                                  FieldInputType
                                                                      .MULTI_PHONE_INPUT
                                                                      .getType()),
                                                              countryOnChanged:
                                                                  (CountryCode
                                                                      value) {
                                                                if (activityDetailsModel
                                                                        .fieldInputType ==
                                                                    FieldInputType
                                                                        .MULTI_PHONE_INPUT
                                                                        .getType())
                                                                  countryCode =
                                                                      value
                                                                          .dialCode!;
                                                                phone = int.parse(countryCode +
                                                                    activityDetailsModel
                                                                        .value
                                                                        .toString()
                                                                        .substring(
                                                                            2,
                                                                            activityDetailsModel.value.toString().length));
                                                                setState(() {
                                                                  params = {
                                                                    activityDetailsModel
                                                                            .apiKeyName:
                                                                        phone,
                                                                  };
                                                                });
                                                                _formKey
                                                                    .currentState!
                                                                    .validate();
                                                              },
                                                              onChanged: (String
                                                                  value) {
                                                                if (activityDetailsModel
                                                                        .fieldInputType ==
                                                                    FieldInputType
                                                                        .MULTI_PHONE_INPUT
                                                                        .getType()) {
                                                                  if (value !=
                                                                          null &&
                                                                      countryCode !=
                                                                          null)
                                                                    phone = int.parse(
                                                                        countryCode +
                                                                            value);
                                                                  setState(() {
                                                                    params = {
                                                                      activityDetailsModel
                                                                              .apiKeyName:
                                                                          phone,
                                                                    };
                                                                  });
                                                                  _formKey
                                                                      .currentState!
                                                                      .validate();
                                                                } else {
                                                                  setState(() {
                                                                    params = {
                                                                      activityDetailsModel
                                                                              .apiKeyName:
                                                                          value,
                                                                    };
                                                                  });
                                                                  _formKey
                                                                      .currentState!
                                                                      .validate();
                                                                }
                                                              },
                                                              isRequired:
                                                                  isError,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  setState(() {
                                                                    isError =
                                                                        true;
                                                                  });

                                                                  return null;
                                                                } else {
                                                                  setState(() {
                                                                    isError =
                                                                        false;
                                                                  });
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                      if (activityDetailsModel.fieldInputType ==
                          FieldInputType.ACTIVITY_TYPE_SELECT.getType())
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Text(activitySymbol == null
                              ? "Select activity "
                              : "Activity Name - ${activitySymbol!.name}"),
                        ),
                      if (activityDetailsModel.fieldInputType ==
                          FieldInputType.MULTI_EMAIL_INPUT.getType())
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: new DottedButton(
                            icon: Icons.add,
                            title: 'Add Email',
                            onTap: () {
                              if (activityDetailsModel.value != null)
                                _formKey.currentState!.validate();
                              if (isPreviousFilled) {
                                if (activityDetailsModel.value == null) {
                                  activityDetailsModel.value = [];
                                }
                                setState(() {
                                  activityDetailsModel.value.add('');
                                  isPreviousFilled = false;
                                  // emails.clear();

                                  // _controllers.add(new TextEditingController());
                                });
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    'Fill all the previous values before adding!',
                                    black);
                              }
                            },
                          ),
                        ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (activityDetailsModel.fieldInputType ==
                                FieldInputType.COMPANY_SELECT.getType()) {
                              if (orgSelected) {
                                updateActivity(context, id, params, false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Select company!", black);
                              }
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.ACTIVITY_TYPE_SELECT.getType()) {
                              if (activitySymbol != null) {
                                params = {
                                  activityDetailsModel.apiKeyName:
                                      activitySymbol!.getId(),
                                };
                                updateActivity(context, id, params, true);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Select tags!", black);
                              }
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.TAG_MULTI_SELECT.getType()) {
                              if (selectedTags != null &&
                                  selectedTags.isNotEmpty) {
                                selectedTags.forEach(
                                    (v) => selectedTagsValue.add(v.value));
                                params = {
                                  activityDetailsModel.apiKeyName:
                                      selectedTagsValue,
                                };
                                updateActivity(context, id, params, false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Select tags!", black);
                              }
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.LEAD_SELECT.getType()) {
                              if (selectedLead != null &&
                                  selectedLead.isNotEmpty) {
                                updateActivity(context, id, params, false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Select a lead!", black);
                              }
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.ACTIVITY_TYPE_SELECT.getType()) {
                              updateActivity(context, id, params, true);
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.DEAL_SELECT.getType()) {
                              if (selectedDeal != null &&
                                  selectedDeal.isNotEmpty) {
                                updateActivity(context, id, params, false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Select a deal!", black);
                              }
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.MULTI_EMAIL_INPUT.getType()) {
                              _formKey.currentState!.save();
                              if (emails.isNotEmpty) {
                                params = {
                                  activityDetailsModel.apiKeyName: emails,
                                };
                                updateActivity(context, id, params, false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Wrong email format!", black);
                              }
                            } else if (activityDetailsModel.fieldInputType ==
                                FieldInputType.PEOPLE_SELECT.getType()) {
                              if (selectedPeople != null &&
                                  selectedPeople.isNotEmpty) {
                                updateActivity(context, id, params, false);
                              } else {
                                toastHelper.toastWithTitleAndColor(
                                    "Select a people!", black);
                              }
                            } else if (_formKey.currentState!.validate()) {
                              updateActivity(
                                  context,
                                  id,
                                  params,
                                  activityDetailsModel.apiKeyName == 'name'
                                      ? true
                                      : false);
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Enter value!", black);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  updateActivity(BuildContext context, String id, Map<String, dynamic> params,
      bool name) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess =
        await Repository.getInstance().updateActivityDetails(params, id);
    pr.hide();

    if (isSuccess) {
      toastHelper.toastWithTitleAndColor("Successfully Updated ", greenColor);

      if (handler != null) {
        handler!();
      }
      Navigator.pop(context);
      if (name) {
        Navigator.pop(context, true);
      }
    } else {
      toastHelper.toastWithTitleAndColor("Failed to Update ", redColor);
    }
  }

  String? pipelineId, stageId, demoId;
  late DateTime dateAndTime;
  onSelect(DropDownModel dropDownModel) {
    pipelineId = dropDownModel.value;
  }

  Future<String?> dealBottomDialog(
      BuildContext context, ActivityDetailsModel activityDetailsModel) {
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.ORG_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        selectedCompany = [
          SearchCompanyNew(
              name: activityDetailsModel.value,
              id: '',
              createdAddress: '',
              createdAt: '',
              email: [],
              owner: '',
              phone: [],
              website: '')
        ];
      } else {
        selectedCompany = [
          SearchCompanyNew(
              name: activityDetailsModel.value['name'],
              id: activityDetailsModel.value['_id'],
              createdAddress: '',
              createdAt: '',
              email: [],
              owner: '',
              phone: [],
              website: '')
        ];
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.TAG_MULTI_SELECT.getType()) {
      for (var i = 0; i < activityDetailsModel.valueWithColor.length; i++) {
        allSelectedTags.add(Option(
            colorCode: activityDetailsModel.valueWithColor[i]["colorCode"],
            name: activityDetailsModel.valueWithColor[i]["name"],
            label: activityDetailsModel.valueWithColor[i]["label"],
            value: activityDetailsModel.valueWithColor[i]["value"]));
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.PERSON_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        if (activityDetailsModel.value == '') {
          selectedPeople = [];
        } else
          selectedPeople = [
            SearchPeopleNew('', activityDetailsModel.value, [], [])
          ];
      } else {
        selectedPeople = [
          SearchPeopleNew(
            activityDetailsModel.value['_id'],
            activityDetailsModel.value['name'],
            [],
            [],
          )
        ];
      }
    }
    if (activityDetailsModel.fieldInputType ==
        FieldInputType.LEAD_SELECT.getType()) {
      if (activityDetailsModel.value is String) {
        if (activityDetailsModel.value == '') {
          selectedCompany = [];
        } else
          selectedLead = [
            SearchLeadNew(
                company: CompanyModel(name: ''),
                email: [],
                id: '',
                name: activityDetailsModel.value,
                phone: [])
          ];
      } else {
        selectedLead = [
          SearchLeadNew(
              company: CompanyModel(name: ''),
              email: [],
              id: activityDetailsModel.value['_id'],
              name: activityDetailsModel.value['name'],
              phone: [])
        ];
      }
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              allTags = activityDetailsModel.activityDetailsModelOptions;

              if (activityDetailsModel.fieldInputType ==
                  FieldInputType.TAG_MULTI_SELECT.getType()) {
                allTags.forEach((element) {
                  for (var i = 0; i < allSelectedTags.length; i++) {
                    if (element.value == allSelectedTags[i].value) {
                      selectedTags.add(element);
                    }
                  }
                });
              }
              var stages = context.watch<Repository>().stages;
              if (activityDetailsModel.fieldName == 'Expected Close Date') {
                dateAndTime =
                    DateTime.parse(activityDetailsModel.value).toLocal();
              }
              if (activityDetailsModel.fieldInputType ==
                  FieldInputType.PIPELINE_STAGE_SELECT.getType()) {
                List<PipelineModel> list = [];
                List<DropDownModel> modes = [];
                DropDownModel? selectedMode;
                list = context.watch<Repository>().pipelines;
                if (list.length > 0) {
                  if (modes.length == 0) {
                    list.forEach((element) {
                      modes.add(
                        DropDownModel(
                          element.name,
                          element.id,
                        ),
                      );
                    });
                  }
                  if (selectedMode == null) {
                    selectedMode = modes[0];

                    for (int i = 0; i < list.length; i++) {
                      if (list[i].id == modes[0].value) {
                        context
                            .read<Repository>()
                            .setPipelineStages(list[i].stages);
                        break;
                      }
                    }
                  }
                }
              }

              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    bottomSheetHeader(context, activityDetailsModel.fieldName),
                    activityDetailsModel.fieldInputType ==
                            FieldInputType.DATE_TIME.getType()
                        ? SizedBox()
                        : activityDetailsModel.fieldName ==
                                'Expected Close Date'
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (BuildContext builder) {
                                          var now = DateTime.now();

                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .copyWith()
                                                    .size
                                                    .height *
                                                0.25,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        overlayColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    white),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Done',
                                                        style: TextStyle(
                                                            color: black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.0)
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: CupertinoDatePicker(
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .dateAndTime,
                                                      minimumDate: now,
                                                      use24hFormat: false,
                                                      onDateTimeChanged:
                                                          (date) {
                                                        if (date != null &&
                                                            date !=
                                                                selectedDate)
                                                          setState(() {
                                                            selectedDate = date;

                                                            var datea =
                                                                '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';

                                                            selectedEndDate =
                                                                dateFormater(
                                                                    datea);
                                                            selectedDateRange =
                                                                DateTimeRange(
                                                                    start: now.add(
                                                                        Duration(
                                                                            days:
                                                                                1)),
                                                                    end: date);
                                                            dateType = 4;
                                                          });
                                                      },
                                                      initialDateTime:
                                                          selectedDate,
                                                      minimumYear: now.year,
                                                      maximumYear: now
                                                          .add(Duration(
                                                              days: 100))
                                                          .year,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    decoration: BoxDecoration(
                                        color: appColor.grey,
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    height: 50.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  selectedEndDate == ''
                                                      ? Text(
                                                          "${activityDetailsModel.value != '' ? activityDetailsModel.value != null ? dateFormater('${dateAndTime.day}/${dateAndTime.month}/${dateAndTime.year} ${dateAndTime.hour}:${dateAndTime.minute}') : "NA" : ''} ")
                                                      : Text(
                                                          "${selectedEndDate}",
                                                          style:
                                                              selectedEndDate ==
                                                                      ''
                                                                  ? textHelper
                                                                      .hintText
                                                                  : textHelper
                                                                      .defaultText,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : activityDetailsModel.fieldInputType ==
                                    FieldInputType.PIPELINE_SELECT.getType()
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Pipelines(onSelect),
                                  )
                                : activityDetailsModel.fieldInputType ==
                                        FieldInputType.PIPELINE_STAGE_SELECT
                                            .getType()
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: StageList((Stage stage) {
                                          stageId = stage.id;
                                          // print('~~~~~~~~~stage Id:- ' + stage.id);
                                        }),
                                      )
                                    : activityDetailsModel.fieldInputType ==
                                            FieldInputType.TAG_MULTI_SELECT
                                                .getType()
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                left: 12.0,
                                                top: 4.0,
                                                right: 12.0,
                                                bottom: 6.0),
                                            child: CustomTag(
                                              allTags: allTags,
                                              selectedTags: selectedTags,
                                            ),
                                          )
                                        : activityDetailsModel.fieldInputType ==
                                                FieldInputType.ORG_SELECT
                                                    .getType()
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0,
                                                    right: 12.0,
                                                    bottom: 8.0),
                                                child: SearchableDropdown(
                                                    key: const ValueKey(
                                                        'Company'),
                                                    searchBarTitle:
                                                        'Search Company',
                                                    searchBarController:
                                                        _companySearchBarController,
                                                    onSearchTextChanged:
                                                        (value) async {
                                                      setState(() {
                                                        isSearching = true;
                                                      });
                                                      allCompanies =
                                                          await Repository
                                                              .getCompanyNewSearch(
                                                                  value);
                                                      setState(() {
                                                        isSearching = false;
                                                      });
                                                    },
                                                    searching: isSearching,
                                                    onSelected: () {
                                                      orgSelected = true;
                                                      params = {
                                                        activityDetailsModel
                                                                .apiKeyName:
                                                            selectedCompany[0]
                                                                .id,
                                                      };
                                                    },
                                                    selected: selectedCompany,
                                                    all: allCompanies),
                                              )
                                            : activityDetailsModel
                                                        .fieldInputType ==
                                                    FieldInputType.LEAD_SELECT
                                                        .getType()
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            right: 12.0,
                                                            bottom: 8.0),
                                                    child:
                                                        LeadSearchableDropdown(
                                                            key: const ValueKey(
                                                                'Lead'),
                                                            searchBarTitle:
                                                                'Search Lead',
                                                            searchBarController:
                                                                _leadSearchBarController,
                                                            onSearchTextChanged:
                                                                (value) async {
                                                              setState(() {
                                                                isSearching =
                                                                    true;
                                                              });
                                                              allLeads =
                                                                  await Repository
                                                                      .getLeadNewSearch(
                                                                          value);
                                                              setState(() {
                                                                isSearching =
                                                                    false;
                                                              });
                                                            },
                                                            searching:
                                                                isSearching,
                                                            onSelected: () {
                                                              params = {
                                                                activityDetailsModel
                                                                        .apiKeyName:
                                                                    selectedLead[
                                                                            0]
                                                                        .id,
                                                              };
                                                            },
                                                            selected:
                                                                selectedLead,
                                                            all: allLeads),
                                                  )
                                                : activityDetailsModel
                                                            .fieldInputType ==
                                                        FieldInputType
                                                            .DEAL_SELECT
                                                            .getType()
                                                    ? DealSearchableDropdown(
                                                        key:
                                                            const ValueKey(
                                                                'Deal'),
                                                        searchBarTitle:
                                                            'Search Deal',
                                                        searchBarController:
                                                            _dealSearchBarController,
                                                        onSearchTextChanged:
                                                            (value) async {
                                                          setState(() {
                                                            isSearching = true;
                                                          });
                                                          allDeals =
                                                              await Repository
                                                                  .getDealNewSearch(
                                                                      value);
                                                          setState(() {
                                                            isSearching = false;
                                                          });
                                                        },
                                                        searching: isSearching,
                                                        onSelected: () {
                                                          params = {
                                                            activityDetailsModel
                                                                    .apiKeyName:
                                                                selectedDeal[0]
                                                                    .id,
                                                          };
                                                        },
                                                        selected: selectedDeal,
                                                        all: allDeals)
                                                    : activityDetailsModel
                                                                .fieldInputType ==
                                                            FieldInputType
                                                                .PERSON_SELECT
                                                                .getType()
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0,
                                                                    right: 12.0,
                                                                    bottom:
                                                                        8.0),
                                                            child:
                                                                PeopleSearchableDropdown(
                                                              key:
                                                                  const ValueKey(
                                                                      'People'),
                                                              searchBarTitle:
                                                                  'Search People',
                                                              searchBarController:
                                                                  _peopleSearchBarController,
                                                              onSearchTextChanged:
                                                                  (value) async {
                                                                setState(() {
                                                                  isSearching =
                                                                      true;
                                                                });
                                                                allPeoples =
                                                                    await Repository
                                                                        .getPeopleNewSearch(
                                                                            value);
                                                                setState(() {
                                                                  isSearching =
                                                                      false;
                                                                });
                                                              },
                                                              searching:
                                                                  isSearching,
                                                              onSelected: () {
                                                                params = {
                                                                  activityDetailsModel
                                                                          .apiKeyName:
                                                                      selectedPeople[
                                                                              0]
                                                                          .id,
                                                                };
                                                              },
                                                              selected:
                                                                  selectedPeople,
                                                              all: allPeoples,
                                                              onClear: () {
                                                                setState(() {
                                                                  selectedPeople
                                                                      .clear();
                                                                });
                                                              },
                                                              newPerson:
                                                                  (bool) {},
                                                              withNew: false,
                                                            ),
                                                          )
                                                        : Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0,
                                                                    right:
                                                                        12.0),
                                                            child: Form(
                                                              key: _formKey,
                                                              child:
                                                                  BeautyTextfield(
                                                                width: double
                                                                    .maxFinite,
                                                                height: 50,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                inputType: activityDetailsModel
                                                                            .fieldInputType ==
                                                                        FieldInputType
                                                                            .NUMBER
                                                                            .getType()
                                                                    ? TextInputType
                                                                        .number
                                                                    : TextInputType
                                                                        .text,
                                                                placeholder:
                                                                    'Enter ${activityDetailsModel.fieldName} ',
                                                                initialValue: (activityDetailsModel
                                                                            .fieldInputType ==
                                                                        FieldInputType
                                                                            .MULTI_PHONE_INPUT
                                                                            .getType())
                                                                    ? phoneInitValue(
                                                                        activityDetailsModel
                                                                            .value)
                                                                    : activityDetailsModel.value
                                                                            is List
                                                                        ? activityDetailsModel
                                                                            .value[
                                                                                0]
                                                                            .toString()
                                                                        : activityDetailsModel
                                                                            .value
                                                                            .toString(),
                                                                initialSelection: (activityDetailsModel
                                                                            .fieldInputType ==
                                                                        FieldInputType
                                                                            .MULTI_PHONE_INPUT
                                                                            .getType())
                                                                    ? '+${activityDetailsModel.value != null && activityDetailsModel.value != '' ? activityDetailsModel.value.toString().substring(0, 2) : 91}'
                                                                    : '+91',
                                                                countryCode: (activityDetailsModel
                                                                        .fieldInputType ==
                                                                    FieldInputType
                                                                        .MULTI_PHONE_INPUT
                                                                        .getType()),
                                                                countryOnChanged:
                                                                    (CountryCode
                                                                        value) {
                                                                  if (activityDetailsModel
                                                                          .fieldInputType ==
                                                                      FieldInputType
                                                                          .MULTI_PHONE_INPUT
                                                                          .getType())
                                                                    countryCode =
                                                                        value
                                                                            .dialCode!;
                                                                  phone = int.parse(countryCode +
                                                                      activityDetailsModel
                                                                          .value
                                                                          .toString()
                                                                          .substring(
                                                                              2,
                                                                              activityDetailsModel.value.toString().length));
                                                                  setState(() {
                                                                    params = {
                                                                      activityDetailsModel
                                                                              .apiKeyName:
                                                                          phone,
                                                                    };
                                                                  });
                                                                  _formKey
                                                                      .currentState!
                                                                      .validate();
                                                                },
                                                                onChanged:
                                                                    (String
                                                                        value) {
                                                                  if (activityDetailsModel
                                                                          .fieldInputType ==
                                                                      FieldInputType
                                                                          .MULTI_PHONE_INPUT
                                                                          .getType()) {
                                                                    if (value !=
                                                                            null &&
                                                                        countryCode !=
                                                                            null)
                                                                      phone = int.parse(
                                                                          countryCode +
                                                                              value);
                                                                    setState(
                                                                        () {
                                                                      params = {
                                                                        activityDetailsModel.apiKeyName:
                                                                            phone,
                                                                      };
                                                                    });
                                                                    _formKey
                                                                        .currentState!
                                                                        .validate();
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      params = {
                                                                        activityDetailsModel.apiKeyName:
                                                                            value,
                                                                      };
                                                                    });
                                                                    _formKey
                                                                        .currentState!
                                                                        .validate();
                                                                  }
                                                                },
                                                                isRequired:
                                                                    isError,
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    setState(
                                                                        () {
                                                                      isError =
                                                                          true;
                                                                    });

                                                                    return null;
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      isError =
                                                                          false;
                                                                    });
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                      ),
                      child: SaveButton(
                        title: 'Update',
                        onTap: () {
                          if (activityDetailsModel.fieldInputType ==
                              FieldInputType.ORG_SELECT.getType()) {
                            if (orgSelected) {
                              updateDeal(context, id, params, true, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select company!", black);
                            }
                          } else if (activityDetailsModel.fieldInputType ==
                              FieldInputType.TAG_MULTI_SELECT.getType()) {
                            if (selectedTags != null &&
                                selectedTags.isNotEmpty) {
                              selectedTags.forEach(
                                  (v) => selectedTagsValue.add(v.value));
                              params = {
                                activityDetailsModel.apiKeyName:
                                    selectedTagsValue,
                              };
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select tags!", black);
                            }
                          } else if (activityDetailsModel.fieldName ==
                              'Expected Close Date') {
                            if (selectedDate != null) {
                              params = {
                                activityDetailsModel.apiKeyName:
                                    selectedDate.millisecondsSinceEpoch,
                              };
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select Date!", black);
                            }
                          } else if (activityDetailsModel.fieldInputType ==
                              FieldInputType.PIPELINE_SELECT.getType()) {
                            if (pipelineId != null) {
                              params = {
                                activityDetailsModel.apiKeyName: pipelineId,
                              };
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select Date!", black);
                            }
                          } else if (activityDetailsModel.fieldInputType ==
                              FieldInputType.PIPELINE_STAGE_SELECT.getType()) {
                            if (stageId != null) {
                              params = {
                                activityDetailsModel.apiKeyName: stageId,
                              };
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select Date!", black);
                            }
                          } else if (activityDetailsModel.fieldInputType ==
                              FieldInputType.LEAD_SELECT.getType()) {
                            if (selectedLead != null &&
                                selectedLead.isNotEmpty) {
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select a lead!", black);
                            }
                          } else if (activityDetailsModel.fieldInputType ==
                              FieldInputType.DEAL_SELECT.getType()) {
                            if (selectedDeal != null &&
                                selectedDeal.isNotEmpty) {
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select a deal!", black);
                            }
                          } else if (activityDetailsModel.fieldInputType ==
                              FieldInputType.PERSON_SELECT.getType()) {
                            if (selectedPeople != null &&
                                selectedPeople.isNotEmpty) {
                              updateDeal(context, id, params, false, '');
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  "Select a people!", black);
                            }
                          } else if (activityDetailsModel.fieldName ==
                                  'Deal Value' ||
                              activityDetailsModel.fieldName ==
                                  'Deal Currency') {
                            updateDeal(context, id, params, true, '');
                          } else if (_formKey.currentState!.validate()) {
                            updateDeal(
                                context,
                                id,
                                params,
                                activityDetailsModel.fieldName ==
                                            'Deal Title' ||
                                        activityDetailsModel.fieldName ==
                                            'Amount'
                                    ? true
                                    : false,
                                '');
                          } else {
                            toastHelper.toastWithTitleAndColor(
                                "Enter value!", black);
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.88,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          );
        });
  }

  updateDeal(BuildContext context, String id, Map<String, dynamic> params,
      bool name, String isUpdating) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    var isSuccess = await Repository.getInstance()
        .updateDealDetails(params, id, isUpdating);
    pr.hide();

    if (isSuccess is bool && isSuccess == true) {
      if (handler != null) {
        handler!();
      }
      Navigator.pop(context);
      if (name) {
        Navigator.pop(context, true);
      }
    }
  }

  bool isError = false;
  ActivitySymbol? activitySymbol = new ActivitySymbol();
  String? activityName;
  Future<String?> addShortActivityBottomDialog(
          BuildContext context, String pageType, String id) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              activitySymbol =
                  context.watch<Repository>().selectedActivitySymbol;
              return Container(
                decoration: new BoxDecoration(
                  color: white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    topRight: const Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0.0, right: 12.0, bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Add an Activity',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () {
                                  dateType = 0;
                                  activityName = null;
                                  activitySymbol = null;
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      ActivityTypeList(),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child:
                            Text('Activity Name*', style: textHelper.heading16),
                      ),
                      new BeautyTextfield(
                          width: double.maxFinite,
                          height: 50,
                          autofocus: false,
                          isRequired: isError,
                          key: Key(activitySymbol == null
                              ? ''
                              : '${activitySymbol!.name}'),
                          initialValue: activitySymbol == null
                              ? ''
                              : '${activitySymbol!.name}',
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.text,
                          placeholder: activitySymbol != null
                              ? activitySymbol!.name != ''
                                  ? "Activity Name - ${activitySymbol!.name}"
                                  : "Activity Name"
                              : "Activity Name",
                          onChanged: (data) {
                            if (data != null) {
                              setState(() {
                                activityName = data;
                              });
                            }
                            _formKey.currentState!.validate();
                            // print(activityName);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                isError = true;
                              });

                              return null;
                            } else {
                              setState(() {
                                isError = false;
                              });
                              return null;
                            }
                          }),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('Time*', style: textHelper.heading16)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            datePickerUi(
                                title: 'In 1h',
                                onTap: () {
                                  setState(() {
                                    dateType = 1;
                                    selectedEndDate = '';
                                    selectedDateRange = DateTimeRange(
                                        start: dateNow,
                                        end: dateNow.add(Duration(hours: 1)));
                                  });
                                },
                                currentdatetype: 1),
                            datePickerUi(
                                title: 'In 3hrs',
                                onTap: () {
                                  setState(() {
                                    dateType = 2;
                                    selectedEndDate = '';
                                    selectedDateRange = DateTimeRange(
                                        start: dateNow,
                                        end: dateNow.add(Duration(hours: 3)));
                                  });
                                },
                                currentdatetype: 2),
                            datePickerUi(
                                title: 'Tomorrow',
                                onTap: () {
                                  setState(() {
                                    dateType = 3;
                                    selectedEndDate = '';
                                    selectedDateRange = DateTimeRange(
                                        start: dateNow,
                                        end: dateNow.add(Duration(days: 1)));
                                  });
                                },
                                currentdatetype: 3),
                            GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      var now = DateTime.now();

                                      return Container(
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                            0.25,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all<Color>(white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Done',
                                                    style: TextStyle(
                                                        color: black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(width: 8.0)
                                              ],
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .dateAndTime,
                                                  minimumDate: now,
                                                  use24hFormat: false,
                                                  onDateTimeChanged: (date) {
                                                    if (date != null &&
                                                        date != selectedDate)
                                                      setState(() {
                                                        selectedDate = date;
                                                        var datea =
                                                            '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
                                                        selectedEndDate =
                                                            dateFormater(datea);
                                                        selectedDateRange =
                                                            DateTimeRange(
                                                                start: now.add(
                                                                    Duration(
                                                                        days:
                                                                            1)),
                                                                end: date);
                                                        dateType = 4;
                                                      });
                                                  },
                                                  initialDateTime: selectedDate,
                                                  minimumYear: now.year,
                                                  maximumYear: now
                                                      .add(Duration(days: 100))
                                                      .year,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: appColor.grey,
                                    border: dateType == 4
                                        ? Border.all(width: 1, color: deepblue)
                                        : null,
                                    borderRadius: BorderRadius.circular(4.0)),
                                height: 50.0,
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        selectedEndDate == ''
                                            ? "    Custom    "
                                            : "$selectedEndDate"
                                                .substring(0, 10),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: textHelper.defaultText14,
                                      ),
                                      selectedEndDate != ''
                                          ? Text(
                                              "$selectedEndDate"
                                                  .substring(11, 19),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: textHelper.defaultText14,
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 10,
                          right: 10,
                        ),
                        child: SaveButton(
                          title: 'Create',
                          onTap: () async {
                            if (_formKey.currentState!.validate() &&
                                activitySymbol != null &&
                                selectedDateRange != null) {
                              final ProgressDialog pr = ProgressDialog(
                                context,
                                type: ProgressDialogType.Normal,
                                isDismissible: false,
                                showLogs: false,
                              );

                              await pr.show();
                              await Repository.getInstance()
                                  .createShortActivity(params = {
                                "name": activityName != null
                                    ? activityName
                                    : activitySymbol!.name,
                                "activityType": activitySymbol!.getId(),
                                "scheduleAt": selectedDateRange!
                                    .end.millisecondsSinceEpoch,
                                "duration": 0,
                                pageType: id,
                              })
                                  .then((value) {
                                setState(() {
                                  dateType = 0;
                                  activityName = null;
                                  activitySymbol = null;

                                  selectedDate =
                                      DateTime.now().add(Duration(days: 1));
                                });

                                Navigator.pop(context);
                                pr.hide();

                                toastHelper.toastWithTitleAndColor(
                                    'Created successfully!', greenColor);
                              });
                            } else {
                              toastHelper.toastWithTitleAndColor(
                                  'Select all the fields!', black);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

  dateFormater(String date) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  datePickerUi(
      {Function()? onTap,
      required String title,
      required int currentdatetype}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: dateType == currentdatetype
                ? Border.all(width: 1, color: deepblue)
                : null,
            color: bgColor),
        child: AutoSizeText(title, style: textHelper.defaultText, maxLines: 1),
      ),
    );
  }

  Future<String?> customTags(BuildContext context, List<Option> allTags) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, 'tags'),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 4.0, right: 12.0, bottom: 6.0),
                        child: CustomTag(
                          allTags: allTags,
                          selectedTags: selectedTags,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (selectedTags.isNotEmpty) {
                              Navigator.pop(context, selectedTags);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  List<Product> selectedProduct = [], allProducts = [];
  double? quantity = null, amount, unitPrice = null;
  String selectedProductId = '';
  bool edit = false;
  late List<SearchProduct> searchProduct;
  Future<String?> addProductBottomDialog(
          BuildContext context,
          List<dynamic> products,
          bool newProduct,
          String apiKeyName,
          int index) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          bool emptyProduct = false,
              emptyQuantity = false,
              emptyUnitPrice = false;
          TextEditingController qController =
              TextEditingController(text: quantity == null ? '' : '$quantity');
          TextEditingController uController = TextEditingController(
              text: unitPrice == null ? '' : '$unitPrice');

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              // allProducts.clear();

              return Container(
                decoration: new BoxDecoration(
                  color: white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    topRight: const Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0.0, right: 12.0, bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                newProduct
                                    ? 'Link a product'
                                    : 'Update product',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductSearchableDropdown(
                          key: const ValueKey('Product'),
                          searchBarTitle: 'Search product',
                          searchBarController: _leadSearchBarController,
                          isRequired: emptyProduct,
                          onSearchTextChanged: (value) async {
                            setState(() {
                              isSearching = true;
                            });
                            searchProduct =
                                await Repository.getProductNewSearch(value);

                            searchProduct.forEach((element) {
                              allProducts.clear();
                              allProducts.add(
                                Product(
                                  amount: 0.0,
                                  itemName: element.productName,
                                  productId: element.id,
                                  quantity: 0.0,
                                  unitPrice: 0.0,
                                ),
                              );
                            });
                            setState(() {
                              isSearching = false;
                            });
                          },
                          searching: isSearching,
                          onSelected: () {
                            setState(() => emptyProduct = false);
                          },
                          selected: selectedProduct,
                          all: allProducts,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BeautyTextfield(
                          width: double.maxFinite,
                          height: 50,
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.number,
                          placeholder: "Quantity",
                          // controller: qController,
                          onTap: () {},
                          onChanged: (data) {
                            if (data.isNotEmpty && data != null) {
                              quantity = double.parse(data);
                              amount = (quantity! * unitPrice!);
                              setState(() {});
                            } else {
                              quantity = 0;
                              amount = 0;
                              setState(() {});
                            }
                          },
                          isRequired: emptyQuantity,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                emptyQuantity = true;
                              });

                              return null;
                            } else {
                              setState(() {
                                emptyQuantity = true;
                              });
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BeautyTextfield(
                          width: double.maxFinite,
                          height: 50,
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.number,
                          // controller: uController,
                          placeholder: "Unit Price",
                          onTap: () {},
                          onChanged: (data) {
                            if (data.isNotEmpty && data != null) {
                              unitPrice = double.parse(data);
                              amount = (quantity! * unitPrice!);
                              setState(() {});
                            } else {
                              unitPrice = 0;
                              amount = 0;
                              setState(() {});
                            }
                          },
                          isRequired: emptyUnitPrice,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                emptyUnitPrice = true;
                              });

                              return null;
                            } else {
                              setState(() {
                                emptyUnitPrice = false;
                              });
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BeautyTextfield(
                          width: double.maxFinite,
                          height: 50,
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.text,
                          placeholderStyle: TextStyle(
                              color: amount != null ? black : grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),

                          placeholder: amount != null ? "$amount" : 'Amount',
                          // initialValue: '$amount',
                          enabled: false,
                          onTap: () {},
                          onChanged: (data) {},
                          isRequired: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Create',
                          onTap: () async {
                            if (quantity != null &&
                                unitPrice != null &&
                                !emptyProduct &&
                                !emptyUnitPrice &&
                                !emptyQuantity) {
                              if (newProduct) {
                                products.add(
                                  {
                                    'amount': amount!,
                                    'itemName': selectedProduct[0].itemName,
                                    'productId': selectedProduct[0].productId,
                                    'quantity': quantity!,
                                    'unitPrice': unitPrice!,
                                  },
                                );
                              } else {
                                for (var i = 0; i < products.length; i++) {
                                  if (i == index) {
                                    products[index]['amount'] = amount!;
                                    products[index]['quantity'] = quantity!;
                                    products[index]['unitPrice'] = unitPrice!;
                                    products[index]['productId'] =
                                        selectedProduct[0].productId;
                                    products[index]['itemName'] =
                                        selectedProduct[0].itemName;
                                  }
                                }
                              }

                              // var json =
                              //     products.map((i) => i.toJson()).toList();
                              print(
                                  'Json to send~~~~~~~' + products.toString());
                              params = {apiKeyName: products};
                              final ProgressDialog pr = ProgressDialog(
                                context,
                                type: ProgressDialogType.Normal,
                                isDismissible: false,
                                showLogs: false,
                              );

                              await pr.show();

                              updateDeal(context, id, params, false,
                                  newProduct ? 'Linked' : 'Updated');

                              pr.hide().then((isHidden) {
                                // print(isHidden);
                              });
                            } else {
                              if (selectedProduct.isEmpty) {
                                setState(() {
                                  emptyProduct = true;
                                });
                              }
                              if (quantity == null) {
                                setState(() {
                                  emptyQuantity = true;
                                });
                              }
                              if (unitPrice == null) {
                                setState(() {
                                  emptyUnitPrice = true;
                                });
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
  Future<String?> peopleCheckBoxBottomDialog(BuildContext context,
          PopupDetailsList leadDetails, String navigateFrom) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            List<String> checkedOptions = [];

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName),
                      CheckboxGroup(
                        labels: leadDetails.checkBoxOption,
                        activeColor: deepblue,
                        onChange: (bool isChecked, String label, int index) {},
                        onSelected: (List<String> checked) {
                          checkedOptions = checked;
                        },
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (checkedOptions.isNotEmpty) {
                              params = {leadDetails.apiKeyName: checkedOptions};
                              if (navigateFrom ==
                                  PageNavigatedFrom.COMPANY.getType()) {
                                updateCompany(context, id, params, false);
                              } else if (navigateFrom ==
                                  PageNavigatedFrom.PEOPLE.getType()) {
                                updatePeople(context, id, params, false);
                              }
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  Future<String?> leadCheckBoxBottomDialog(
          BuildContext context, LeadDetailsList leadDetails) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            List<String> checkedOptions = [];

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName!),
                      CheckboxGroup(
                        labels: leadDetails.checkBoxOption,
                        activeColor: deepblue,
                        onChange: (bool isChecked, String label, int index) {},
                        onSelected: (List<String> checked) {
                          checkedOptions = checked;
                        },
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (checkedOptions.isNotEmpty) {
                              params = {
                                leadDetails.apiKeyName!: checkedOptions
                              };
                              updateLead(context, id, params, false);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });

  Future<String?> leadDropdownBottomDialog(
      BuildContext context, LeadDetailsList leadDetails) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          List<String> checkedOptions = [];
          leadDetails.option.forEach((value) {
            checkedOptions.add(value.label);
          });
          String? dropdownValue;
          dropdownValue = leadDetails.value;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    bottomSheetHeader(context, leadDetails.fieldName!),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ButtonTheme(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        child: DropdownButton<String>(
                          hint: Text('$dropdownValue'),
                          isExpanded: true,
                          value: dropdownValue != '' ? dropdownValue : null,
                          elevation: 16,
                          underline: DropdownButtonHideUnderline(
                            child: Container(),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: checkedOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                      ),
                      child: SaveButton(
                        title: 'Update',
                        onTap: () {
                          if (dropdownValue != null) {
                            params = {leadDetails.apiKeyName!: dropdownValue};

                            updateLead(context, id, params, false);
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.88,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          );
        });
  }

  Future<String?> peopleDropdownBottomDialog(
      BuildContext context, PopupDetailsList leadDetails, String navigateFrom) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          List<String> checkedOptions = [];
          leadDetails.option.forEach((value) {
            checkedOptions.add(value.label);
          });
          String? dropdownValue;
          dropdownValue = leadDetails.value;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: new BoxDecoration(
                    color: white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0))),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    bottomSheetHeader(context, leadDetails.fieldName),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ButtonTheme(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        child: DropdownButton<String>(
                          hint: Text('$dropdownValue'),
                          isExpanded: true,
                          value: dropdownValue != '' ? dropdownValue : null,
                          elevation: 16,
                          underline: DropdownButtonHideUnderline(
                            child: Container(),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: checkedOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                      ),
                      child: SaveButton(
                        title: 'Update',
                        onTap: () {
                          if (dropdownValue != null) {
                            params = {leadDetails.apiKeyName: dropdownValue};

                            if (navigateFrom ==
                                PageNavigatedFrom.COMPANY.getType()) {
                              updateCompany(context, id, params, false);
                            } else if (navigateFrom ==
                                PageNavigatedFrom.PEOPLE.getType()) {
                              updatePeople(context, id, params, false);
                            }
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.88,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          );
        });
  }

  Future<String?> leadRadioBottomDialog(
          BuildContext context, LeadDetailsList leadDetails) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            String _verticalGroupValue = leadDetails.value.toString();
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName!),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: RadioGroup<String>.builder(
                          activeColor: deepblue,
                          spacebetween: 40,
                          groupValue: _verticalGroupValue,
                          onChanged: (value) => setState(() {
                            _verticalGroupValue = value!;
                          }),
                          items: leadDetails.checkBoxOption,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (_verticalGroupValue.isNotEmpty) {
                              params = {
                                leadDetails.apiKeyName!: _verticalGroupValue
                              };
                              updateLead(context, id, params, false);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  Future<String?> peopleRadioBottomDialog(BuildContext context,
          PopupDetailsList leadDetails, String navigateFrom) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            String _verticalGroupValue = leadDetails.value.toString();
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: RadioGroup<String>.builder(
                          activeColor: deepblue,
                          spacebetween: 40,
                          groupValue: _verticalGroupValue,
                          onChanged: (value) => setState(() {
                            _verticalGroupValue = value!;
                          }),
                          items: leadDetails.checkBoxOption,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (_verticalGroupValue.isNotEmpty) {
                              params = {
                                leadDetails.apiKeyName: _verticalGroupValue
                              };
                              if (navigateFrom ==
                                  PageNavigatedFrom.COMPANY.getType()) {
                                // company
                                updateCompany(context, id, params, false);
                              } else if (navigateFrom ==
                                  PageNavigatedFrom.PEOPLE.getType()) {
                                updatePeople(context, id, params, false);
                              }
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });

  Future<String?> leadToggleButtonBottomDialog(
          BuildContext context, LeadDetailsList leadDetails) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            bool _switchValue = true;
            _switchValue =
                (leadDetails.value is bool && leadDetails.value == false)
                    ? false
                    : (leadDetails.value is bool && leadDetails.value == true)
                        ? true
                        : false;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName!),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${leadDetails.fieldName}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Switch(
                              activeColor: deepblue,
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            params = {leadDetails.apiKeyName!: _switchValue};
                            updateLead(context, id, params, false);
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });

  Future<String?> peopleToggleButtonBottomDialog(BuildContext context,
          PopupDetailsList leadDetails, String navigateFrom) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            bool _switchValue = true;
            _switchValue =
                (leadDetails.value is bool && leadDetails.value == false)
                    ? false
                    : (leadDetails.value is bool && leadDetails.value == true)
                        ? true
                        : false;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${leadDetails.fieldName}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Switch(
                              activeColor: deepblue,
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            params = {leadDetails.apiKeyName: _switchValue};
                            if (navigateFrom ==
                                PageNavigatedFrom.COMPANY.getType()) {
                              // company
                              updateCompany(context, id, params, false);
                            } else if (navigateFrom ==
                                PageNavigatedFrom.PEOPLE.getType()) {
                              updatePeople(context, id, params, false);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  Future<String?> leadDateBottomDialog(
          BuildContext context,
          LeadDetailsList leadDetails,
          String defaultValue,
          void Function()? onTap) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName!),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext builder) {
                                var now = DateTime.now();

                                return Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.25,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty.all<
                                                      Color>(white),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(width: 8.0)
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                            minimumDate: now,
                                            use24hFormat: false,
                                            onDateTimeChanged: (date) {
                                              if (date != null &&
                                                  date != selectedDate)
                                                setState(() {
                                                  selectedDate = date;

                                                  var datea =
                                                      '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';

                                                  selectedEndDate =
                                                      dateFormater(datea);
                                                });
                                            },
                                            initialDateTime: selectedDate,
                                            minimumYear: now.year,
                                            maximumYear: now
                                                .add(Duration(days: 100))
                                                .year,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          decoration: BoxDecoration(
                              color: appColor.grey,
                              borderRadius: BorderRadius.circular(4.0)),
                          height: 50.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                selectedEndDate == ''
                                    ? "    Select date    "
                                    : "$selectedEndDate",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textHelper.defaultText14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (selectedDate != null) {
                              params = {
                                leadDetails.apiKeyName!:
                                    selectedDate.millisecondsSinceEpoch
                              };
                              updateLead(context, id, params, false);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  Future<String?> activityDateBottomDialog(
          BuildContext context,
          ActivityDetailsModel leadDetails,
          String defaultValue,
          void Function()? onTap) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            String _verticalGroupValue = defaultValue;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext builder) {
                                var now = DateTime.now();

                                return Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.25,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty.all<
                                                      Color>(white),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(width: 8.0)
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                            minimumDate: now,
                                            use24hFormat: false,
                                            onDateTimeChanged: (date) {
                                              if (date != null &&
                                                  date != selectedDate)
                                                setState(() {
                                                  selectedDate = date;
                                                  var datea =
                                                      '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
                                                  selectedEndDate =
                                                      dateFormater(datea);
                                                });
                                            },
                                            initialDateTime: selectedDate,
                                            minimumYear: now.year,
                                            maximumYear: now
                                                .add(Duration(days: 100))
                                                .year,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          decoration: BoxDecoration(
                              color: appColor.grey,
                              borderRadius: BorderRadius.circular(4.0)),
                          height: 50.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                selectedEndDate == ''
                                    ? "    Select date    "
                                    : "$selectedEndDate",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textHelper.defaultText14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (selectedDate != null) {
                              params = {
                                leadDetails.apiKeyName:
                                    selectedDate.millisecondsSinceEpoch
                              };
                              updateDeal(context, id, params, false, '');
                            } else {
                              print('========>getting null');
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });

  Future<String?> peopleDateBottomDialog(
          BuildContext context,
          PopupDetailsList leadDetails,
          String defaultValue,
          void Function()? onTap,
          String navigateFrom) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            String _verticalGroupValue = defaultValue;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext builder) {
                                var now = DateTime.now();

                                return Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.25,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty.all<
                                                      Color>(white),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(width: 8.0)
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                            minimumDate: now,
                                            use24hFormat: false,
                                            onDateTimeChanged: (date) {
                                              if (date != null &&
                                                  date != selectedDate)
                                                setState(() {
                                                  selectedDate = date;

                                                  var datea =
                                                      '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';

                                                  selectedEndDate =
                                                      dateFormater(datea);
                                                });
                                            },
                                            initialDateTime: selectedDate,
                                            minimumYear: now.year,
                                            maximumYear: now
                                                .add(Duration(days: 100))
                                                .year,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          decoration: BoxDecoration(
                              color: appColor.grey,
                              borderRadius: BorderRadius.circular(4.0)),
                          height: 50.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                selectedEndDate == ''
                                    ? "    Select date    "
                                    : "$selectedEndDate",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textHelper.defaultText14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (selectedDate != null) {
                              params = {
                                leadDetails.apiKeyName:
                                    selectedDate.millisecondsSinceEpoch
                              };
                              if (navigateFrom ==
                                  PageNavigatedFrom.COMPANY.getType()) {
                                // company
                                updateCompany(context, id, params, false);
                              } else if (navigateFrom ==
                                  PageNavigatedFrom.PEOPLE.getType()) {
                                updatePeople(context, id, params, false);
                              }
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
  String? startDateRange = null, endDateRange = null;
  Future<String?> leadDateRangeBottomDialog(
          BuildContext context, LeadDetailsList leadDetails) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            List<DateTime>? selectedDateRange;
            String? startDate, endDate;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName!),
                      CustomFormButton(
                        label: startDateRange == null
                            ? "    Select date    "
                            : "$startDateRange - $endDateRange",
                        onTap: () async {
                          final List<DateTime> picked =
                              await DateRangePicker.showDatePicker(
                                  context: context,
                                  initialFirstDate: new DateTime.now(),
                                  initialLastDate: (new DateTime.now())
                                      .add(new Duration(days: 7)),
                                  firstDate: new DateTime(2015),
                                  lastDate:
                                      new DateTime(DateTime.now().year + 2));
                          if (picked != null && picked.length == 2) {
                            startDateRange =
                                '${picked[0].day}/${picked[0].month}/${picked[0].year}';
                            endDateRange =
                                '${picked[1].day}/${picked[1].month}/${picked[1].year}';
                            selectedDateRange = picked;
                            setState(() {});
                            print(picked);
                          }
                        },
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (selectedDateRange != null) {
                              params = {
                                leadDetails.apiKeyName!: [
                                  selectedDateRange![0].millisecondsSinceEpoch,
                                  selectedDateRange![1].millisecondsSinceEpoch
                                ]
                              };
                              updateLead(context, id, params, false);
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });

  Future<String?> peopleDateRangeBottomDialog(BuildContext context,
          PopupDetailsList leadDetails, String navigateFrom) =>
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            DateTimeRange? selectedDateRange;
            String? startDate, endDate;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: new BoxDecoration(
                      color: white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bottomSheetHeader(context, leadDetails.fieldName),
                      GestureDetector(
                        onTap: () {
                          DateTimeRangePicker(
                              startText: "From",
                              endText: "To",
                              doneText: "Yes",
                              cancelText: "Cancel",
                              // interval: 5,
                              initialStartTime: DateTime.now(),
                              initialEndTime:
                                  DateTime.now().add(Duration(days: 100)),
                              mode: DateTimeRangePickerMode.dateAndTime,
                              minimumTime:
                                  DateTime.now().subtract(Duration(days: 5)),
                              maximumTime:
                                  DateTime.now().add(Duration(days: 125)),
                              use24hFormat: false,
                              onConfirm: (start, end) {
                                setState(() {
                                  selectedDateRange =
                                      DateTimeRange(start: start, end: end);
                                  startDate =
                                      '${start.day}/${start.month}/${start.year} ${start.hour}:${start.minute}';
                                  endDate =
                                      '${end.day}/${end.month}/${end.year} ${end.hour}:${end.minute}';
                                });
                              }).showPicker(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          decoration: BoxDecoration(
                              color: appColor.grey,
                              borderRadius: BorderRadius.circular(4.0)),
                          height: 50.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                startDate == null
                                    ? "    Select date range    "
                                    : "From  $startDate  To  $endDate",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textHelper.defaultText14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                        ),
                        child: SaveButton(
                          title: 'Update',
                          onTap: () {
                            if (endDate != null) {
                              params = {
                                leadDetails.apiKeyName: [
                                  selectedDateRange!
                                      .start.millisecondsSinceEpoch,
                                  selectedDateRange!.end.millisecondsSinceEpoch
                                ]
                              };
                              if (navigateFrom ==
                                  PageNavigatedFrom.COMPANY.getType()) {
                                // company
                                updateCompany(context, id, params, false);
                              } else if (navigateFrom ==
                                  PageNavigatedFrom.PEOPLE.getType()) {
                                updatePeople(context, id, params, false);
                              }
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          });
}

_getImage({required String title, required Function() onTap}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(width: 0.2, color: lightBlue),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Icon(
              title == 'Gallery' ? Boxicons.bxs_image_add : Icons.camera,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
      Text(title,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300)),
    ],
  );
}

CustomBottomSheet customBottomSheet = new CustomBottomSheet(id: '');
