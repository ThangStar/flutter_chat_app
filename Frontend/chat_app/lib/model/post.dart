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
  String? avatarsLiked;
  String fullName;

  Post(
      {this.avatar,
      required this.fullName,
      this.avatarsLiked,
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
      avatarsLiked: json['avatar_liked'],
      totalComment: json['total_comment'],
      totalTym: json['total_tym'],
      idPost: json["id_post"],
      id: json["id"],
      title: json["title"],
      content: json["content"],
      dateTime: json["dateTime"],
      username: json["username"],
      styleColor: json["style_color"],
      isLiked: bool.parse(json['isLiked'] ?? "false"),
      fullName: json['full_name']);

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "avatar_liked": avatarsLiked,
        "total_tym": totalTym,
        "id_post": idPost,
        "id": id,
        "title": title,
        "content": content,
        "dateTime": dateTime,
        "username": username,
        "style_color": styleColor,
        'isLiked': isLiked,
        "total_comment": totalComment,
        "full_name,": fullName
      };
}
