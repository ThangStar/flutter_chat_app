// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

class Profile {
  int id;
  String username;
  String password;
  String avatar;
  String fullName;

  Profile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.password,
    required this.avatar,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        fullName: json['full_name'],
        username: json["username"],
        password: json["password"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "avatar": avatar,
        "full_name": fullName
      };
}
