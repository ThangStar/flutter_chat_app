import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/api/socket_api.dart';
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
      print('error $err');
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

  static Future<Object> addPost(String title, String content, String idUser,
      String? styleColor, List<XFile>? imageSelected) async {

    //list Xfile to list multipartFile
    List<MultipartFile> images = [];
    if (imageSelected != null) {
      for (XFile image in imageSelected) {
        images.add(await MultipartFile.fromFile(image.path));
      }
    }
    try {
      Response res = await Http().dio.post(ApiPath.addPost,
      onSendProgress: (count, total) {
        print("đang tải lên: $count $total");
      },
          data: FormData.fromMap({
            'title': title,
            'content': content,
            'idUser': idUser,
            'style_color': styleColor,
            'images': images
          }));
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

  static Future<Object> getPostByIdUser(int idUser) async {
    try {
      Response res = await Http()
          .dio
          .get(ApiPath.getPostByIdUser, queryParameters: {"idUser": idUser});
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
    String? jsonProfile = await Storage.getMyProfile();
    Profile profile = Profile.fromRawJson(jsonProfile ?? "null");

    String fileName = path.split('/').last;
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(path, filename: fileName),
        "idUser": profile.id
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

  static Future<Object> searchUserByUsername(String query) async {
    try {
      Response response = await Http()
          .dio
          .get(ApiPath.searchUserByUsername, queryParameters: {"query": query});
      if (response.statusCode == 200) {
        return Success(body: response.data);
      }
      return Failure(body: response.data);
    } catch (e) {
      return Failure(message: 'error search');
    }
  }

  static Future<Object> incTymPost(int myId, int postId) async {
    try {
      Response response = await Http().dio.get(ApiPath.incTymPost,
          queryParameters: {"idUser": myId, "idPost": postId});
      if (response.statusCode == 200) {
        return Success(body: response.data);
      }
      return Failure(body: response.data);
    } catch (e) {
      return Failure(message: 'error increment tym');
    }
  }

  static Future<Object> decTymPost(int myId, int postId) async {
    try {
      Response response = await Http()
          .dio
          .post(ApiPath.decTymPost, data: {"idUser": myId, "idPost": postId});
      if (response.statusCode == 200) {
        return Success(body: response.data);
      }
      return Failure(body: response.data);
    } catch (e) {
      return Failure(message: 'error dec tym');
    }
  }

  static Future<Object> getCommentById(int idPost) async {
    try {
      String? jsonProfile = await Storage.getMyProfile();
      Profile profile = Profile.fromRawJson(jsonProfile ?? "");

      Response response = await Http().dio.get(ApiPath.getCommentByIdPost,
          queryParameters: {"idUser": profile.id, "idPost": idPost});
      if (response.statusCode == 200) {
        return Success(body: response.data);
      }
      return Failure(body: response.data);
    } catch (e) {
      return Failure(message: 'error get comment');
    }
  }

  static Future<Object> addComment(
      int idUser, int idPost, String content) async {
    try {
      Response response = await Http().dio.post(ApiPath.insertComment,
          data: {"idPost": idPost, "idUser": idUser, "content": content});
      if (response.statusCode == 200) {
        return Success(body: response.data);
      }
      return Failure(body: response.data);
    } catch (e) {
      print(e);
      return Failure(message: 'error get comment');
    }
  }

  static Future<Object> deleteOneComment(int idPost, int idComment) async {
    try {
      String? jsonProfile = await Storage.getMyProfile();
      Profile profile = Profile.fromRawJson(jsonProfile ?? "");

      Response response = await Http().dio.post(ApiPath.deleteOneComment,
          data: {
            "idUser": profile.id,
            "idPost": idPost,
            "idComment": idComment
          });
      if (response.statusCode == 200) {
        return Success(body: response.data);
      }
      return Failure(body: response.data);
    } catch (e) {
      return Failure(message: 'error deleteOne comment');
    }
  }
}
