import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<void> setBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    return sharedPreferences.getBool(key) ?? false;
  }

  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  // 以下保存したい型を作る
}
