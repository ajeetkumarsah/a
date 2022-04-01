import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/models/person.dart';

import 'dropdown_option.dart';
import 'next_activity_model.dart';

class PopupDetails {
  final Person person;
  final Company company;

  PopupDetails({
    required this.person,
    required this.company,
  });

  factory PopupDetails.fromJson(Map<String, dynamic> json) => PopupDetails(
        person: Person.fromJson(
          json["person"],
        ),
        company: Company.fromJson(
          json["company"],
        ),
      );
}

class PopupDetailsList {
  String id;
  String fieldInputType;
  List<Option> options;
  bool isRequired;
  int tablePriority;
  String fieldName;
  String apiKeyName;
  bool isEditable;
  dynamic value;
  dynamic valueWithColor;
  String fieldGroup;
  List<String> checkBoxOption;
  List<DropDownOptionModel> option;

  PopupDetailsList({
    required this.id,
    required this.fieldInputType,
    required this.options,
    required this.isRequired,
    required this.option,
    required this.tablePriority,
    required this.fieldName,
    required this.apiKeyName,
    required this.isEditable,
    required this.value,
    required this.valueWithColor,
    required this.fieldGroup,
    required this.checkBoxOption,
  });

  factory PopupDetailsList.fromJson(Map<String, dynamic> json) =>
      PopupDetailsList(
        id: json["_id"],
        fieldInputType: json["fieldInputType"],
        checkBoxOption: (json["options"] as List)
            .map(
              (e) => e is String ? e : '',
            )
            .toList(),
        option: (json["options"] as List)
            .map(
              (e) => e is String
                  ? DropDownOptionModel(
                      label: "label$e",
                      value: e,
                    )
                  : DropDownOptionModel.fromJson(e),
            )
            .toList(),
        options: (json["options"] as List)
            .map(
              (e) => e is String
                  ? Option(
                      label: "label$e",
                      value: e,
                      colorCode: "", name: '',
                      // hexColorCode: ""
                    )
                  : Option.fromJson(e),
            )
            .toList(),
        isRequired: json["isRequired"],
        tablePriority: json["tablePriority"],
        fieldName: json["fieldName"],
        apiKeyName: json["apiKeyName"],
        isEditable: json["isEditable"],
        value: getValue(json["value"]),
        valueWithColor: json["value"],
        fieldGroup: json["fieldGroup"],
        // (json["value"] is String)
        //     ? json["value"]
        //     : ((json["value"] is int)
        //         ? (json["value"] as int).toString()
        //         : (((json["value"] is List)
        //             ? ((json["value"] as List).isEmpty
        //                 ? ""
        //                 : (json["value"] as List)
        //                     .map(
        //                       (e) => getValue(e),
        //                     )
        //                     .toList())
        //             : ""))),
      );
}

getValue(dynamic value) {
  if (value is String)
    return value;
  else if (value is int)
    return (value).toString();
  else if (value is bool)
    return (value);
  else if (value is Map<String, dynamic>)
    return value['activityStatus'] != null
        ? NextActivityModel.fromJson(value)
        : Option.fromJson(value);
  else if (value is List)
    return ((value).isEmpty
        ? ""
        : ((value[0] is Map<String, dynamic>)
            ? Option.fromJson(value[0]).label
            : value));
  else
    return "";
}
// getValue(e) {
//   if (e is String)
//     return Option(label: "label$e", value: e, colorCode: "");
//   else if (e is int)
//     return Option(label: "label$e", value: e.toString(), colorCode: "");
//   else
//     return Option.fromJson(e);
// }


