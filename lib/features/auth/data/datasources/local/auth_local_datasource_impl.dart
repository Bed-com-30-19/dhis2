import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth_library.dart';
//import 'dart:convert';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString('auth_token', token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString('auth_token');
  }

  @override
  Future<void> clearToken() async {
    await prefs.remove('auth_token');
  }
  
  // @override
  // UserAccountModel extractUserData(String token) {
  //   try {

  //     final parts = token.split('.');
  //     if (parts.length != 3) throw Exception('Invalid token format');

  //     final payload = parts[1];
  //     final normalizedPayload = base64.normalize(payload);

  //     final decodedPayload = utf8.decode(base64.decode(normalizedPayload));

  //     final Map<String, dynamic> payloadMap = json.decode(decodedPayload);

  //     if (payloadMap['userId'] == null) {
  //       throw Exception('userId is missing or null in the token payload.');
  //     }

  //     return UserAccountModel.fromJson(payloadMap);
  //   } catch (e) {
  //     throw Exception('Error decoding token: $e');
  //   }
  // }
}