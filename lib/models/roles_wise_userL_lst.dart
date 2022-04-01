import 'package:meta/meta.dart';

class RoleWiseUserList {
  RoleWiseUserList({
    required this.users,
    required this.teams,
  });

  List<RoleWiseUser> users;
  List<Team> teams;

  factory RoleWiseUserList.fromJson(Map<String, dynamic> json) =>
      RoleWiseUserList(
        users: List<RoleWiseUser>.from(
            json["users"].map((x) => RoleWiseUser.fromJson(x))),
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
      );
}

class Team {
  Team({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
      );
}

class RoleWiseUser {
  RoleWiseUser({
    required this.id,
    required this.name,
    required this.email,
  });

  String id;
  String name;
  String email;

  factory RoleWiseUser.fromJson(Map<String, dynamic> json) => RoleWiseUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );
}
