class ProfileDropDownModel {
  final String fullName, userId, email;

  ProfileDropDownModel(this.fullName, this.userId, this.email);

  factory ProfileDropDownModel.fromJson(Map<String, dynamic> json) {
    return ProfileDropDownModel(
      json["fullName"],
      json["userId"],
      json["email"],
    );
  }
}