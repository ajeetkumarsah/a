class UserProfile {
  UserProfile({
    this.uid,
    this.profile,
    this.registerBy,
    this.name,
    this.mobile,
    this.email,
    this.accountType,
    this.dateAdded,
    this.lastUpdated,
    this.lastLogin,
    this.lastIp,
    this.status,
    this.lastSeen,
  });

  String? uid;
  String? profile;
  String? registerBy;
  String? name;
  String? mobile;
  String? email;
  String? accountType;
  String? dateAdded;
  dynamic lastUpdated;
  String? lastLogin;
  String? lastIp;
  String? status;
  dynamic lastSeen;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        uid: json["uid"] == null ? null : json["uid"],
        profile: json["profile"],
        registerBy: json["register_by"] == null ? null : json["register_by"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        email: json["email"] == null ? null : json["email"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"],
        lastLogin: json["last_login"] == null ? null : json["last_login"],
        lastIp: json["last_ip"] == null ? null : json["last_ip"],
        status: json["status"] == null ? null : json["status"],
        lastSeen: json["last_seen"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "profile": profile,
        "register_by": registerBy == null ? null : registerBy,
        "name": name == null ? null : name,
        "mobile": mobile == null ? null : mobile,
        "email": email == null ? null : email,
        "account_type": accountType == null ? null : accountType,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated,
        "last_login": lastLogin == null ? null : lastLogin,
        "last_ip": lastIp == null ? null : lastIp,
        "status": status == null ? null : status,
        "last_seen": lastSeen,
      };
}
