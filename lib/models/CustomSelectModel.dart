class CustomSelectModel {
  final String id, name;

  CustomSelectModel({
    required this.name,
    required this.id,
  });

  factory CustomSelectModel.fromJson(Map<String, dynamic> json) {
    return CustomSelectModel(
      name: json["name"],
      id: json["_id"],
    );
  }
}
