class PostOrderIdModel {
  PostOrderIdModel({
    this.amount,
    this.userId,
    this.value,
  });

  String? amount;
  String? userId;
  Value? value;

  factory PostOrderIdModel.fromJson(Map<String, dynamic> json) =>
      PostOrderIdModel(
        amount: json["amount"] == null ? null : json["amount"],
        userId: json["user_id"] == null ? null : json["user_id"],
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "user_id": userId == null ? null : userId,
        "value": value == null ? null : value!.toJson(),
      };
}

class Value {
  Value({
    this.gymId,
    this.userId,
    this.price,
    this.trxId,
    this.trxStatus,
    this.taxPercentage,
    this.taxAmount,
    this.type,
    this.orderStatus,
    this.slotId,
    this.addon,
    this.startDate,
    this.expireDate,
    this.coupon,
    this.planId,
    this.remark,
    this.eventId,
    this.orderId,
    this.sessionId,
    this.isWhatsapp,
  });

  String? gymId;
  String? userId;
  int? price;
  String? trxId;
  String? trxStatus;
  int? taxPercentage;
  int? taxAmount;
  String? type;
  String? orderStatus;
  String? slotId;
  String? addon;
  String? startDate;
  String? expireDate;
  String? coupon;
  String? planId;
  String? remark;
  String? eventId;
  String? orderId;
  String? sessionId;
  bool? isWhatsapp;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        gymId: json["gym_id"] == null ? null : json["gym_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        price: json["price"] == null ? null : json["price"],
        trxId: json["trx_id"] == null ? null : json["trx_id"],
        trxStatus: json["trx_status"] == null ? null : json["trx_status"],
        taxPercentage:
            json["tax_percentage"] == null ? null : json["tax_percentage"],
        taxAmount: json["tax_amount"] == null ? null : json["tax_amount"],
        type: json["type"] == null ? null : json["type"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        slotId: json["slot_id"] == null ? null : json["slot_id"],
        addon: json["addon"] == null ? null : json["addon"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        expireDate: json["expire_date"] == null ? null : json["expire_date"],
        coupon: json["coupon"] == null ? null : json["coupon"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        remark: json["remark"] == null ? null : json["remark"],
        eventId: json["event_id"] == null ? null : json["event_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        sessionId: json["session_id"] == null ? null : json["session_id"],
        isWhatsapp: json["isWhatsapp"] == null ? null : json["isWhatsapp"],
      );

  Map<String, dynamic> toJson() => {
        "gym_id": gymId == null ? null : gymId,
        "user_id": userId == null ? null : userId,
        "price": price == null ? null : price,
        "trx_id": trxId == null ? null : trxId,
        "trx_status": trxStatus == null ? null : trxStatus,
        "tax_percentage": taxPercentage == null ? null : taxPercentage,
        "tax_amount": taxAmount == null ? null : taxAmount,
        "type": type == null ? null : type,
        "order_status": orderStatus == null ? null : orderStatus,
        "slot_id": slotId == null ? null : slotId,
        "addon": addon == null ? null : addon,
        "start_date": startDate == null ? null : startDate,
        "expire_date": expireDate == null ? null : expireDate,
        "coupon": coupon == null ? null : coupon,
        "plan_id": planId == null ? null : planId,
        "remark": remark == null ? null : remark,
        "event_id": eventId == null ? null : eventId,
        "order_id": orderId == null ? null : orderId,
        "session_id": sessionId == null ? null : sessionId,
        "isWhatsapp": isWhatsapp == null ? null : isWhatsapp,
      };
}
