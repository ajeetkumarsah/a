class LoginResponse {
  LoginResponse({
    this.memDetail,
    this.uid,
    this.name,
    this.profile,
    this.email,
    this.mobile,
    this.accountType,
    this.status,
    this.token,
    this.lastLogin,
    this.dateAdded,
  });

  bool? memDetail;
  String? uid;
  String? name;
  String? profile;
  String? email;
  String? mobile;
  String? accountType;
  String? status;
  String? token;
  DateTime? lastLogin;
  DateTime? dateAdded;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        memDetail: json["memDetail"] == null ? null : json["memDetail"],
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        profile: json["profile"] == null ? null : json["profile"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        status: json["status"] == null ? null : json["status"],
        token: json["token"] == null ? null : json["token"],
        lastLogin: json["last_login"] == null
            ? DateTime.now()
            : DateTime.parse(json["last_login"]),
        dateAdded: json["date_added"] == null
            ? DateTime.now()
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "memDetail": memDetail == null ? null : memDetail,
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "profile": profile == null ? null : profile,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "account_type": accountType == null ? null : accountType,
        "status": status == null ? null : status,
        "token": token == null ? null : token,
        "last_login": lastLogin == null ? null : lastLogin,
        "date_added": dateAdded == null ? null : dateAdded,
      };
}
