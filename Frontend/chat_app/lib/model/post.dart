// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

class Post {
  int? totalTym;
  int? totalComment;
  int? idPost;
  int? id;
  String title;
  String content;
  String dateTime;
  String username;
  String? styleColor;
  bool? isLiked;
  String? avatar;

  Post(
      {this.avatar,
      this.totalComment,
      this.totalTym,
      this.idPost,
      this.id,
      required this.title,
      required this.content,
      required this.dateTime,
      required this.username,
      this.styleColor,
      this.isLiked});

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      avatar: json['avatar'],
      totalComment: json['total_comment'],
      totalTym: json['total_tym'],
      idPost: json["id_post"],
      id: json["id"],
      title: json["title"],
      content: json["content"],
      dateTime: json["dateTime"],
      username: json["username"],
      styleColor: json["style_color"],
      isLiked: bool.parse(json['isLiked'] ?? "false"));

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "total_tym": totalTym,
        "id_post": idPost,
        "id": id,
        "title": title,
        "content": content,
        "dateTime": dateTime,
        "username": username,
        "style_color": styleColor,
        'isLiked': isLiked,
        "total_comment": totalComment
      };
}
