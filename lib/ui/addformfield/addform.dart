//@dart=2.9
import 'package:country_code_picker/country_code_picker.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:salessimplify/constants/fieldinputtype.dart';
import 'package:salessimplify/controller/color.dart';
import 'package:salessimplify/helper/text_helper.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/SearchResult.dart';
import 'package:salessimplify/models/addformfields.dart';
import 'package:salessimplify/models/dropdownmodel.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:salessimplify/ui/addformfield/widget/form_loader.dart';
import 'package:salessimplify/ui/landing/tabs/deal/DealsPage.dart';
import 'package:salessimplify/ui/widgetHelper/beauty_text_form_field.dart';
import 'package:salessimplify/ui/widgetHelper/bottomsheet.dart';
import 'package:salessimplify/ui/widgetHelper/custom_appbar.dart';
import 'package:salessimplify/ui/widgetHelper/custom_form_button.dart';
import 'package:salessimplify/ui/widgetHelper/custom_tag.dart';
import 'package:salessimplify/ui/widgetHelper/drop_down_widget.dart';
import 'package:provider/provider.dart';
import 'package:salessimplify/ui/widgetHelper/people_searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/save_button.dart';
import 'package:salessimplify/ui/widgetHelper/searchable_dropdown.dart';
import 'package:salessimplify/ui/widgetHelper/tags_textfield.dart';
import 'package:salessimplify/ui/widgetHelper/toast_helper.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class Animal {
  final int id;
  final String name;

  Animal({
    @required this.id,
    @required this.name,
  });
}

class AddForm extends StatefulWidget {
  static String ROUTE_ADD_FORM = "/route/addform";

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  String addFormType = "";
  List<String> selectedTagsValue = [];
  List<Option> selectedTags = [], filteredTags = [], allTags = [];
  List<AddFormFields> list = [];
  final formkey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, TextEditingController> controllers = {};
  Map<String, dynamic> selectionData = {};
  List<SearchPeopleNew> selectedPeople = [], allPeoples = [];
  final TextEditingController _peopleSearchBarController =
      TextEditingController();
  final TextEditingController _companySearchBarController =
      TextEditingController();
  List<SearchCompanyNew> selectedCompany = [], allCompanies = [];
  bool isSearching = false,
      _validate = false,
      isError = false,
      isNew = false,
      _switchValue = false;

