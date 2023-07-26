import 'package:dio/dio.dart';
import 'package:seller_app/constants/constants.dart';

class Http {
  late Dio dio;

  Http() {
    //load form storage
    BaseOptions options = BaseOptions(
      baseUrl: Constants.BASE_URL ?? "http://localhost:3000",
      connectTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
    // add token header
    dio.options.headers['Authorization'] = "Bearer token";
  }
}
