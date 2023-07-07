import 'package:dio/dio.dart';
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
      Response res =
          await Http().dio.get(ApiPath.messageOfUser, queryParameters: {"myId": myId});
      if (res.statusCode == 200) {
        return Success(statusCode: 200, body: res.data);
      }
      return Failure(message: res.statusMessage.toString(), body: res.data);
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
