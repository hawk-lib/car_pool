
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static String getUID(){

    String? s = _preferences.getString("uid");
    return s!;

  }

}