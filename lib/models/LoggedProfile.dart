class LoggedProfile {
  final String id, fullName, userId, email, avatar, phone;

  LoggedProfile(
      {required this.id,
      required this.fullName,
      required this.userId,
      required this.email,
      required this.avatar,
      required this.phone});

  factory LoggedProfile.fromJson(Map<String, dynamic> json) {
    return LoggedProfile(
      id: json["_id"],
      fullName: json["fullName"],
      userId: json["userId"],
      email: json["email"],
      avatar: json["avatar"],
      phone: json["phone"],
    );
  }
}
