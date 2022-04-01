class ActivityType {
  final String id, symbName, name;

  ActivityType({
    required this.id,
    required this.symbName,
    required this.name,
  });

  factory ActivityType.fromJson(Map<String, dynamic> json) => ActivityType(
        id: json["_id"],
        symbName: json["symbName"],
        name: json["name"],
      );
}
