import 'package:shared_preferences/shared_preferences.dart';

class DataFromPrefs {
  static Future<SharedPreferences> get _prefs async => 
      await SharedPreferences.getInstance();

  static Future<Map<String, String?>> getAuthData() async {
    final prefs = await _prefs;
    return {
      'token': prefs.getString('auth_token'),
      'baseUrl': prefs.getString('base_url'),
      'userId': prefs.getString('user_id'),
    };
  }

  static Future<String?> getAuthToken() async {
    final prefs = await _prefs;
    return prefs.getString('auth_token');
  }

  static Future<String?> getBaseUrl() async {
    final prefs = await _prefs;
    return prefs.getString('base_url');
  }
}