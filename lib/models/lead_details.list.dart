import 'package:salessimplify/models/dropdown_option.dart';

import 'Option.dart';
import 'next_activity_model.dart';

class LeadDetailsList {
  String? id;
  String? fieldInputType;
  List<Option>? options;
  bool? isRequired;
  int? tablePriority;
  String? fieldName;
  String? apiKeyName;
  bool? isEditable;
  String? validation;
  dynamic value;
  List<DropDownOptionModel> option;
  List<String> checkBoxOption;
  dynamic nextActivityValue;
  dynamic valueWithColor;

  String fieldGroup;

  LeadDetailsList({
    required this.id,
    required this.fieldInputType,
    required this.options,
    required this.option,
    required this.isRequired,
    required this.tablePriority,
    required this.fieldName,
    required this.apiKeyName,
    required this.isEditable,
    required this.validation,
    required this.value,
    required this.nextActivityValue,
    required this.valueWithColor,
    required this.fieldGroup,
    required this.checkBoxOption,
  });

  factory LeadDetailsList.fromJson(Map<String, dynamic> json) =>
      LeadDetailsList(
        id: json["_id"],
        fieldInputType: json["fieldInputType"],
        options: (json["options"] as List)
            .map(
              (e) => e is String
                  ? Option(label: "label$e", value: e, colorCode: "", name: "")
                  : Option.fromJson(e),
            )
            .toList(),
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
        isRequired: json["isRequired"],
        tablePriority: json["tablePriority"],
        fieldName: json["fieldName"],
        apiKeyName: json["apiKeyName"],
        isEditable: json["isEditable"],
        validation: json["validation"],
        value: getValue(json["value"]),
        nextActivityValue: getValue(json["value"]),
        valueWithColor: json["value"],
        fieldGroup: json["fieldGroup"],
        /*value: (json["value"] is String)
            ? json["value"]
            : ((json["value"] is int)
            ? (json["value"] as int).toString()
            : (((json["value"] is List)
            ? ((json["value"] as List).isEmpty
            ? ""
            : (json["value"] as List)[0])
            : ""))),*/
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
    return " ";
}
