part of 'Leads.dart';

Leads _$LeadsFromJson(Map<String, dynamic> json) {
  return Leads(
    id: json['_id'] ?? "NA",
    name: json['name'] ?? "NA",
    company: json["company"] == null
        ? null
        : CompanyNewModel.fromJson(json["company"]),
    email: (json["email"] as List).isEmpty
        ? []
        : (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
    phone: (json["phone"] as List).isEmpty
        ? []
        : (json['phone'] as List<dynamic>?)?.map((e) => e as int).toList(),
    tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e))
            .toList() ??
        [], // List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
  );
}
