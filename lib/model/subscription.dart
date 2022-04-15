class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.uid,
    this.gymId,
    this.userId,
    this.price,
    this.trxId,
    this.trxStatus,
    this.taxPercentage,
    this.taxAmount,
    this.orderStatus,
    this.dateAdded,
    this.addon,
    this.startDate,
    this.expireDate,
    this.coupon,
    this.remark,
    this.type,
    this.orderId,
    this.receipt,
    this.subscriptionStatus,
    this.orderIdSuccess,
    this.isPartial,
    this.isGoal,
    this.planName,
    this.planImage,
    this.gymName,
    this.gymAddress1,
    this.gymType,
    this.gymAddress2,
    this.gymCity,
    this.gymState,
    this.gymLat,
    this.gymLong,
    this.gymPin,
    this.gymCountry,
    this.gymCoverImage,
    this.nSession,
    this.eventName,
    this.eventDate,
    this.addonName,
    this.isPt,
  });

  int? id;
  String? uid;
  String? gymId;
  String? userId;
  int? price;
  String? trxId;
  String? trxStatus;
  String? taxPercentage;
  String? taxAmount;
  String? orderStatus;
  DateTime? dateAdded;
  String? addon;
  DateTime? startDate;
  DateTime? expireDate;
  String? coupon;
  String? remark;
  String? type;
  String? orderId;
  String? receipt;
  String? subscriptionStatus;
  dynamic orderIdSuccess;
  String? isPartial;
  int? isGoal;
  String? planName;
  String? planImage;
  String? gymName;
  String? gymAddress1;
  String? gymType;
  String? gymAddress2;
  String? gymCity;
  String? gymState;
  String? gymLat;
  String? gymLong;
  String? gymPin;
  String? gymCountry;
  String? gymCoverImage;
  dynamic nSession;
  dynamic eventName;
  dynamic eventDate;
  dynamic addonName;
  String? isPt;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        gymId: json["gym_id"] == null ? null : json["gym_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        price: json["price"] == null ? null : json["price"],
        trxId: json["trx_id"] == null ? null : json["trx_id"],
        trxStatus: json["trx_status"] == null ? null : json["trx_status"],
        taxPercentage:
            json["tax_percentage"] == null ? null : json["tax_percentage"],
        taxAmount: json["tax_amount"] == null ? null : json["tax_amount"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        addon: json["addon"] == null ? null : json["addon"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        expireDate: json["expire_date"] == null
            ? null
            : DateTime.parse(json["expire_date"]),
        coupon: json["coupon"] == null ? null : json["coupon"],
        remark: json["remark"] == null ? null : json["remark"],
        type: json["type"] == null ? null : json["type"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        receipt: json["receipt"] == null ? null : json["receipt"],
        subscriptionStatus: json["subscription_status"] == null
            ? null
            : json["subscription_status"],
        orderIdSuccess: json["order_id_success"],
        isPartial: json["is_partial"] == null ? null : json["is_partial"],
        isGoal: json["is_goal"] == null ? null : json["is_goal"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        planImage: json["plan_image"] == null ? null : json["plan_image"],
        gymName: json["gym_name"] == null ? null : json["gym_name"],
        gymAddress1: json["gym_address1"] == null ? null : json["gym_address1"],
        gymType: json["gym_type"] == null ? null : json["gym_type"],
        gymAddress2: json["gym_address2"] == null ? null : json["gym_address2"],
        gymCity: json["gym_city"] == null ? null : json["gym_city"],
        gymState: json["gym_state"] == null ? null : json["gym_state"],
        gymLat: json["gym_lat"] == null ? null : json["gym_lat"],
        gymLong: json["gym_long"] == null ? null : json["gym_long"],
        gymPin: json["gym_pin"] == null ? null : json["gym_pin"],
        gymCountry: json["gym_country"] == null ? null : json["gym_country"],
        gymCoverImage:
            json["gym_cover_image"] == null ? null : json["gym_cover_image"],
        nSession: json["n_session"],
        eventName: json["event_name"],
        eventDate: json["event_date"],
        addonName: json["addon_name"],
        isPt: json["is_pt"] == null ? null : json["is_pt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "gym_id": gymId == null ? null : gymId,
        "user_id": userId == null ? null : userId,
        "price": price == null ? null : price,
        "trx_id": trxId == null ? null : trxId,
        "trx_status": trxStatus == null ? null : trxStatus,
        "tax_percentage": taxPercentage == null ? null : taxPercentage,
        "tax_amount": taxAmount == null ? null : taxAmount,
        "order_status": orderStatus == null ? null : orderStatus,
        "date_added": dateAdded == null ? null : dateAdded!.toIso8601String(),
        "addon": addon == null ? null : addon,
        "start_date": startDate == null ? null : startDate!.toIso8601String(),
        "expire_date":
            expireDate == null ? null : expireDate!.toIso8601String(),
        "coupon": coupon == null ? null : coupon,
        "remark": remark == null ? null : remark,
        "type": type == null ? null : type,
        "order_id": orderId == null ? null : orderId,
        "receipt": receipt == null ? null : receipt,
        "subscription_status":
            subscriptionStatus == null ? null : subscriptionStatus,
        "order_id_success": orderIdSuccess,
        "is_partial": isPartial == null ? null : isPartial,
        "is_goal": isGoal == null ? null : isGoal,
        "plan_name": planName == null ? null : planName,
        "plan_image": planImage == null ? null : planImage,
        "gym_name": gymName == null ? null : gymName,
        "gym_address1": gymAddress1 == null ? null : gymAddress1,
        "gym_type": gymType == null ? null : gymType,
        "gym_address2": gymAddress2 == null ? null : gymAddress2,
        "gym_city": gymCity == null ? null : gymCity,
        "gym_state": gymState == null ? null : gymState,
        "gym_lat": gymLat == null ? null : gymLat,
        "gym_long": gymLong == null ? null : gymLong,
        "gym_pin": gymPin == null ? null : gymPin,
        "gym_country": gymCountry == null ? null : gymCountry,
        "gym_cover_image": gymCoverImage == null ? null : gymCoverImage,
        "n_session": nSession,
        "event_name": eventName,
        "event_date": eventDate,
        "addon_name": addonName,
        "is_pt": isPt == null ? null : isPt,
      };
}
