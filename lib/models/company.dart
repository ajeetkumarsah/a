class Company {
  final String id, name, owner, website, createdAt, createdAddress;
  final List<String> phone;
  final List<String> email;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.owner,
    required this.website,
    required this.createdAt,
    required this.createdAddress,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["_id"] ?? "NA",
      name: json["name"] ?? "NA",
      owner: json["owner"] ?? "NA",
      website: json["website"] ?? "NA",
      createdAt: json["createdAt"] ?? "NA",
      createdAddress: json["createdAddress"] ?? "NA",
      email: json["email"] == null ? [] : json["email"].cast<String>(),
      phone: json["phone"] == null
          ? []
          : (json["phone"] as List).map((e) => e.toString()).toList(),
    );
  }
}
