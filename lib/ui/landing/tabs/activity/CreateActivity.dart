import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/bloc_provider.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/Stage.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/models/roles_wise_userL_lst.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/landing/tabs/activity/ActivityTypeList.dart';
import 'package:salessimplify/ui/landing/tabs/activity/role_wise_users.dart';
import 'package:salessimplify/ui/widgetHelper/beauty_text_form_field.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/deal_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/lead_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/people_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/save_button.dart';
import 'package:salessimplify/ui/widgetHelper/searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'bloc/create_activity_bloc.dart';

class CreateActivity extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static String ROUTE_CREATE_ACTIVITY = "route/create_activity";
  const CreateActivity({Key? key}) : super(key: key);

  @override
  _CreateActivityState createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: CreateActivityBloc(context: context),
        child: MainContainer(),
      ),
    );
  }
}

// ignore: must_be_immutable
class MainContainer extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static String ROUTE_CREATE_ACTIVITY = "route/create_activity";

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  TextEditingController _guests = TextEditingController();
  TextEditingController _desc = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  DateTime dateNow = DateTime.now();
  Map<String, dynamic> params = {};
  late FocusNode activityNameFocusNode;
  late CreateActivityBloc _bloC;
  int dateType = 0;
  bool isSearching = false;
  final TextEditingController _companySearchBarController =
      TextEditingController();
  final TextEditingController _leadSearchBarController =
      TextEditingController();
  final TextEditingController _peopleSearchBarController =
      TextEditingController();
  final TextEditingController _dealSearchBarController =
      TextEditingController();
  List<SearchCompanyNew> selectedCompany = [], allCompanies = [];
  List<SearchLeadNew> selectedLead = [], allLeads = [];
  List<SearchPeopleNew> selectedPeople = [], allPeoples = [];
  List<SearchResult> selectedDeal = [], allDeals = [];
  bool isError = false;
  @override
  void didChangeDependencies() {
    _bloC = BlocProvider.of<CreateActivityBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _bloC.dispose();
    activityNameFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<Repository>().getProfile();
    context.read<Repository>().getRolesWiseUserList();
    context.read<Repository>().setActivitySymbol(null);
    //context.read<Repository>().setSearchResult(null);
    context.read<Repository>().setSearchPeopleResult(null);
    //context.read<Repository>().setSelectedPeopleSearch(null);
    //context.read<Repository>().setSelectedLeadSearch(null);
    context.read<Repository>().setSelectedCompanySearch(null);
    context.read<Repository>().setDateRange(null);
    context.read<Repository>().setSelectedDropDown(null);
    activityNameFocusNode = FocusNode();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // setState(() {
    //   if (args.value is PickerDateRange) {
    //     _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
    //         // ignore: lines_longer_than_80_chars
    //         ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    //   } else if (args.value is DateTime) {
    //     _selectedDate = args.value.toString();
    //   } else if (args.value is List<DateTime>) {
    //     _dateCount = args.value.length.toString();
    //   } else {
    //     _rangeCount = args.value.length.toString();
    //   }
    // });
  }

  String selectedEndDate = '';
  List<Stage>? stages;
  @override
  Widget build(BuildContext context) {
    _bloC.activitySymbol = context.watch<Repository>().selectedActivitySymbol;
    // _bloC.selectedSearch = context.watch<Repository>().selectedSearchResult;
    stages = context.watch<Repository>().stages;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "Create Activity",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  ActivityTypeList(),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Activity Name*', style: textHelper.heading16),
                  ),
                  BeautyTextfield(
                      width: double.maxFinite,
                      height: 50,
                      autofocus: false,
                      isRequired: isError,
                      focusNode: activityNameFocusNode,
                      key: Key(_bloC.activitySymbol == null
                          ? ''
                          : '${_bloC.activitySymbol!.name}'),
                      initialValue: _bloC.activitySymbol == null
                          ? ''
                          : '${_bloC.activitySymbol!.name}',
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.text,
                      placeholder: _bloC.activitySymbol == null
                          ? "Activity Name"
                          : "Activity Name - ${_bloC.activitySymbol!.name}",
                      onChanged: (data) {
                        // ignore: unnecessary_null_comparison
                        if (data != null) {
                          setState(() {
                            _bloC.activityName = data;
                          });
                        }
                        _formKey.currentState!.validate();
                        print(_bloC.activityName);
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
                                selectedDate = dateNow.add(Duration(hours: 1));
                              });
                            },
                            currentdatetype: 1),
                        datePickerUi(
                            title: 'In 3hrs',
                            onTap: () {
                              setState(() {
                                dateType = 2;
                                selectedEndDate = '';
                                selectedDate = dateNow.add(Duration(hours: 3));
                              });
                            },
                            currentdatetype: 2),
                        datePickerUi(
                            title: 'Tomorrow',
                            onTap: () {
                              setState(() {
                                dateType = 3;
                                selectedEndDate = '';
                                selectedDate = dateNow.add(Duration(days: 1));
                              });
                            },
                            currentdatetype: 3),
                        GestureDetector(
                          onTap: () {
                            showDatePicker();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedEndDate == ''
                                        ? "    Custom    "
                                        : "$selectedEndDate".substring(0, 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: textHelper.defaultText14,
                                  ),
                                  selectedEndDate != ''
                                      ? Text(
                                          "$selectedEndDate".substring(11, 19),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Guests", style: textHelper.heading16),
                  ),
                  BeautyTextfield(
                    width: double.maxFinite,
                    height: 50,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.text,
                    placeholder: "Enter email",
                    controller: _guests,
                    onTap: () {
                      // print('Click');
                    },
                    onChanged: (data) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Description', style: textHelper.heading16),
                  ),
                  BeautyTextfield(
                    width: double.maxFinite,
                    height: 70,
                    duration: Duration(milliseconds: 300),
                    inputType: TextInputType.text,
                    placeholder: "Description",
                    controller: _desc,
                    maxLines: 3,
                    onTap: () {},
                    onChanged: (data) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('User*', style: textHelper.heading16),
                  ),
                  RoleWiseUserWidget(
                      _bloC.roleWiseSelectedDropDown, onUsersDropDownSelect),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Deal', style: textHelper.heading16),
                  ),
                  SizedBox(height: 10.0),
                  DealSearchableDropdown(
                      key: const ValueKey('Deal'),
                      searchBarTitle: 'Search Deal',
                      searchBarController: _dealSearchBarController,
                      onSearchTextChanged: (value) async {
                        setState(() {
                          isSearching = true;
                        });
                        allDeals = await Repository.getDealNewSearch(value);
                        setState(() {
                          isSearching = false;
                        });
                      },
                      searching: isSearching,
                      onSelected: () {},
                      selected: selectedDeal,
                      all: allDeals),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: Text('Lead', style: textHelper.heading16),
                  ),
                  LeadSearchableDropdown(
                      key: const ValueKey('Lead'),
                      searchBarTitle: 'Search Lead',
                      searchBarController: _leadSearchBarController,
                      onSearchTextChanged: (value) async {
                        setState(() {
                          isSearching = true;
                        });
                        allLeads = await Repository.getLeadNewSearch(value);
                        setState(() {
                          isSearching = false;
                        });
                      },
                      searching: isSearching,
                      onSelected: () {},
                      selected: selectedLead,
                      all: allLeads),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: Text('People', style: textHelper.heading16),
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
                    onSelected: () {},
                    selected: selectedPeople,
                    all: allPeoples,
                    onClear: () {
                      selectedPeople.clear();
                    },
                    newPerson: (bool) {},
                    withNew: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: Text('Company', style: textHelper.heading16),
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
                      onSelected: () {},
                      selected: selectedCompany,
                      all: allCompanies),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SaveButton(
                      onTap: () {
                        activityNameFocusNode.unfocus();
                        if (_formKey.currentState!.validate() && !isError) {
                          if (_bloC.roleWiseSelectedDropDown != null &&
                              _bloC.activitySymbol?.name != null &&
                              selectedDate != null) {
                            submitActivityData(context);
                          } else {
                            toastHelper.toastWithTitleAndColor(
                                "Select the time!", black);
                          }
                        } else {
                          toastHelper.toastWithTitleAndColor(
                              "Please enter all the mandatory details!", black);
                        }
                      },
                      width: MediaQuery.of(context).size.width * 0.94,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: dateType == currentdatetype
                ? Border.all(width: 1, color: deepblue)
                : null,
            color: bgColor),
        child: AutoSizeText(title,
            style: textHelper.defaultText, maxLines: 1, maxFontSize: 14),
      ),
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          var now = DateTime.now();

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
                      mode: CupertinoDatePickerMode.dateAndTime,
                      minimumDate: now,
                      use24hFormat: false,
                      onDateTimeChanged: (date) {
                        // ignore: unnecessary_null_comparison
                        if (date != null && date != selectedDate)
                          setState(() {
                            selectedDate = date;

                            var datea =
                                '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
                            selectedEndDate = dateFormater(datea);
                            _bloC.selectedDateRange = DateTimeRange(
                                start: now.add(Duration(days: 1)), end: date);
                            dateType = 4;
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
        });
  }

  dateFormater(String date) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  onDropDownSelect(DropDownModel value) {
    _bloC.selectedDropDown = value;
  }

  onDatePickerSelected(DateTimeRange dateTimeRange) {
    _bloC.selectedDateRange = dateTimeRange;
  }

  onUsersDropDownSelect(RoleWiseUser value) {
    _bloC.roleWiseSelectedDropDown = value;
  }

  submitActivityData(BuildContext context) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    await pr.show();
    if (_bloC.activityName == null || _bloC.activityName == '') {
      _bloC.activityName = _bloC.activitySymbol!.name;
    }
    if (_bloC.selectedPeople == null) {
      _bloC.selectedPeople = "";
    }
    if (_bloC.selectedLead == null) {
      _bloC.selectedLead = "";
    }
    if (selectedCompany == null) {
      _bloC.selectedCompany = "";
    }
    List<String> attendees = [];

    attendees.add(_guests.text);
    params["name"] = _bloC.activityName;
    params["description"] = _desc.text;
    params["attendees"] = attendees;
    params["activityType"] = _bloC.activitySymbol!.getId();
    params["assignToUser"] = _bloC.roleWiseSelectedDropDown!.id;
    params["scheduleAt"] = selectedDate.millisecondsSinceEpoch;
    params["duration"] = 0;
    params["people"] = selectedPeople.isNotEmpty ? selectedPeople[0].id : '';
    params["company"] = selectedCompany.isNotEmpty ? selectedCompany[0].id : '';
    params["lead"] = selectedLead.isNotEmpty ? selectedLead[0].id : '';

    setState(() {
      _bloC.isProcessing = true;
    });

    var data = await context.read<Repository>().createActivity(params);

    setState(() {
      _bloC.isProcessing = false;
    });
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    if (data is bool && data == true) {
      Navigator.of(context).pop();
    }
  }
}
