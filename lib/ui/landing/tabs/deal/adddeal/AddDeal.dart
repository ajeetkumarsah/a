import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/bloc_provider.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/landing/tabs/activity/UserDropDown.dart';
import 'package:salessimplify/ui/widgetHelper/beauty_text_form_field.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/custom_tag.dart';
import 'package:salessimplify/ui/widgetHelper/people_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/save_button.dart';
import 'package:salessimplify/ui/widgetHelper/searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/tags_textfield.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import '../Pipelines.dart';
import 'StageList.dart';
import 'bloC/add_deal_bloc.dart';

class AddDeal extends StatefulWidget {
  static String ROUTE_ADD_DEAL = "route/AddDeal";
  const AddDeal({Key? key}) : super(key: key);

  @override
  _AddDealState createState() => _AddDealState();
}

class _AddDealState extends State<AddDeal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: AddDealBloc(context: context),
        child: MainContainer(),
      ),
    );
  }
}

// ignore: must_be_immutable
class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final TextEditingController _searchBarController = TextEditingController();
  TextEditingController _dealNameController = TextEditingController();
  TextEditingController _dealAmountController = TextEditingController();
  DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  final _formKey = GlobalKey<FormState>();
  late AddDealBloc _bloC;
  int dealAmount = 0;
  List<SearchPeopleNew> selectedPeople = [], allPeoples = [];
  List<SearchCompanyNew> selectedCompany = [], allCompanies = [];
  List<Option> filteredTags = [], selectedTags = [], allTags = [];
  bool isSearching = false, newPerson = true;
  final TextEditingController _peopleSearchBarController =
      TextEditingController();
  final TextEditingController _companySearchBarController =
      TextEditingController();

  List<String> selectedTagsValue = [];
  String? email = 'email', phone = 'phone', countryCode = '+91';
  bool emptyDeal = false, emptyCompany = false, emptyPerson = false;
  @override
  void didChangeDependencies() {
    _bloC = BlocProvider.of<AddDealBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _bloC.dispose();
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
  }

  Future getTags() async {
    var data = await Repository.getInstance().getNewTags(type: "deal");
    // data.forEach((v) => allTags.add(v));
    data.forEach((option) {
      allTags.add(
        Option(
          colorCode: option.colorCode,
          label: option.name,
          value: option.value ?? option.name,
          name: option.name,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // _bloC.selectedCompany =
    //     context.watch<Repository>().selectedCompanySearch as SearchCompanyNew?;
    // stages = context.watch<Repository>().stages;
    var deal = context.watch<Repository>().deals;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Add deal",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
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
                      onClear: () {
                        setState(() {
                          email = 'email';
                          phone = 'phone';
                          selectedPeople.clear();
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
                          setState(() {
                            emptyPerson = false;
                          });
                        }
                      },
                      selected: selectedPeople,
                      all: allPeoples,
                      newPerson: (value) {
                        newPerson = value;
                      },
                      withNew: true,
                      isRequired: emptyPerson,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            emptyPerson = true;
                          });

                          return null;
                        } else {
                          setState(() {
                            emptyPerson = false;
                          });
                          return null;
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    child: Text('Company *', style: textHelper.heading16),
                  ),
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
                      onSelected: () {
                        if (selectedCompany.isNotEmpty) {
                          setState(() {
                            emptyCompany = false;
                          });
                        }
                      },
                      selected: selectedCompany,
                      all: allCompanies,
                      isRequired: emptyCompany,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            emptyCompany = true;
                          });

                          return null;
                        } else {
                          setState(() {
                            emptyCompany = false;
                          });
                          return null;
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 12.0, right: 12.0),
                    child: Text('Deal Name *', style: textHelper.heading16),
                  ),
                  BeautyTextfield(
                      width: double.maxFinite,
                      height: 50,
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      placeholder: "Enter deal name",
                      isRequired: emptyDeal,
                      controller: _dealNameController,
                      onTap: () {
                        // print('Click');
                      },
                      onChanged: (t) {
                        if (t.isNotEmpty) {
                          setState(() {
                            emptyDeal = false;
                          });
                        }
                        // print(t);
                        // _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            emptyDeal = true;
                          });

                          return null;
                        } else {
                          setState(() {
                            emptyDeal = false;
                          });
                          return null;
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Phone ', style: textHelper.heading16),
                  ),
                  BeautyTextfield(
                    width: double.maxFinite,
                    height: 50,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.number,
                    placeholder: "Enter phone number",
                    isRequired: false,
                    countryCode: true,
                    enabled: newPerson,
                    controller: TextEditingController(
                        text: phone == 'phone'
                            ? ''
                            : phone!.substring(2, phone.toString().length)),
                    countryOnChanged: (CountryCode value) {
                      countryCode = value.dialCode;
                    },
                    onTap: () {},
                    onChanged: (data) {
                      if (data != null && countryCode != null)
                        phone = (countryCode! + data);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Email ', style: textHelper.heading16),
                  ),
                  BeautyTextfield(
                    width: double.maxFinite,
                    height: 50,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.emailAddress,
                    placeholder: "Enter email id",
                    isRequired: false,
                    enabled: newPerson,
                    controller: TextEditingController(
                        text: email == 'email' ? '' : email),
                    onTap: () {},
                    onChanged: (t) {
                      email = t;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Owner', style: textHelper.heading16),
                  ),
                  UserDropDown(_bloC.selectedDropDown, onDropDownSelect),

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
                    onTap: () {
                      // print('Click');
                    },
                    onChanged: (t) {
                      dealAmount = int.parse(t);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Pipeline*', style: textHelper.heading16),
                  ),
                  Pipelines(onSelect),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child:
                        Text('Pipeline Stages*', style: textHelper.heading16),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: StageList((Stage stage) {
                      _bloC.stageId = stage.id;
                      // print('~~~~~~~~~stage Id:- ' + stage.id);
                    }),
                  ),
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
                                        _bloC.selectedEndDate == ''
                                            ? "Expacted close date"
                                            : "${_bloC.selectedEndDate}",
                                        style: _bloC.selectedEndDate == ''
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
                  // SelectTag(handler: onDropDownClicked, type: "deal"),

                  Container(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 12.0, right: 12.0, bottom: 6.0),
                    child: CustomTag(
                      allTags: allTags,
                      selectedTags: selectedTags,
                    ),
                    //  TaggedSearchField(
                    //     key: const ValueKey('tags'),
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
                    //     onSelected: () {},
                    //     selected: selectedTags,
                    //     filtered: filteredTags,
                    //     all: allTags),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: SaveButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          createDeal();
                        } else {
                          toastHelper.toastWithTitleAndColor(
                              "Please enter all the mandatory details!", black);
                        }
                      },
                    ),
                  ),
                ],
              ),
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
                          _bloC.endDate = selectedDate.millisecondsSinceEpoch;

                          _bloC.selectedEndDate =
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
    _bloC.selectedDropDown = value;
  }

  onSelect(DropDownModel dropDownModel) {
    _bloC.pipelineId = dropDownModel.value;
  }

  setStages(List<Stage> list) {
    _bloC.stages = list;
  }

  createDeal() async {
    // print(' Company ${_bloC.selectedCompany?.name ?? 'null'}');
    Map<String, dynamic> params = {};
    if (_dealNameController.text.isNotEmpty &&
        selectedCompany.isNotEmpty &&
        _bloC.pipelineId != null &&
        _bloC.stageId != null &&
        selectedPeople.isNotEmpty) {
      if (selectedTags.isNotEmpty) {
        selectedTags.forEach((v) {
          selectedTagsValue.add(v.value);
        });
      }
      params["title"] = _dealNameController.text;
      params["people"] = selectedPeople[0].id;
      params["company"] = selectedCompany[0].id;
      params["pipelineId"] = _bloC.pipelineId;
      params["owner"] = _bloC.selectedDropDown!.value;
      params["stageId"] = _bloC.stageId;
      params["expectedCloseDate"] = _bloC.endDate != null ? _bloC.endDate : '';
      params["visibleTo"] = "Public";
      params["dealCurrency"] = "INR";
      params["tags"] = selectedTagsValue;
      params["dealValue"] = dealAmount;
      if (email != 'email') {
        params['email'] = [
          {'email': email}
        ];
      } else {
        params['email'] = [];
      }

      if (phone != 'phone') {
        params['phone'] = [
          {'phone': phone}
        ];
      } else {
        params['phone'] = [];
      }
      print('Phone=====>$phone Email=====>$email');
      params["leadData"] = {
        "value": selectedPeople[0].name,
        "type": newPerson ? "new" : 'old'
      };

      final ProgressDialog pr = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false,
      );
      await pr.show();

      var data = await context.read<Repository>().createDeal(params);

      pr.hide().then((isHidden) {
        print(isHidden);
      });
      if (data is bool && data == true) {
        Navigator.pop(context, true);
      }
    } else {
      toastHelper.toastWithTitleAndColor(
          "Please enter all the mandatory details!", black);
    }
  }
}
