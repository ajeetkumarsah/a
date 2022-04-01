import 'package:salessimplify/models/ActivityType.dart';

class ActivityData {
  bool isCompleted;
  String schedule, duration, description, name, id, mobileIcon;
  ActivityType activityType;
  int scheduleAtTimestamp;
  // PeopleModel people;
  ActivityData({
    required this.id,
    // required this.people,
    required this.isCompleted,
    required this.schedule,
    required this.duration,
    required this.description,
    required this.name,
    required this.activityType,
    required this.mobileIcon,
    required this.scheduleAtTimestamp,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      id: json['_id'],
      // people: PeopleModel.fromJson(json["people"]),
      isCompleted: json["isCompleted"],
      schedule: json["scheduleAt"],
      duration: json["duration"],
      description: json["description"],
      name: json["name"],
      activityType: json["activityType"] == null
          ? ActivityType(id: "0", symbName: "NA", name: "NA")
          : ActivityType.fromJson(json["activityType"]),
      mobileIcon: json["mobileIcon"],
      scheduleAtTimestamp: json["scheduleAtTimestamp"],
    );
  }
}
