import 'package:json_annotation/json_annotation.dart';
import 'package:salessimplify/models/Option.dart';
import 'package:salessimplify/models/tag.dart';
part 'Leads.g.dart';

@JsonSerializable()
class Leads {
  final String? id, name;
  final List<int>? phone;
  final List<String>? email;
  final CompanyNewModel? company;
  final List<Tag> tags;

  Leads({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.tags,
  });

  factory Leads.fromJson(Map<String, dynamic> json) => _$LeadsFromJson(json);
}

class CompanyNewModel {
  CompanyNewModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory CompanyNewModel.fromJson(Map<String, dynamic> json) =>
      CompanyNewModel(
        id: json["_id"],
        name: json["name"],
      );
}
