
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static String getUID(){

    String? s = _preferences.getString("uid");
    return s!;

  }
  static void setUID( String uid){
    _preferences.setString("uid", uid);
  }
  static String getDisplayName(){

    String? s = _preferences.getString("displayName");
    return s!;

  }
  static void setDisplayName( String displayName){
    _preferences.setString("displayName", displayName);
  }
  static String getMobileNumber(){

    String? s = _preferences.getString("mobile_number");
    return s!;

  }
  static void setMobileNumber( String phoneNumber){
    _preferences.setString("mobile_number", phoneNumber);
  }
  static String getPhotoUrl(){

    String? s = _preferences.getString("photoUrl");
    return s!;

  }
  static void setPhotoUrl( String photoUrl){
    _preferences.setString("photoUrl", photoUrl);
  }
  static String getEmail(){

    String? s = _preferences.getString("email");
    return s!;

  }
  static void setEmail( String email){
    _preferences.setString("email", email);
  }
  static void clear(){
    _preferences.clear();
  }

  static bool containsKey(String key){
    return _preferences.containsKey(key);
  }
}