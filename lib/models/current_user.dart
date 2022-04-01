// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


import 'dart:convert';


class CurrentUser {
    CurrentUser({
        required this.data,
        required this.success,
        required this.message,
    });

    Data data;
    bool success;
    String message;

    factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "message": message,
    };
}

class Data {
    Data({
        required this.users,
        required this.teams,
    });

    List<User> users;
    List<Team> teams;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
    };
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

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
    });

    String id;
    String name;
    String email;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
    };
}
