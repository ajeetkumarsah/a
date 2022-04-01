class Notes {
  Notes({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.updatedBy,
    required this.leadId,
    required this.peopleId,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String content;
  String createdBy;
  String updatedBy;
  String leadId;
  String peopleId;
  String companyId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json["_id"],
        content: json["content"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        leadId: json["leadId"],
        peopleId: json["peopleId"],
        companyId: json["companyId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "leadId": leadId,
        "peopleId": peopleId,
        "companyId": companyId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
