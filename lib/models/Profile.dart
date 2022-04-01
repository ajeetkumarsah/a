class Profile {
  bool isDeactivated;
  String userStatus;
  String userType;
  // Permissions permissions;
  String id;
  String fullName;
  String userId;
  String email;
  int v;
  String country;
  String currency;
  String language;
  String timeZone;
  String company;
  String phone;
  String website;
  String avatar;

  Profile({
    required this.isDeactivated,
    required this.userStatus,
    required this.userType,
    // required this.permissions,
    required this.id,
    required this.fullName,
    required this.userId,
    required this.email,
    required this.v,
    required this.country,
    required this.currency,
    required this.language,
    required this.timeZone,
    required this.company,
    required this.phone,
    required this.website,
    required this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      isDeactivated: json["isDeactivated"],
      userStatus: json["userStatus"],
      userType: json["userType"],
      // permissions: Permissions.fromJson(json["permissions"]),
      id: json["_id"],
      fullName: json["fullName"],
      userId: json["userId"],
      email: json["email"],
      v: json["__v"],
      country: json["country"],
      currency: json["currency"],
      language: json["language"],
      timeZone: json["timeZone"],
      company: json["company"],
      phone: json["phone"],
      website: json["website"],
      avatar: json["avatar"],
    );
  }
}

class Permissions {
  Permissions({
    required this.deals,
    required this.contComp,
    required this.tickets,
    required this.tasks,
  });

  ContComp deals;
  ContComp contComp;
  ContComp tickets;
  ContComp tasks;

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
        deals: ContComp.fromJson(json["deals"]),
        contComp: ContComp.fromJson(json["contComp"]),
        tickets: ContComp.fromJson(json["tickets"]),
        tasks: ContComp.fromJson(json["tasks"]),
      );

  Map<String, dynamic> toJson() => {
        "deals": deals.toJson(),
        "contComp": contComp.toJson(),
        "tickets": tickets.toJson(),
        "tasks": tasks.toJson(),
      };
}

class ContComp {
  ContComp({
    required this.communicate,
    required this.delete,
    required this.edit,
    required this.view,
  });

  String communicate;
  String delete;
  String edit;
  String view;

  factory ContComp.fromJson(Map<String, dynamic> json) => ContComp(
        communicate: json["communicate"],
        delete: json["delete"],
        edit: json["edit"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "communicate": communicate,
        "delete": delete,
        "edit": edit,
        "view": view,
      };
}
