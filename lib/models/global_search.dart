class GlobalSearchModel {
  GlobalSearchModel({
    required this.company,
    required this.lead,
    required this.deal,
    required this.product,
    required this.people,
  });

  List<GlobalCompany> company;
  List<GlobalLead> lead;
  List<GlobalProduct> product;
  List<GlobalLead> people;
  List<GlobalDeal> deal;
  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) =>
      GlobalSearchModel(
        company: (json["company"] == null)
            ? []
            : (json["company"] as List).isEmpty
                ? []
                : (json["company"] as List)
                    .map((e) => GlobalCompany.fromJson(e))
                    .toList(),
        lead: (json["lead"] == null)
            ? []
            : (json["lead"] as List).isEmpty
                ? []
                : (json["lead"] as List)
                    .map((e) => GlobalLead.fromJson(e))
                    .toList(),
        deal:
            (json["deal"] as List).map((e) => GlobalDeal.fromJson(e)).toList(),
        people: (json["people"] == null)
            ? []
            : (json["people"] as List).isEmpty
                ? []
                : (json["people"] as List)
                    .map((e) => GlobalLead.fromJson(e))
                    .toList(),
        product: (json["product"] == null)
            ? []
            : (json["product"] as List).isEmpty
                ? []
                : (json["product"] as List)
                    .map((e) => GlobalProduct.fromJson(e))
                    .toList(),
      );
}

class GlobalDeal {
  GlobalDeal({
    required this.id,
    required this.title,
    required this.pipelineId,
    required this.lock,
  });

  String id;
  String title;
  String pipelineId;
  bool lock;

  factory GlobalDeal.fromJson(Map<String, dynamic> json) => GlobalDeal(
        id: json["_id"],
        title: json["title"],
        pipelineId: json["pipelineId"],
        lock: json["lock"],
      );
}

class GlobalCompany {
  GlobalCompany({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory GlobalCompany.fromJson(Map<String, dynamic> json) => GlobalCompany(
        id: json["_id"],
        name: json["name"],
      );
}

class GlobalLead {
  GlobalLead({
    required this.tags,
    required this.phone,
    required this.email,
    required this.id,
    required this.name,
    required this.company,
  });

  List<String> tags;
  List<int>? phone;
  List<String> email;
  String id;
  String name;
  GlobalCompany company;

  factory GlobalLead.fromJson(Map<String, dynamic> json) => GlobalLead(
        tags: List<String>.from(json["tags"].map((x) => x)),
        phone: List<int>.from(json["phone"].map((x) => x)),
        email: List<String>.from(json["email"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        company: json["company"] == null
            ? GlobalCompany(id: '', name: 'NA')
            : (json["company"] is String)
                ? GlobalCompany(id: json["company"], name: 'NA')
                : GlobalCompany.fromJson(json["company"]),
      );
}

class GlobalProduct {
  GlobalProduct({
    required this.sku,
    required this.id,
    required this.productName,
    required this.pricing,
    required this.taxPercentage,
  });

  int sku;
  String id;
  String productName;
  List<GlobalPricing> pricing;
  int taxPercentage;

  factory GlobalProduct.fromJson(Map<String, dynamic> json) => GlobalProduct(
        sku: json["sku"] == null ? null : json["sku"],
        id: json["_id"],
        productName: json["productName"],
        pricing: List<GlobalPricing>.from(
            json["pricing"].map((x) => GlobalPricing.fromJson(x))),
        taxPercentage:
            json["taxPercentage"] == null ? null : json["taxPercentage"],
      );
}

class GlobalPricing {
  GlobalPricing({
    required this.unitPrice,
    required this.currency,
  });

  int unitPrice;
  String currency;

  factory GlobalPricing.fromJson(Map<String, dynamic> json) => GlobalPricing(
        unitPrice: json["unitPrice"],
        currency: json["currency"],
      );
}
