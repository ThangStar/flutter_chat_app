import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String? BASE_URL = dotenv.env["BASE_URL"].toString();
  static String? PORT_SERVER = dotenv.env["PORT_SERVER"].toString();
  static String? SOCKET_URL = dotenv.env["SOCKET_URL"].toString();
}
