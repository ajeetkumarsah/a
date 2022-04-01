class ShortActivityModel {
  ShortActivityModel({
    required this.id,
    required this.tags,
    required this.isCompleted,
    required this.attendees,
    required this.isCalendarInvited,
    required this.name,
    required this.description,
    required this.activityType,
    required this.assignToUser,
    required this.owner,
    required this.scheduleAt,
    required this.duration,
    required this.company,
    required this.deal,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  List<dynamic> tags;
  bool isCompleted;
  List<dynamic> attendees;
  bool isCalendarInvited;
  String name;
  String description;
  ActivityType activityType;
  String assignToUser;
  String owner;
  DateTime scheduleAt;
  String duration;
  String company;
  String deal;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ShortActivityModel.fromJson(Map<String, dynamic> json) =>
      ShortActivityModel(
        id: json["_id"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        isCompleted: json["isCompleted"],
        attendees: List<dynamic>.from(json["attendees"].map((x) => x)),
        isCalendarInvited: json["isCalendarInvited"],
        name: json["name"],
        description: json["description"],
        activityType: ActivityType.fromJson(json["activityType"]),
        assignToUser: json["assignToUser"],
        owner: json["owner"],
        scheduleAt: DateTime.parse(json["scheduleAt"]),
        duration: json["duration"],
        company: json["company"],
        deal: json["deal"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class ActivityType {
  ActivityType({
    required this.id,
    required this.name,
    required this.symbName,
  });

  String id;
  String name;
  String symbName;

  factory ActivityType.fromJson(Map<String, dynamic> json) => ActivityType(
        id: json["_id"],
        name: json["name"],
        symbName: json["symbName"],
      );
}
