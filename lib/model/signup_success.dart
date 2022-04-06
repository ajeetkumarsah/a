class SignupSuccessModel {
  SignupSuccessModel({
    this.message,
    this.status,
    this.data,
  });

  String? message;
  bool? status;
  Data? data;

  factory SignupSuccessModel.fromJson(Map<String, dynamic> json) =>
      SignupSuccessModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.uid,
    this.dateAdded,
  });

  String? uid;
  String? dateAdded;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uid: json["uid"] == null ? null : json["uid"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "date_added": dateAdded == null ? null : dateAdded,
      };
}
