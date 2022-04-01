class Product {
  Product({
    required this.productId,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.amount,
  });

  String productId;
  String itemName;
  double quantity;
  double unitPrice;
  double amount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        itemName: json["itemName"],
        quantity: json["quantity"] is double
            ? double.parse(json["quantity"])
            : json["quantity"],
        unitPrice: json["unitPrice"] is double
            ? double.parse(json["unitPrice"])
            : json["unitPrice"],
        amount: json["amount"] is double
            ? double.parse(json["unitPrice"])
            : json["unitPrice"],
      );
  Map<String, dynamic> toJson() => {
        "productId": productId,
        "itemName": itemName,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "amount": amount,
      };
}
