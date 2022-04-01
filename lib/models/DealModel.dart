import 'package:salessimplify/models/company.dart';
import 'package:salessimplify/models/tag.dart';

class DealModel {
  final String id, title, dealCurrency;
  final int order;
  final Company company;
  final List<Tag> tags;
  final dynamic dealValue;
  final DealPeople people;
  String status;

  DealModel({
    required this.id,
    required this.title,
    required this.dealCurrency,
    required this.dealValue,
    required this.order,
    required this.company,
    required this.tags,
    required this.people,
    required this.status,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json["_id"],
      title: json["title"],
      dealCurrency: json["dealCurrency"],
      dealValue: json["dealValue"],
      order: json["order"],
      status: json["status"],
      company: json["company"] == null
          ? Company(
              id: "NA",
              name: "NA",
              email: ["NA"],
              phone: ["NA"],
              owner: "NA",
              website: "NA",
              createdAt: "NA",
              createdAddress: "NA",
            )
          : Company.fromJson(
              json["company"],
            ),
      tags: (json["tags"] as List).isEmpty
          ? []
          : (json["tags"] as List)
              .map(
                (e) => Tag.fromJson(e),
              )
              .toList(),
      people: json["people"] == null
          ? DealPeople(
              firstName: '',
              id: '',
              isDeleted: true,
              lastName: '',
              name: '',
              state: '',
            )
          : DealPeople.fromJson(json["people"]),
    );
  }
}

class PeopleModel1 {
  PeopleModel1({
    required this.name,
  });

  String name;

  factory PeopleModel1.fromJson(Map<String, dynamic> json) => PeopleModel1(
        name: json["name"],
      );
}

class DealPeople {
  DealPeople({
    required this.id,
    required this.state,
    required this.isDeleted,
    required this.name,
    required this.firstName,
    required this.lastName,
  });

  String id;
  String state;
  bool isDeleted;

  String name;
  String firstName;
  String lastName;

  factory DealPeople.fromJson(Map<String, dynamic> json) => DealPeople(
        id: json["_id"],
        state: json["state"],
        isDeleted: json["isDeleted"],
        name: json["name"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );
}
