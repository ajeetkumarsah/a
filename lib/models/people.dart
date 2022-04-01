class PeopleModel {
  PeopleModel({
    required this.state,
    required this.isDeleted,
    required this.tags,
    required this.mobile,
    required this.phone,
    required this.otherPhone,
    required this.email,
    required this.otherEmail,
    required this.visibleTo,
    required this.mergedIds,
    required this.id,
    required this.name,
    required this.company,
    required this.owner,
    // required this.customFields,
    required this.searchText,
    required this.v,
    required this.firstName,
  });

  String state;
  bool isDeleted;
  List<String> tags;
  List<dynamic> mobile;
  List<String> phone;
  List<dynamic> otherPhone;
  List<String> email;
  List<dynamic> otherEmail;
  String visibleTo;
  List<dynamic> mergedIds;
  String id;
  String name;
  String company;
  String owner;
  // CustomFields customFields;
  String searchText;
  int v;
  String firstName;

  factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        state: json["state"],
        isDeleted: json["isDeleted"],
        tags: (json["tags"] as List).map((e) => e.toString()).toList(),
        mobile: (json["mobile"] as List).map((e) => e.toString()).toList(),
        phone: (json["phone"] as List).map((e) => e.toString()).toList(),
        otherPhone:
            (json["otherPhone"] as List).map((e) => e.toString()).toList(),
        email: (json["email"] as List).map((e) => e.toString()).toList(),
        otherEmail:
            (json["otherEmail"] as List).map((e) => e.toString()).toList(),
        visibleTo: json["visibleTo"],
        mergedIds:
            (json["mergedIds"] as List).map((e) => e.toString()).toList(),
        id: json["_id"],
        name: json["name"],
        company: json["company"],
        owner: json["owner"],
        // customFields: CustomFields.fromJson(json["customFields"]),
        searchText: json["searchText"],
        v: json["__v"],
        firstName: json["firstName"],
      );
}
