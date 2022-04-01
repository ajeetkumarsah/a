import 'package:salessimplify/models/tag.dart';

class Person {
  final String id, name;
  final List<String> phone;
  final List<String> email;
  final List<Tag> tags;
  final List<Tag> company;
  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.tags,
    required this.company,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        email: json["email"].cast<String>(),
        phone: (json["phone"] as List).map((e) => e.toString()).toList(),
        tags: (json["tags"] as List)
            .map(
              (e) => Tag.fromJson(e),
            )
            .toList(),
        company: (json["tags"] as List)
            .map(
              (e) => Tag.fromJson(e),
            )
            .toList(),
      );
}
