// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

class Comment {
  int id;
  String username;
  String avatar;
  String content;
  DateTime dateTime;
  int idUser;

  Comment({
    required this.id,
    required this.username,
    required this.avatar,
    required this.content,
    required this.dateTime,
    required this.idUser,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    username: json["username"],
    avatar: json["avatar"],
    content: json["content"],
    dateTime: DateTime.parse(json["dateTime"]),
    idUser: json["idUser"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "avatar": avatar,
    "content": content,
    "dateTime": dateTime.toIso8601String(),
    "idUser": idUser,
  };
}
