import 'package:seller_app/utils/storage_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static getToken() {}

  static saveMyProfile(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(StoragePath.myProfile, value);
  }

  static Future<String?> getMyProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StoragePath.myProfile);
  }

  static saveUserCurrentProfile(String value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(StoragePath.userCurrentChatProfile, value);
  }

  static Future<String?> getUserCurrentProfile()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StoragePath.userCurrentChatProfile);
  }
}
