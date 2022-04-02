class SignupModel {
  SignupModel({
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.accountType,
    this.status,
    this.referralCode,
    this.deviceDetails,
  });

  String? name;
  String? email;
  String? mobile;
  String? password;
  String? accountType;
  String? status;
  String? referralCode;
  List<String>? deviceDetails;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        password: json["password"] == null ? null : json["password"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        status: json["status"] == null ? null : json["status"],
        referralCode:
            json["referral_code"] == null ? null : json["referral_code"],
        deviceDetails: json["device_details"] == null
            ? null
            : List<String>.from(json["device_details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "password": password == null ? null : password,
        "account_type": accountType == null ? null : accountType,
        "status": status == null ? null : status,
        "referral_code": referralCode == null ? null : referralCode,
        "device_details": deviceDetails == null
            ? null
            : List<dynamic>.from(deviceDetails!.map((x) => x)),
      };
}
