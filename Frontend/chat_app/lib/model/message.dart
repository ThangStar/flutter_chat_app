// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

class Message {
  String message;
  int idUserGet;
  int idUserSend;
  String? dateTime;

  Message({
    required this.message,
    required this.idUserGet,
    required this.idUserSend,
    this.dateTime,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"],
        idUserGet: json["idUserGet"],
        idUserSend: json["idUserSend"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "idUserGet": idUserGet,
        "idUserSend": idUserSend,
        "dateTime": dateTime,
      };
}
