import 'Option.dart';
import 'currency_option.dart';

class ActivityDetailsModel {
  ActivityDetailsModel({
    required this.id,
    required this.fieldInputType,
    // required this.fieldGroup,
    required this.activityDetailsModelOptions,
    required this.isRequired,
    required this.tablePriority,
    required this.fieldName,
    required this.apiKeyName,
    required this.isEditable,
    // required this.validation,
    required this.value,
    required this.valueWithColor,
    this.currencyOptions,
  });

  String id;
  String fieldInputType;
  // FieldGroup fieldGroup;
  List<Option> activityDetailsModelOptions;
  List<CurrencyOption>? currencyOptions;
  bool isRequired;
  int tablePriority;
  String fieldName;
  String apiKeyName;
  bool isEditable;
  // Validation validation;
  dynamic value;
  dynamic valueWithColor;

  factory ActivityDetailsModel.fromJson(Map<String, dynamic> json) =>
      ActivityDetailsModel(
        id: json["_id"],
        fieldInputType: json["fieldInputType"],
        // fieldGroup: fieldGroupValues.map[json["fieldGroup"]]!,
        activityDetailsModelOptions:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        isRequired: json["isRequired"],
        tablePriority: json["tablePriority"],
        fieldName: json["fieldName"],
        apiKeyName: json["apiKeyName"],
        isEditable: json["isEditable"],
        // validation: validationValues.map[json["validation"]]!,
        value: json["value"],
        valueWithColor: json["value"],
        currencyOptions: List<CurrencyOption>.from(
            json["options"].map((x) => CurrencyOption.fromJson(x))),
      );
}

enum FieldGroup { SYSTEM, CUSTOM }

class ActivityDetailsModelOption {
  ActivityDetailsModelOption({
    required this.label,
    required this.value,
    required this.colorCode,
    required this.name,
  });

  String label;
  String value;
  String colorCode;
  String name;

  factory ActivityDetailsModelOption.fromJson(Map<String, dynamic> json) =>
      ActivityDetailsModelOption(
        label: json["label"],
        value: json["value"] != null ? json["value"] : json["_id"],
        colorCode: json["colorCode"] == null ? null : json["colorCode"],
        name: json["name"],
      );
}

// class ActivityData {
//   ActivityData({
//     required this.id,
//     required this.tags,
//     required this.isCompleted,
//     required this.attendees,
//     required this.isCalendarInvited,
//     required this.name,
//     required this.description,
//     required this.activityType,
//     required this.assignToUser,
//     required this.owner,
//     required this.scheduleAt,
//     required this.duration,
//     required this.people,
//     required this.lead,
//     required this.company,
//     required this.deal,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.activityLostReasonComment,
//   });

//   String id;
//   List<dynamic> tags;
//   bool isCompleted;
//   List<String> attendees;
//   bool isCalendarInvited;
//   String name;
//   String description;
//   ActivityType activityType;
//   String assignToUser;
//   String owner;
//   DateTime scheduleAt;
//   String duration;
//   Company people;
//   dynamic lead;
//   Company company;
//   Deal deal;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String activityLostReasonComment;

//   factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
//         id: json["_id"],
//         tags: List<dynamic>.from(json["tags"].map((x) => x)),
//         isCompleted: json["isCompleted"],
//         attendees: List<String>.from(json["attendees"].map((x) => x)),
//         isCalendarInvited: json["isCalendarInvited"],
//         name: json["name"],
//         description: json["description"],
//         activityType: ActivityType.fromJson(json["activityType"]),
//         assignToUser: json["assignToUser"],
//         owner: json["owner"],
//         scheduleAt: DateTime.parse(json["scheduleAt"]),
//         duration: json["duration"],
//         people: Company.fromJson(json["people"]),
//         lead: json["lead"],
//         company: Company.fromJson(json["company"]),
//         deal: Deal.fromJson(json["deal"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         activityLostReasonComment: json["activityLostReasonComment"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "tags": List<dynamic>.from(tags.map((x) => x)),
//         "isCompleted": isCompleted,
//         "attendees": List<dynamic>.from(attendees.map((x) => x)),
//         "isCalendarInvited": isCalendarInvited,
//         "name": name,
//         "description": description,
//         "activityType": activityType.toJson(),
//         "assignToUser": assignToUser,
//         "owner": owner,
//         "scheduleAt": scheduleAt.toIso8601String(),
//         "duration": duration,
//         "people": people.toJson(),
//         "lead": lead,
//         "company": company.toJson(),
//         "deal": deal.toJson(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "activityLostReasonComment": activityLostReasonComment,
//       };
// }

// class ActivityType {
//   ActivityType({
//     required this.id,
//     required this.isDeactivated,
//     required this.name,
//     required this.symbName,
//     required this.v,
//   });

//   String id;
//   bool isDeactivated;
//   String name;
//   String symbName;
//   int v;

//   factory ActivityType.fromJson(Map<String, dynamic> json) => ActivityType(
//         id: json["_id"],
//         isDeactivated: json["isDeactivated"],
//         name: json["name"],
//         symbName: json["symbName"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "isDeactivated": isDeactivated,
//         "name": name,
//         "symbName": symbName,
//         "__v": v,
//       };
// }

// class Company {
//   Company({
//     required this.id,
//     required this.name,
//   });

//   String id;
//   String name;

//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//         id: json["_id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//       };
// }

// class Deal {
//   Deal({
//     required this.id,
//     required this.title,
//   });

//   String id;
//   String title;

//   factory Deal.fromJson(Map<String, dynamic> json) => Deal(
//         id: json["_id"],
//         title: json["title"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//       };
// }
