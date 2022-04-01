import 'companymodel.dart';

class SearchResult {
  String id, title;

  SearchResult(this.id, this.title);

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      json["_id"],
      json["title"],
    );
  }

  getId() => id;
}

class SearchPeopleNew {
  String id;
  String? name;
  final List<int>? phone;
  final List<String>? email;

  SearchPeopleNew(this.id, this.name, this.phone, this.email);

  factory SearchPeopleNew.fromJson(Map<String, dynamic> json) {
    return SearchPeopleNew(
      json["_id"],
      json["name"],
      (json["phone"] as List).isEmpty
          ? []
          : (json['phone'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json["email"] as List).isEmpty
          ? []
          : (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  getId() => id;
}

class SearchLeadNew {
  final String? id, name;
  final List<int>? phone;
  final List<String>? email;
  final CompanyModel? company;

  SearchLeadNew({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
  });

  factory SearchLeadNew.fromJson(Map<String, dynamic> json) {
    return SearchLeadNew(
      id: json['_id'] ?? "NA",
      name: json['name'] ?? "NA",
      company: json['company'] == null
          ? null
          : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      email: (json["email"] as List).isEmpty
          ? []
          : (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone: (json["phone"] as List).isEmpty
          ? []
          : (json['phone'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );
  }

  getId() => id;
}

class SearchCompanyNew {
  final String id, name, owner, website, createdAt, createdAddress;
  final List<String> phone;
  final List<String> email;

  SearchCompanyNew({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.owner,
    required this.website,
    required this.createdAt,
    required this.createdAddress,
  });

  factory SearchCompanyNew.fromJson(Map<String, dynamic> json) {
    return SearchCompanyNew(
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

  getId() => id;
}
