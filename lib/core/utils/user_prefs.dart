import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const String _nameKey = 'user_name';
  static const String _emailKey = 'user_email';
  //static const String _tokenKey = 'auth_token';

  /// Saves user info to shared preferences
  static Future<void> saveToPrefs({
    required String name,
    //required String token,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
     //await prefs.setString(_tokenKey, token);
  }

  /// Retrieves user info from shared preferences
  static Future<Map<String, String?>> retrieveFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey),
      'email': prefs.getString(_emailKey),
    };
  }

  /// Optional: clear user info from shared preferences (e.g., on logout)
  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
  }

  // static Future<void> saveToken(String token) async {
  //    final prefs = await SharedPreferences.getInstance();
  //    await prefs.setString(_tokenKey, token);
  //  }

  // static Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tokenKey);
  // }

  // static Future<void> clearToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_tokenKey);
  // }
}
