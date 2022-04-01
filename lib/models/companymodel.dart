import 'package:json_annotation/json_annotation.dart';

part 'companymodel.g.dart';

@JsonSerializable()
class CompanyModel {

  final String? name;

  CompanyModel({
    required this.name,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
/* factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: (json["name"] as String).isEmpty ? "" : json["name"],
    );
  }*/
}
