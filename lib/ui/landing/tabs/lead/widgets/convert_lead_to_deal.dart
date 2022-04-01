import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/activity/UserDropDown.dart';
import 'package:salessimplify/ui/landing/tabs/deal/Pipelines.dart';
import 'package:salessimplify/ui/landing/tabs/deal/adddeal/StageList.dart';
import 'package:salessimplify/ui/widgetHelper/beauty_text_form_field.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/custom_tag.dart';
import 'package:salessimplify/ui/widgetHelper/people_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/save_button.dart';
import 'package:salessimplify/ui/widgetHelper/searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/tags_textfield.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';

class ConvertLeadToDeal extends StatefulWidget {
  final List<SearchCompanyNew> selectedCompany;
  final List<SearchPeopleNew> selectedPeople;
  final List<Option> selectedTags;
  final String dealName, phoneNumber, emailId, leadId;
  ConvertLeadToDeal({
    Key? key,
    required this.selectedCompany,
    required this.selectedPeople,
    required this.selectedTags,
    required this.emailId,
    required this.dealName,
    required this.phoneNumber,
    required this.leadId,
  }) : super(key: key);
  @override
  _ConvertLeadToDealState createState() => _ConvertLeadToDealState();
}

class _ConvertLeadToDealState extends State<ConvertLeadToDeal> {
  final TextEditingController _searchBarController = TextEditingController();
  TextEditingController _dealNameController = TextEditingController();
  TextEditingController _dealAmountController = TextEditingController();
  DateTime selectedDate = DateTime.now().add(Duration(days: 2));