  final TextEditingController _searchBarController = TextEditingController();
  Map<String, dynamic> paramsforPerson = {};
  String emailId = '', owner, countryCode = '+91';
  int phone;
  List<String> checkedOptions = [];
  String _verticalGroupValue = '';
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  String datetimeValue = '', dateValue = '', datetimeRengeValue = '';
  DateTimeRange selectedDateRange;
  String startDate, endDate, startDateRange, endDateRange;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addFormType = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "Add $addFormType",
      ),
      body: GestureDetector(
        // onTap: () {
        //   FocusScope.of(context).requestFocus(new FocusNode());
        // },
        child: FutureBuilder(
          future: Repository.getInstance()
              .getAddFormField(addFormType.toUpperCase()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              list = snapshot.data as List<AddFormFields>;
              list.forEach((field) {
                print('FieldInputType: ${field.fieldInputType}');
                if (field.fieldInputType == FieldInputType.INPUT.getType()) {
                  controllers.putIfAbsent(
                      field.apiKeyName, () => TextEditingController());
                }
                if (field.fieldInputType ==
                        FieldInputType.MULTI_PHONE_INPUT.getType() ||
                    field.fieldInputType ==
                        FieldInputType.MULTI_EMAIL_INPUT.getType()) {
                  controllers.putIfAbsent(
                      field.fieldInputType, () => TextEditingController());
                }
              });
            }
            return snapshot.hasData == true
                ? SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Column(
                        children: [
                          SizedBox(height: 12.0),
                          Form(
                            key: formkey,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (list[index].fieldInputType ==
                                    FieldInputType.INPUT.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      BeautyTextfield(
                                        width: double.maxFinite,
                                        height: 50,
                                        duration: Duration(milliseconds: 300),
                                        inputType: TextInputType.text,
                                        placeholder: list[index].fieldName,
                                        isRequired: list[index].isRequired
                                            ? isError
                                            : null,
                                        controller:
                                            controllers[list[index].apiKeyName],
                                        onTap: () {},
                                        onChanged: (data) {},
                                        validator: (value) {
                                          if (list[index].isRequired) {
                                            if (value.isEmpty) {
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
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.MULTI_PHONE_INPUT
                                        .getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      BeautyTextfield(
                                        width: double.infinity,
                                        height: 50,
                                        duration: Duration(milliseconds: 300),
                                        inputType: TextInputType.number,
                                        placeholder: list[index].fieldName,
                                        isRequired: false,
                                        countryCode: true,
                                        countryOnChanged: (CountryCode value) {
                                          countryCode = value.dialCode;
                                        },
                                        controller: controllers[
                                            list[index].fieldInputType],
                                        onTap: () {},
                                        onChanged: (data) {
                                          if (data != null &&
                                              countryCode != null)
                                            phone =
                                                int.parse(countryCode + data);
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.MULTI_EMAIL_INPUT
                                        .getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      BeautyTextfield(
                                        width: double.maxFinite,
                                        height: 50,
                                        duration: Duration(milliseconds: 300),
                                        inputType: TextInputType.emailAddress,
                                        placeholder: list[index].fieldName,
                                        isRequired: false,
                                        controller: controllers[
                                            list[index].fieldInputType],
                                        onTap: () {},
                                        onChanged: (data) {
                                          emailId = data;
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.CHECKBOX.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      CheckboxGroup(
                                        labels: list[index].checkBoxOption,
                                        activeColor: deepblue,
                                        onChange: (bool isChecked, String label,
                                            int index) {},
                                        onSelected: (List<String> checked) {
                                          checkedOptions = checked;
                                          selectionData.update(
                                            list[index].apiKeyName,
                                            (existingValue) => checked,
                                            ifAbsent: () => checked,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.DATE_TIME.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all<Color>(
                                                                          white),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
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
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .dateAndTime,
                                                            minimumDate: now,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (date) {
                                                              if (date !=
                                                                      null &&
                                                                  date !=
                                                                      selectedDate)
                                                                setState(() {
                                                                  selectedDate =
                                                                      date;

                                                                  var datea =
                                                                      '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';

                                                                  datetimeValue =
                                                                      dateFormater(
                                                                          datea);
                                                                  selectionData
                                                                      .update(
                                                                    list[index]
                                                                        .apiKeyName,
                                                                    (existingValue) =>
                                                                        selectedDate
                                                                            .millisecondsSinceEpoch,
                                                                    ifAbsent: () =>
                                                                        selectedDate
                                                                            .millisecondsSinceEpoch,
                                                                  );
                                                                });
                                                            },
                                                            initialDateTime:
                                                                selectedDate,
                                                            minimumYear:
                                                                now.year,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                              color: appColor.grey,
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          height: 50.0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                datetimeValue == ''
                                                    ? "    Select date    "
                                                    : "$datetimeValue",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: textHelper.defaultText14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.TOGGLE_BUTTON.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${list[index].fieldName}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Switch(
                                              activeColor: deepblue,
                                              value: _switchValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _switchValue = value;
                                                });
                                                selectionData.update(
                                                  list[index].apiKeyName,
                                                  (existingValue) =>
                                                      _switchValue,
                                                  ifAbsent: () => _switchValue,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.RADIO.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      RadioGroup<String>.builder(
                                        activeColor: deepblue,
                                        spacebetween: 40,
                                        groupValue: _verticalGroupValue,
                                        onChanged: (value) => setState(() {
                                          _verticalGroupValue = value;
                                          selectionData.update(
                                            list[index].apiKeyName,
                                            (existingValue) =>
                                                _verticalGroupValue,
                                            ifAbsent: () => _verticalGroupValue,
                                          );
                                        }),
                                        items: list[index].checkBoxOption,
                                        itemBuilder: (item) =>
                                            RadioButtonBuilder(
                                          item,
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.DATE_RANGE.getType()) {
                                  var type = list[index].apiKeyName;
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      CustomFormButton(
                                        label: startDateRange == null
                                            ? "    Select date    "
                                            : "$startDateRange - $endDateRange",
                                        onTap: () async {
                                          // final List<DateTime> picked =
                                          //     await DateRangePicker
                                          //         .showDatePicker(
                                          //             context: context,
                                          //             initialFirstDate:
                                          //                 new DateTime.now(),
                                          //             initialLastDate:
                                          //                 (new DateTime.now())
                                          //                     .add(new Duration(
                                          //                         days: 7)),
                                          //             firstDate:
                                          //                 new DateTime(2015),
                                          //             lastDate: new DateTime(
                                          //                 DateTime.now().year +
                                          //                     2));
                                          // if (picked != null &&
                                          //     picked.length == 2) {
                                          //   selectionData.update(
                                          //     list[index].apiKeyName,
                                          //     (existingValue) => [
                                          //       picked[0]
                                          //           .millisecondsSinceEpoch,
                                          //       picked[1].millisecondsSinceEpoch
                                          //     ],
                                          //     ifAbsent: () => [
                                          //       picked[0]
                                          //           .millisecondsSinceEpoch,
                                          //       picked[1].millisecondsSinceEpoch
                                          //     ],
                                          //   );

                                          //   startDateRange =
                                          //       '${picked[0].day}/${picked[0].month}/${picked[0].year}';
                                          //   endDateRange =
                                          //       '${picked[1].day}/${picked[1].month}/${picked[1].year}';

                                          //   setState(() {});
                                          //   print(picked);
                                          // }
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.SELECT.getType()) {
                                  var type = list[index].apiKeyName;
                                  List<DropDownModel> dropDown = list[index]
                                      .options
                                      .map(
                                        (e) => DropDownModel(e.label, e.value),
                                      )
                                      .toList();
                                  DropDownModel selectedModel = dropDown[0];
                                  selectionData.putIfAbsent(
                                      type, () => selectedModel.value);
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropDownWidget(
                                        dropDown,
                                        Icons.list,
                                        selectedModel,
                                        (DropDownModel selected) {
                                          selectedModel = selected;
                                          owner = selected.value;
                                          selectionData.update(type,
                                              (existingValue) => selected.value,
                                              ifAbsent: () => selected.name);
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.TEXTAREA.getType()) {
                                  var type = list[index].apiKeyName;
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      BeautyTextfield(
                                        width: double.maxFinite,
                                        height: 70,
                                        duration: Duration(milliseconds: 300),
                                        inputType: TextInputType.emailAddress,
                                        placeholder: list[index].fieldName,
                                        maxLines: 5,
                                        isRequired: false,
                                        controller: controllers[
                                            list[index].fieldInputType],
                                        onTap: () {},
                                        onChanged: (data) {
                                          if (data != null) {
                                            selectionData.update(
                                                type, (existingValue) => data,
                                                ifAbsent: () => data);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.DATE_TIME_RANGE.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          DateTimeRangePicker(
                                              startText: "From",
                                              endText: "To",
                                              doneText: "Yes",
                                              cancelText: "Cancel",
                                              // interval: 5,
                                              initialStartTime: DateTime.now(),
                                              initialEndTime: DateTime.now()
                                                  .add(Duration(days: 100)),
                                              mode: DateTimeRangePickerMode
                                                  .dateAndTime,
                                              minimumTime: DateTime.now()
                                                  .subtract(Duration(days: 5)),
                                              maximumTime: DateTime.now()
                                                  .add(Duration(days: 125)),
                                              use24hFormat: false,
                                              onConfirm: (start, end) {
                                                setState(() {
                                                  selectedDateRange =
                                                      DateTimeRange(
                                                          start: start,
                                                          end: end);
                                                  startDate =
                                                      '${start.day}/${start.month}/${start.year} ${start.hour}:${start.minute}';
                                                  endDate =
                                                      '${end.day}/${end.month}/${end.year} ${end.hour}:${end.minute}';
                                                });
                                                selectionData.update(
                                                  list[index].apiKeyName,
                                                  (existingValue) => [
                                                    selectedDateRange.start
                                                        .millisecondsSinceEpoch,
                                                    selectedDateRange.end
                                                        .millisecondsSinceEpoch
                                                  ],
                                                  ifAbsent: () => [
                                                    selectedDateRange.start
                                                        .millisecondsSinceEpoch,
                                                    selectedDateRange.end
                                                        .millisecondsSinceEpoch
                                                  ],
                                                );
                                              }).showPicker(context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 12.0),
                                          decoration: BoxDecoration(
                                              color: appColor.grey,
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          height: 50.0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.OWNER_SELECT.getType()) {
                                  var type = list[index].apiKeyName;
                                  List<DropDownModel> selection = list[index]
                                      .options
                                      .map(
                                        (e) => DropDownModel(e.label, e.value),
                                      )
                                      .toList();
                                  DropDownModel selectedModel = selection[0];
                                  selectionData.putIfAbsent(
                                      type, () => selectedModel.value);
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text(list[index].fieldName,
                                            style: textHelper.heading16),
                                      ),
                                      DropDownWidget(
                                        selection,
                                        Icons.list,
                                        selectedModel,
                                        (DropDownModel selected) {
                                          selectedModel = selected;
                                          owner = selected.value;
                                          selectionData.update(type,
                                              (existingValue) => selected.value,
                                              ifAbsent: () => selected.name);
                                        },
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.TAG_MULTI_SELECT.getType()) {
                                  allTags = list[index].options;

                                  return list[index].options.length >= 1
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Text('Tags',
                                                  style: textHelper.heading16),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                selectedTags = [];
                                                await showModalBottomSheet(
                                                        isScrollControlled: true,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        builder: (context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext
                                                                    context,
                                                                StateSetter
                                                                    setState) {
                                                              return Container(
                                                                decoration: new BoxDecoration(
                                                                    color:
                                                                        white,
                                                                    borderRadius: new BorderRadius
                                                                            .only(
                                                                        topLeft:
                                                                            const Radius.circular(
                                                                                8.0),
                                                                        topRight:
                                                                            const Radius.circular(8.0))),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              16.0,
                                                                          top:
                                                                              0.0,
                                                                          right:
                                                                              12.0,
                                                                          bottom:
                                                                              6.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                              'Select tags',
                                                                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                selectedTags = [];
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: Icon(Icons.close))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            8.0),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              12.0,
                                                                          top:
                                                                              4.0,
                                                                          right:
                                                                              12.0,
                                                                          bottom:
                                                                              6.0),
                                                                      child:
                                                                          CustomTag(
                                                                        allTags:
                                                                            allTags,
                                                                        selectedTags:
                                                                            selectedTags,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            8.0),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        bottom: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom,
                                                                        left:
                                                                            16,
                                                                        right:
                                                                            16,
                                                                      ),
                                                                      child:
                                                                          SaveButton(
                                                                        title:
                                                                            'Done',
                                                                        onTap:
                                                                            () {
                                                                          if (selectedTags
                                                                              .isNotEmpty) {
                                                                            selectedTagsValue =
                                                                                [];
                                                                            selectedTags.forEach((v) =>
                                                                                selectedTagsValue.add(v.value));
                                                                            selectionData.update(
                                                                              list[index].apiKeyName,
                                                                              (existingValue) => selectedTagsValue,
                                                                              ifAbsent: () => selectedTagsValue,
                                                                            );

                                                                            Navigator.pop(context);
                                                                          } else {
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.88,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            8.0),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        })
                                                    .then((value) =>
                                                        setState(() {}));
                                              },
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                width: double.infinity,
                                                padding: selectedTags.isEmpty
                                                    ? const EdgeInsets.only(
                                                        left: 10, right: 10)
                                                    : const EdgeInsets.only(
                                                        left: 10, top: 5),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10.0),
                                                decoration: BoxDecoration(
                                                    color: appColor.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0)),
                                                height: selectedTags.isEmpty
                                                    ? 50
                                                    : null,
                                                child: selectedTags.isEmpty
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Select tags',
                                                              style: textHelper
                                                                  .hintText),
                                                          Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: Colors
                                                                  .black54)
                                                        ],
                                                      )
                                                    : Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .center,
                                                        spacing: 0.0,
                                                        children: selectedTags
                                                            .map(
                                                                (e) =>
                                                                    Transform(
                                                                      transform: new Matrix4
                                                                          .identity()
                                                                        ..scale(
                                                                            0.8),
                                                                      child:
                                                                          new Chip(
                                                                        labelPadding:
                                                                            EdgeInsets.symmetric(horizontal: 4.0),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          side: BorderSide(
                                                                              width: 1,
                                                                              color: getValue(e.colorCode)),
                                                                          borderRadius:
                                                                              BorderRadius.circular(4),
                                                                        ),
                                                                        backgroundColor:
                                                                            getValue(e.colorCode),
                                                                        label: Text(
                                                                            '${e.label}',
                                                                            style:
                                                                                TextStyle(color: white)),
                                                                        elevation:
                                                                            0,
                                                                      ),
                                                                    ))
                                                            .toList(),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox();
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.ORG_SELECT.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
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
                                              selectionData.update(
                                                list[index].apiKeyName,
                                                (existingValue) =>
                                                    selectedCompany[0].name,
                                                ifAbsent: () =>
                                                    selectedCompany[0].id,
                                              );
                                            },
                                            selected: selectedCompany,
                                            all: allCompanies),
                                      ),
                                    ],
                                  );
                                } else if (list[index].fieldInputType ==
                                    FieldInputType.PERSON_SELECT.getType()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: list[index].fieldName,
                                                  style: textHelper.heading13),
                                              TextSpan(
                                                  text: list[index].isRequired
                                                      ? ' *'
                                                      : '',
                                                  style: textHelper.heading16),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: PeopleSearchableDropdown(
                                          key: const ValueKey('People'),
                                          searchBarTitle: 'Search People',
                                          searchBarController:
                                              _peopleSearchBarController,
                                          onSearchTextChanged: (value) async {
                                            setState(() {
                                              isSearching = true;
                                            });
                                            allPeoples = await Repository
                                                .getPeopleNewSearch(value);
                                            setState(() {
                                              isSearching = false;
                                            });
                                          },
                                          onClear: () {
                                            selectedPeople.clear();
                                          },
                                          searching: isSearching,
                                          onSelected: () {
                                            selectionData.update(
                                              list[index].apiKeyName,
                                              (existingValue) =>
                                                  selectedPeople[0].id,
                                              ifAbsent: () =>
                                                  selectedPeople[0].name,
                                            );
                                          },
                                          selected: selectedPeople,
                                          all: allPeoples,
                                          newPerson: (value) {
                                            isNew = value;
                                          },
                                          withNew: true,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: SaveButton(
                              onTap: () async {
                                if (formkey.currentState.validate() &&
                                    !isError) {
                                  setState(() {});
                                  Map<String, dynamic> params = {};
                                  controllers.forEach((key, value) {
                                    if (key == "MULTI_PHONE_INPUT") {
                                      if (phone != null)
                                        params["phone"] = [phone];
                                      else
                                        params["phone"] = [];
                                    } else if (key == "MULTI_EMAIL_INPUT") {
                                      if (controllers[key].text != '') {
                                        params["email"] = [
                                          controllers[key].text
                                        ];
                                        emailId = controllers[key].text;
                                      } else {
                                        params["email"] = [];
                                        emailId = '';
                                      }
                                    } else {
                                      params[key] = controllers[key].text;
                                    }
                                    print("Key : $key " +
                                        "Value ${controllers[key].text}");
                                  });
                                  if (selectedPeople.isNotEmpty) {
                                    paramsforPerson = {
                                      'name': selectedPeople[0].name != null
                                          ? selectedPeople[0].name
                                          : '',
                                      'email': emailId != '' ? [emailId] : [],
                                      'phone': phone != '' && phone != null
                                          ? [phone]
                                          : [],
                                    };
                                  }

                                  selectionData.forEach((key, value) {
                                    params[key] = value;
                                    print("Key : $key " + "Value $value");
                                    if (key == 'owner') {
                                      paramsforPerson[key] = value;
                                    }
                                  });

                                  submitDetails(
                                      context, params, paramsforPerson);
                                } else {
                                  toastHelper.toastWithTitleAndColor(
                                      "Please enter all the mandatory details!",
                                      black);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : FormLoader();
          },
        ),
      ),
    );
  }

  submitDetails(BuildContext context, Map<String, dynamic> params,
      Map<String, dynamic> paramsforPerson) async {
    final ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    print('=========>Sending Parameters:');
    print(params.toString());

    await pr.show();
    if (addFormType == "Lead" && isNew) {
      print(paramsforPerson.toString());
      var success1 =
          await context.read<Repository>().createPeople(paramsforPerson);
    }
    if (addFormType == "Company") {
      var success = await context.read<Repository>().createCompany(params);
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      popActivity(context, success);
    } else if (addFormType == "Person") {
      print(params.toString());
      var success = await context.read<Repository>().createPeople(params);
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      popActivity(context, success);
    } else if (addFormType == "Lead") {
      var success = await context.read<Repository>().createLead(params);
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      popActivity(context, success);
    }
    print(params.toString());
  }

  popActivity(BuildContext context, bool isSuccess) {
    if (isSuccess) {
      Navigator.pop(context, true);
    }
  }

  getValue(String value) {
    if (value != null) {
      return HexColor.fromHex(value);
    } else {
      return Colors.grey;
    }
  }

  dateFormater(String date) {
    var inputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
