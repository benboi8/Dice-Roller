import 'package:dice_roller/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static SharedPreferences? prefs;

  static String darkMode = "darkMode";
  static String selectedAccent = "selectedAccent";
  static String addSecondButton = "addSecondButton";

  static void getInstance() async {
    prefs ??= await SharedPreferences.getInstance().then((value) {
      Future.delayed(const Duration(milliseconds: 5), () {
        Settings.getSettings();
      });
      return value;
    });
  }

  static void writeString(String key, String msg) {
    prefs?.setString(key, msg);
  }

  static String? getString(String key) {
    var value = prefs?.getString(key);
    print("$key $value");
    return value;
  }

  static int? getInt(String key) {
    var value = prefs?.getInt(key);
    print("$key $value");
    return value;
  }

  static bool? getBool(String key) {
    var value = prefs?.getBool(key);
    print("$key $value");
    return value;
  }

  static void setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  static void setInt(String key, int value) {
    prefs?.setInt(key, value);
  }
}
