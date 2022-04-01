class ActivityLostReasons {
  ActivityLostReasons({
    required this.id,
    required this.type,
    required this.reason,
    required this.accountId,
    required this.profileId,
    required this.v,
  });

  String id;
  String type;
  String reason;
  String accountId;
  String profileId;
  int v;

  factory ActivityLostReasons.fromJson(Map<String, dynamic> json) =>
      ActivityLostReasons(
        id: json["_id"],
        type: json["type"],
        reason: json["reason"],
        accountId: json["accountId"],
        profileId: json["profileId"],
        v: json["__v"],
      );
}
