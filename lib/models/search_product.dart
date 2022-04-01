class SearchProduct {
  SearchProduct({
    required this.id,
    required this.sku,
    required this.taxPercentage,
    required this.productName,
    required this.pricing,
    required this.owner,
  });

  String id;
  int sku;
  int taxPercentage;
  String productName;
  List<Pricing> pricing;
  String owner;

  factory SearchProduct.fromJson(Map<String, dynamic> json) => SearchProduct(
        id: json["_id"],
        sku: json["sku"],
        taxPercentage: json["taxPercentage"],
        productName: json["productName"],
        pricing:
            List<Pricing>.from(json["pricing"].map((x) => Pricing.fromJson(x))),
        owner: json["owner"],
      );
}

class Pricing {
  Pricing({
    required this.unitPrice,
    required this.currency,
  });

  dynamic unitPrice;
  String currency;

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        unitPrice: json["unitPrice"],
        currency: json["currency"],
      );
}
