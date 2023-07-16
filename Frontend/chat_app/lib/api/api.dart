import 'dart:math';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/api/socket_api.dart';
import 'package:seller_app/model/post.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/utils/api_path.dart';
import 'package:seller_app/utils/http.dart';
import 'package:seller_app/utils/response.dart';

class Api {
  static Future<Object> login(String username, String password) async {
    try {
      Response res = await Http().dio.post(ApiPath.login,
          data: {"username": username, "password": password});

      if (res.statusCode == 200) {
        return Success(statusCode: 200, body: res.data);
      }
      print('error${res.statusCode}');
      return Failure(
          message: res.statusMessage.toString(),
          body: res.data,
          statusCode: res.statusCode ?? 404);
    } catch (err) {
      print('error ${err}');
      return Failure(message: err.toString());
    }
  }

  static Future<Object> getAllMessageOfUser(int myId) async {
    try {
      Response res = await Http()
          .dio
          .get(ApiPath.messageOfUser, queryParameters: {"myId": myId});
      if (res.statusCode == 200) {
        return Success(statusCode: 200, body: res.data);
      }
      return Failure(message: res.statusMessage.toString(), body: res.data);
    } catch (err) {
      return Failure(message: err.toString());
    }
  }

  static Future<Object> addPost(
      String title, String content, String idUser, String? styleColor) async {
    try {
      Response res = await Http().dio.post(ApiPath.addPost, data: {
        'title': title,
        'content': content,
        'idUser': idUser,
        'style_color': styleColor
      });
      if (res.statusCode == 200) {
        return Success(body: res.data);
      }
      return Failure(
          body: res.data,
          statusCode: res.statusCode ?? 400,
          message: res.statusMessage ?? "error");
    } catch (err) {
      return Failure(message: err.toString());
    }
  }

  static Future<Object> getPostById() async {
    try {
      Response res = await Http().dio.get(ApiPath.getPostById);
      if (res.statusCode == 200) {
        return Success(body: res.data);
      }
      return Failure(
          body: res.data,
          statusCode: res.statusCode ?? 400,
          message: res.statusMessage ?? "error");
    } catch (err) {
      print("err getPostById: $err");
      return Failure(message: err.toString());
    }
  }

  static uploadAvatar(String path) async {
    String fileName = path.split('/').last;
    print(fileName);
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(path, filename: fileName),
      });

      Response res = await Http().dio.post(
        ApiPath.uploadAvatar,
        data: formData,
        onSendProgress: (count, total) {
          print('đang tải lên..$count - $total');
        },
      );
      if (res.statusCode == 200) {
        return Success(body: res.data);
      }
      return Failure(
          body: res.data,
          statusCode: res.statusCode ?? 400,
          message: res.statusMessage ?? "error");
    } catch (err) {
      print("err getPostById: $err");
      return Failure(message: err.toString());
    }
  }

  static emitImageSocket(XFile? image) async {
    String path = image?.path ?? "";
    String? jsonProfile = await Storage.getMyProfile();
    Profile profile = Profile.fromRawJson(jsonProfile ?? "");
    int myId = profile.id;

    SocketApi(myId).socket.emit("imageFromClient", {image: path});
  }
}
