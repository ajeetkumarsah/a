

import 'package:wtf_web/model/benefits.dart';

class Offer {
    Offer({
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
      dynamic lastUpdated;
      int? isTrigger;
      dynamic offerType;
      dynamic typeId;
      dynamic isPublic;
      int? isFront;
      

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        uid: json["uid"],
        gymId: json["gym_id"],
        name: json["name"],
        code: json["code"],
        validity: json["validity"],
        mode: json["mode"],
        type: json["type"],
        value: json["value"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        isTrigger: json["is_trigger"],
        offerType: json["offer_type"],
        typeId: json["type_id"],
        isPublic: json["is_public"],
        isFront: json["is_front"],

    
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "gym_id": gymId,
        "name": name,
        "code": code,
        "validity": validity,
        "mode": mode,
        "type": type,
        "value": value,
        "status":status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "is_trigger": isTrigger,
        "offer_type": offerType,
        "type_id": typeId,
        "is_public": isPublic,
        "is_front": isFront,
    };
}
