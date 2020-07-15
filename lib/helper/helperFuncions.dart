import 'package:shared_preferences/shared_preferences.dart';

class HelperFuncions {
  static String sharedPreferenceUserLoggin = "ISLOGGIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USERNAMEKEY";

  static Future<bool> saveUserLoggedIn(bool isUserLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.setBool(sharedPreferenceUserLoggin, isUserLoggedIn);
  }

  static Future<bool> saveUsername(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.setString(sharedPreferenceUserNameKey, username);
  }

  static Future<bool> saveEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.setString(sharedPreferenceUserEmailKey, email);
  }

  static Future<bool> getUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.getBool(sharedPreferenceUserLoggin);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.getString(sharedPreferenceUserNameKey);
  }
}
