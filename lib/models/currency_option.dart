class CurrencyOption {
  CurrencyOption({
    required this.label,
    required this.value,
  });

  String label;
  String value;

  factory CurrencyOption.fromJson(Map<String, dynamic> json) => CurrencyOption(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
