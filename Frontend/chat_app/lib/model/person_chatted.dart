// To parse this JSON data, do
//
//     final personChatted = personChattedFromJson(jsonString);

import 'dart:convert';

class PersonChatted {
  String fullName;
  String avatar;
  int id;
  String username;
  String message;
  String dateTime;

  PersonChatted({
    required this.fullName,
    required this.avatar,
    required this.id,
    required this.username,
    required this.message,
    required this.dateTime,
  });

  factory PersonChatted.fromRawJson(String str) => PersonChatted.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PersonChatted.fromJson(Map<String, dynamic> json) => PersonChatted(
    fullName: json['full_name'],
    avatar: json["avatar"],
    id: json["id"],
    username: json["username"],
    message: json["message"],
    dateTime: json["dateTime"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "id": id,
    "username": username,
    "message": message,
    "dateTime": dateTime,
    "full_name": fullName
  };
}