  int dealAmount = 0;
  List<SearchPeopleNew> selectedPeople = [], allPeoples = [];
  List<SearchCompanyNew> selectedCompany = [], allCompanies = [];
  bool isSearching = false, newPerson = true;
  final TextEditingController _peopleSearchBarController =
      TextEditingController();
  final TextEditingController _companySearchBarController =
      TextEditingController();
  List<Option> selectedTags = [], filteredTags = [], allTags = [];
  List<Stage> stages = [];
  String? stageId, pipelineId, selectedEndDate = '';
  String? email = 'email', phone = 'phone';
  int? expectedCloseDate;
  List<String> selectedTagsValue = [];
  int? endDate;
  DropDownModel? selectedDropDown;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<Repository>().getProfile();
    context.read<Repository>().setActivitySymbol(null);
    context.read<Repository>().setSearchResult(null);
    context.read<Repository>().setSearchPeopleResult(null);
    context.read<Repository>().setSelectedPeopleSearch(null);
    context.read<Repository>().setSelectedLeadSearch(null);
    context.read<Repository>().setSelectedCompanySearch(null);
    context.read<Repository>().setDateRange(null);
    context.read<Repository>().setSelectedDropDown(null);
    getTags();
    getAllData();
  }

  getAllData() {
    selectedCompany = widget.selectedCompany;
    selectedPeople = widget.selectedPeople;
    selectedTags = widget.selectedTags;
    email = widget.emailId;
    _dealNameController.text = widget.dealName;
    phone = widget.phoneNumber;
  }

  Future getTags() async {
    var data = await Repository.getInstance().getNewTags(type: "deal");

    data.forEach((element) {
      allTags.add(
        Option(
            colorCode: element.colorCode,
            label: element.name,
            value: element.value,
            name: element.name),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var deal = context.watch<Repository>().deals;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Convert to deal",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Deal Name *', style: textHelper.heading16),
                ),
                BeautyTextfield(
                  width: double.maxFinite,
                  height: 50,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text,
                  placeholder: "Enter deal name",
                  controller: _dealNameController,
                  onTap: () {},
                  onChanged: (t) {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Deal Value', style: textHelper.heading16),
                ),
                BeautyTextfield(
                  width: double.maxFinite,
                  height: 50,
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.number,
                  placeholder: "Enter deal amount",
                  controller: _dealAmountController,
                  onTap: () {},
                  onChanged: (t) {
                    dealAmount = int.parse(t);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Owner', style: textHelper.heading16),
                ),
                UserDropDown(selectedDropDown, onDropDownSelect),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Expected Close Date',
                        style: textHelper.heading16)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                          color: appColor.grey,
                          borderRadius: BorderRadius.circular(4.0)),
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      selectedEndDate == ''
                                          ? "Expacted close date"
                                          : "$selectedEndDate",
                                      style: selectedEndDate == ''
                                          ? textHelper.hintText
                                          : textHelper.defaultText,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Tags', style: textHelper.heading16),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, left: 10, right: 10),
                  child: CustomTag(
                    allTags: allTags,
                    selectedTags: selectedTags,
                  ),
                  //  TaggedSearchField(
                  //     key: const ValueKey('key'),
                  //     searchBarTitle: 'Search tags',
                  //     searchBarController: _searchBarController,
                  //     onSearchTextChanged: (text) {
                  //       filteredTags.clear();
                  //       setState(() {
                  //         if (text.isEmpty) {
                  //           return;
                  //         }
                  //         for (Option _state in allTags) {
                  //           if (_state.label
                  //               .replaceAll(RegExp(r'[^\w\s]+'), '')
                  //               .toLowerCase()
                  //               .contains(text)) filteredTags.add(_state);
                  //         }
                  //       });
                  //     },
                  //     onSelected: () {
                  //       selectedTagsValue = [];

                  //       selectedTags
                  //           .forEach((v) => selectedTagsValue.add(v.value));
                  //     },
                  //     selected: selectedTags,
                  //     filtered: filteredTags,
                  //     all: allTags),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Text('Person Name*', style: textHelper.heading16),
                ),
                PeopleSearchableDropdown(
                  key: const ValueKey('People'),
                  searchBarTitle: 'Search People',
                  searchBarController: _peopleSearchBarController,
                  onSearchTextChanged: (value) async {
                    setState(() {
                      isSearching = true;
                    });
                    allPeoples = await Repository.getPeopleNewSearch(value);
                    setState(() {
                      isSearching = false;
                    });
                  },
                  searching: isSearching,
                  onSelected: () {
                    if (selectedPeople.isNotEmpty) {
                      if (selectedPeople[0].email!.isNotEmpty &&
                          selectedPeople[0].phone!.isNotEmpty) {
                        setState(() {
                          email = selectedPeople[0].email![0];
                          phone = selectedPeople[0].phone![0].toString();
                        });
                      } else {
                        setState(() {});
                      }
                    }
                  },
                  selected: selectedPeople,
                  all: allPeoples,
                  onClear: () {
                    setState(() {
                      email = 'email';
                      phone = 'phone';
                      selectedPeople.clear();
                      newPerson = true;
                    });
                  },
                  newPerson: (value) {
                    newPerson = value;
                  },
                  withNew: true,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Phone ', style: textHelper.heading16),
                ),
                newPerson
                    ? BeautyTextfield(
                        width: double.maxFinite,
                        height: 50,
                        duration: Duration(milliseconds: 300),
                        inputType: TextInputType.number,
                        placeholder: "Enter phone number",
                        // controller: _dealAmountController,
                        onTap: () {
                          // print('Click');
                        },
                        onChanged: (t) {
                          phone = t;
                        },
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                            color: appColor.grey,
                            borderRadius: BorderRadius.circular(4.0)),
                        height: 50.0,
                        child: Text(phone!,
                            style: phone == 'phone'
                                ? textHelper.hintText
                                : textHelper.defaultText),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Email', style: textHelper.heading16),
                ),
                newPerson
                    ? BeautyTextfield(
                        width: double.maxFinite,
                        height: 50,
                        duration: Duration(milliseconds: 300),
                        inputType: TextInputType.emailAddress,
                        placeholder: "Enter email id",
                        // controller: _dealAmountController,
                        onTap: () {
                          // print('Click');
                        },
                        onChanged: (t) {
                          email = t;
                        },
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                            color: appColor.grey,
                            borderRadius: BorderRadius.circular(4.0)),
                        height: 50.0,
                        child: Text(email!,
                            style: email == 'email'
                                ? textHelper.hintText
                                : textHelper.defaultText),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Company *', style: textHelper.heading16),
                ),
                SizedBox(height: 10),
                SearchableDropdown(
                    key: const ValueKey('Company'),
                    searchBarTitle: 'Search Company',
                    searchBarController: _companySearchBarController,
                    onSearchTextChanged: (value) async {
                      setState(() {
                        isSearching = true;
                      });
                      allCompanies =
                          await Repository.getCompanyNewSearch(value);
                      setState(() {
                        isSearching = false;
                      });
                    },
                    searching: isSearching,
                    onSelected: () {},
                    selected: selectedCompany,
                    all: allCompanies),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Pipeline*', style: textHelper.heading16),
                ),
                Pipelines(onSelect),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Pipeline Stages*', style: textHelper.heading16),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 16),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: StageList((Stage stage) {
                    stageId = stage.id;
                    // print('~~~~~~~~~stage Id:- ' + stage.id);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: SaveButton(
                    title: 'Convert',
                    onTap: () {
                      createDeal();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        var now = DateTime.now();
        var today = new DateTime.now().add(Duration(days: 2));
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(white),
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
                    mode: CupertinoDatePickerMode.date,
                    minimumDate: today.subtract(Duration(days: 1)),
                    onDateTimeChanged: (date) {
                      if (date != null && date != selectedDate)
                        setState(() {
                          selectedDate = date;
                          endDate = selectedDate.millisecondsSinceEpoch;

                          selectedEndDate =
                              '${date.day}/${date.month}/${date.year}';
                        });
                    },
                    initialDateTime: selectedDate,
                    minimumYear: now.year,
                    maximumYear: now.add(Duration(days: 100)).year,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DropDownModel? selectedTag;
  onDropDownClicked(DropDownModel dropDownModel) {
    selectedTag = dropDownModel;
  }

  onDropDownSelect(DropDownModel value) {
    selectedDropDown = value;
  }

  onSelect(DropDownModel dropDownModel) {
    pipelineId = dropDownModel.value;
  }

  setStages(List<Stage> list) {
    stages = list;
  }

  createDeal() async {
    Map<String, dynamic> params = {};
    if (_dealNameController.text.isNotEmpty &&
        selectedCompany.isNotEmpty &&
        pipelineId != null &&
        stageId != null &&
        selectedPeople.isNotEmpty) {
      if (selectedTags.isNotEmpty) {
        selectedTags.forEach((v) {
          selectedTagsValue.add(v.value);
        });
      }
      params["title"] = _dealNameController.text;
      params["people"] = selectedPeople[0].id;
      params["company"] = selectedCompany[0].id;
      params["pipelineId"] = pipelineId;
      params["owner"] = selectedDropDown!.value;
      params["stageId"] = stageId;
      params["expectedCloseDate"] = endDate != null ? endDate : '';
      params["visibleTo"] = "Public";
      params["dealCurrency"] = "INR";
      params["tags"] = selectedTagsValue;
      params["dealValue"] = dealAmount;
      if (email != 'email' && email != '' && email != null) {
        params['email'] = [
          {'email': email}
        ];
      } else {
        params['email'] = [];
      }
      if (phone != 'phone' && phone != '' && phone != null) {
        params['phone'] = [
          {'phone': phone}
        ];
      } else {
        params['phone'] = [];
      }
      params["leadData"] = {
        "value": selectedPeople[0].name,
        '_id': widget.leadId,
        "type": newPerson ? "new" : 'old'
      };

      final ProgressDialog pr = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false,
      );
      int count = 0;
      await pr.show();

      var data = await context.read<Repository>().convertLeadToDeal(params);

      pr.hide().then((isHidden) {
        print(isHidden);
      });
      if (data is bool && data == true) {
        toastHelper.toastWithTitleAndColor(
            "Successfully converted!", greenColor);
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      } else {
        toastHelper.toastWithTitleAndColor("Failed to convert!", redColor);
      }
    } else {
      toastHelper.toastWithTitleAndColor(
          "Please enter all the mandatory details!", black);
    }
  }
}
