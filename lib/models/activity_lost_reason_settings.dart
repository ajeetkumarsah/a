class ActivityLostReasonSettings {
  ActivityLostReasonSettings({
    required this.isActivityLostReasonEnabled,
  });

  bool isActivityLostReasonEnabled;

  factory ActivityLostReasonSettings.fromJson(Map<String, dynamic> json) =>
      ActivityLostReasonSettings(
        isActivityLostReasonEnabled: json["isActivityLostReasonEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "isActivityLostReasonEnabled": isActivityLostReasonEnabled,
      };
}
