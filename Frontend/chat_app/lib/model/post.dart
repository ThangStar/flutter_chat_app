// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String? images;

  Post(
      {this.images,
      this.avatar,
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

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      images: json['images'],
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

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "images": images,
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

  String toRawJson() => json.encode(toJson());

  @override
  String toString() {
    return 'Post(totalTym: $totalTym, totalComment: $totalComment, idPost: $idPost, id: $id, title: $title, content: $content, dateTime: $dateTime, username: $username, styleColor: $styleColor, isLiked: $isLiked, avatar: $avatar, avatarsLiked: $avatarsLiked, fullName: $fullName, images: $images)';
  }

  Post copyWith({
    int? totalTym,
    int? totalComment,
    int? idPost,
    int? id,
    String? title,
    String? content,
    String? dateTime,
    String? username,
    String? styleColor,
    bool? isLiked,
    String? avatar,
    String? avatarsLiked,
    String? fullName,
    String? images,
  }) {
    return Post(
      totalTym: totalTym ?? this.totalTym,
      totalComment: totalComment ?? this.totalComment,
      idPost: idPost ?? this.idPost,
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      username: username ?? this.username,
      styleColor: styleColor ?? this.styleColor,
      isLiked: isLiked ?? this.isLiked,
      avatar: avatar ?? this.avatar,
      avatarsLiked: avatarsLiked ?? this.avatarsLiked,
      fullName: fullName ?? this.fullName,
      images: images ?? this.images,
    );
  }
}
