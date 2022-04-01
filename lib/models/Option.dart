class Option {
  Option({
    required this.label,
    required this.value,
    required this.colorCode,
    required this.name,
  });

  String label;
  String value;
  String colorCode;
  String name;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        value: json["value"] != null ? json["value"] : json["_id"],
        colorCode: json["colorCode"] == null ? null : json["colorCode"],
        name: json["name"],
        // hexColorCode:
        //     json["hexColorCode"] == null ? null : json["hexColorCode"],
      );
}
