class LeadLostReasons {
  LeadLostReasons({
    required this.reason,
  });

  bool reason;

  factory LeadLostReasons.fromJson(Map<String, dynamic> json) =>
      LeadLostReasons(
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
      };
}
