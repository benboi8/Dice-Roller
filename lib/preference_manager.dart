import 'package:dice_roller/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static SharedPreferences? prefs;

  static String darkMode = "darkMode";
  static String selectedAccent = "selectedAccent";
  static String flipScreen = "flipScreen";

  static void getInstance() async {
    prefs ??= await SharedPreferences.getInstance().then((value) {Settings.getSettings(); return null;});
  }

  static void writeString(String key, String msg) {
    prefs?.setString(key, msg);
  }

  static String? getString(String key) {
    return prefs?.getString(key);
  }

  static int? getInt(String key) {
    return prefs?.getInt(key);
  }

  static void removeString(String key) {
    prefs?.remove(key);
  }

  static bool? getBool(String key) {
    return prefs?.getBool(key);
  }

  static void setBool(String key, bool value) {
    print("$key $value");
    prefs?.setBool(key, value);
  }

  static void setInt(String key, int value) {
    prefs?.setInt(key, value);
  }
}
