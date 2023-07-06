// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

class Message {
  String message;
  String idUserGet;
  String idUserSend;

  Message({
    required this.message,
    required this.idUserGet,
    required this.idUserSend,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"],
    idUserGet: json["idUserGet"],
    idUserSend: json["idUserSend"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "idUserGet": idUserGet,
    "idUserSend": idUserSend,
  };
}
