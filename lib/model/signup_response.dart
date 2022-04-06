class SignupResponse {
  SignupResponse({
    this.uid,
    this.dateAdded,
  });

  String? uid;
  String? dateAdded;

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        uid: json["uid"] == null ? null : json["uid"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "date_added": dateAdded == null ? null : dateAdded,
      };
}
