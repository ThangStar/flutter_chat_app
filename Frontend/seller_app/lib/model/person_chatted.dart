// To parse this JSON data, do
//
//     final personChatted = personChattedFromJson(jsonString);

import 'dart:convert';

class PersonChatted {
  int id;
  String message;
  String username;
  String dateTime;

  PersonChatted({
    required this.id,
    required this.message,
    required this.username,
    required this.dateTime,
  });

  factory PersonChatted.fromRawJson(String str) => PersonChatted.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PersonChatted.fromJson(Map<String, dynamic> json) => PersonChatted(
    id: json["id"],
    message: json["message"],
    username: json["username"],
    dateTime: json["dateTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "username": username,
    "dateTime": dateTime
  };
}
