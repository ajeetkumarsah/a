import 'package:salessimplify/models/Option.dart';

class AddFormFields {
  final String id,
      fieldInputType,
      description,
      fieldType,
      fieldGroup,
      fieldName,
      apiKeyName;
  final bool isRequired, isRequiredInAddForm, isEnable, isEditable;
  final int addFormPriority, priority;
  final List<Option> options;
  final List<String> checkBoxOption;

  AddFormFields({
    required this.id,
    required this.fieldInputType,
    required this.description,
    required this.fieldType,
    required this.fieldGroup,
    required this.fieldName,
    required this.apiKeyName,
    required this.isRequired,
    required this.isRequiredInAddForm,
    required this.isEnable,
    required this.isEditable,
    required this.addFormPriority,
    required this.priority,
    required this.options,
    required this.checkBoxOption,
  });

  factory AddFormFields.fromJson(Map<String, dynamic> json) {
    return AddFormFields(
      id: json["_id"],
      fieldInputType: json["fieldInputType"],
      description: json["description"],
      fieldType: json["fieldType"],
      fieldGroup: json["fieldGroup"],
      fieldName: json["fieldName"],
      apiKeyName: json["apiKeyName"],
      isRequired: json["isRequired"],
      isRequiredInAddForm: json["isRequiredInAddForm"],
      isEnable: json["isEnable"],
      isEditable: json["isEditable"],
      addFormPriority: json["addFormPriority"],
      priority: json["priority"],
      options: (json["options"] as List).isEmpty
          ? []
          : (json["options"] as List)
              .map((e) => e is Map<String, dynamic>
                  ? Option.fromJson(e)
                  : Option(
                      label: "NA",
                      value: "NA",
                      colorCode: '',
                      name: '',
                    ))
              .toList(),
      checkBoxOption: (json["options"] as List)
          .map(
            (e) => e is String ? e : '',
          )
          .toList(),
    );
  }
}
