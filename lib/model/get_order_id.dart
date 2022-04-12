class GetOrderIdModel {
  GetOrderIdModel({
    required this.orderId,
    required this.uid,
  });

  String orderId;
  String uid;

  factory GetOrderIdModel.fromJson(Map<String, dynamic> json) =>
      GetOrderIdModel(
        orderId: json["order_id"] == null ? null : json["order_id"],
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId == null ? null : orderId,
        "uid": uid == null ? null : uid,
      };
}
