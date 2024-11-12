import 'package:demo/core/data/shared_pref_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> saveFCMToken(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(SharedPrefData.fcmToken, value);
  }

  static Future<String?> getFCMToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(SharedPrefData.fcmToken);
  }
}
