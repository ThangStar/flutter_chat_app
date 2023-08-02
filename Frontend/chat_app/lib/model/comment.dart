// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

class Comment {
  int id;
  String fullName;
  String username;
  String avatar;
  String content;
  DateTime dateTime;
  int idUser;
  bool myComment;

  Comment(
      {required this.fullName,
      required this.id,
      required this.username,
      required this.avatar,
      required this.content,
      required this.dateTime,
      required this.idUser,
      required this.myComment});

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        content: json["content"],
        dateTime: DateTime.parse(json["dateTime"]),
        idUser: json["idUser"],
        myComment: bool.parse(json["my_comment"]),
        fullName: json['full_name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "content": content,
        "dateTime": dateTime.toIso8601String(),
        "idUser": idUser,
        "my_comment": myComment,
        "full_name": fullName
      };
}
