class OffersModel {
  OffersModel({
    this.id,
    this.uid,
    this.gymId,
    this.name,
    this.code,
    this.validity,
    this.mode,
    this.type,
    this.value,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.isTrigger,
    this.offerType,
    this.typeId,
    this.isPublic,
    this.isFront,
    this.gymName,
    this.typeName,
  });

  int? id;
  String? uid;
  String? gymId;
  String? name;
  String? code;
  String? validity;
  String? mode;
  String? type;
  String? value;
  String? status;
  String? dateAdded;
  String? lastUpdated;
  int? isTrigger;
  String? offerType;
  String? typeId;
  int? isPublic;
  int? isFront;
  String? gymName;
  String? typeName;

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        gymId: json["gym_id"] == null ? null : json["gym_id"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        validity: json["validity"] == null ? null : json["validity"],
        mode: json["mode"] == null ? null : json["mode"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        isTrigger: json["is_trigger"] == null ? null : json["is_trigger"],
        offerType: json["offer_type"] == null ? null : json["offer_type"],
        typeId: json["type_id"] == null ? null : json["type_id"],
        isPublic: json["is_public"] == null ? null : json["is_public"],
        isFront: json["is_front"] == null ? null : json["is_front"],
        gymName: json["gym_name"] == null ? null : json["gym_name"],
        typeName: json["type_name"] == null ? null : json["type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "gym_id": gymId == null ? null : gymId,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "validity": validity == null ? null : validity,
        "mode": mode == null ? null : mode,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "status": status == null ? null : status,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "is_trigger": isTrigger == null ? null : isTrigger,
        "offer_type": offerType == null ? null : offerType,
        "type_id": typeId == null ? null : typeId,
        "is_public": isPublic == null ? null : isPublic,
        "is_front": isFront == null ? null : isFront,
        "gym_name": gymName == null ? null : gymName,
        "type_name": typeName == null ? null : typeName,
      };
}
