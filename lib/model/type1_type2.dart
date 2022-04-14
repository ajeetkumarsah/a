import 'dart:convert';

class Type1Type2Model {
  Type1Type2Model(
      {this.id,
      this.uid,
      this.type,
      this.value,
      this.status,
      this.dateAdded,
      this.lastUpdated,
      this.image});

  int? id;
  String? uid;
  String? type;
  String? value;
  String? status;
  String? dateAdded;
  String? image;
  dynamic lastUpdated;

  factory Type1Type2Model.fromRawJson(String str) =>
      Type1Type2Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type1Type2Model.fromJson(Map<String, dynamic> json) =>
      Type1Type2Model(
        id: json["id"],
        uid: json["uid"],
        type: json["type"],
        value: json["value"],
        status: json["status"],
        image: json["image"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "type": type,
        "value": value,
        "status": status,
        "image": image,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
      };
}
