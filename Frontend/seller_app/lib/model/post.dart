// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

class Post {
  int? id;
  String title;
  String content;
  String dateTime;
  String username;

  Post({
     this.id,
    required this.title,
    required this.content,
    required this.dateTime,
    required this.username,
  });

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    dateTime: json["dateTime"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "dateTime": dateTime,
    "username": username,
  };
}
