// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

class Post {
  int? idPost;
  int? id;
  String title;
  String content;
  String dateTime;
  String username;
  String? styleColor;

  Post(
      {this.idPost,
      this.id,
      required this.title,
      required this.content,
      required this.dateTime,
      required this.username,
      this.styleColor});

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        idPost: json["id_post"],
        id: json["id"],
        title: json["title"],
        content: json["content"],
        dateTime: json["dateTime"],
        username: json["username"],
        styleColor: json["style_color"],
      );

  Map<String, dynamic> toJson() => {
        "id_post": idPost,
        "id": id,
        "title": title,
        "content": content,
        "dateTime": dateTime,
        "username": username,
        "style_color": styleColor
      };
}
