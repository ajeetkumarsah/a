class NextActivityModel {
  NextActivityModel({
    // required this.value,
    required this.activityStatus,
    required this.activityName,
    required this.activitySymbol,
    required this.mobileIcon,
  });

  // DateTime value;
  String activityStatus;
  String activityName;
  String activitySymbol;
  String mobileIcon;

  factory NextActivityModel.fromJson(Map<String, dynamic> json) =>
      NextActivityModel(
        // value: DateTime.parse(json["value"]),
        activityStatus: json["activityStatus"],
        activityName: json["activityName"],
        activitySymbol: json["activitySymbol"],
        mobileIcon: json["mobileIcon"],
      );
}
