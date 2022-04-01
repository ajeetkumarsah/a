class DropDownOptionModel {
  DropDownOptionModel({
    required this.label,
    required this.value,
  });

  String label;
  String value;

  factory DropDownOptionModel.fromJson(Map<String, dynamic> json) =>
      DropDownOptionModel(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
