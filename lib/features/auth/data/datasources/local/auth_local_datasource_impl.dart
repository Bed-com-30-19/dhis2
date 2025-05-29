import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth_library.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveAuthData(String token, String baseUrl, String userId) async {
    await prefs.setString('auth_token', token);
    await prefs.setString('base_url', baseUrl);
    await prefs.setString('user_id', userId);
    // await prefs.setString('base_url', username);
    // await prefs.setString('user_id', password);

  }

  @override
  Future<Map<String, String?>> getAuthData() async {
    return {
      'token': prefs.getString('auth_token'),
      'baseUrl': prefs.getString('base_url'),
      'userId': prefs.getString('user_id'),
    };
  }

  @override
  Future<void> clearAuthData() async {
    await prefs.remove('auth_token');
    await prefs.remove('base_url');
    await prefs.remove('user_id');
  }
}