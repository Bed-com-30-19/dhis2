import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../auth_library.dart';


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  

  AuthRemoteDataSourceImpl();

  @override
  Future<Map<String, dynamic>> login(String baseUrl, String username, String password) async {
    try {
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      final response = await http.get(
        Uri.parse('$baseUrl/api/me'),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));


      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final userId = responseBody['id'];
        
        return {
          'token': basicAuth,
          'baseUrl': baseUrl,
          'userId': userId,
        };
      } else {
        throw _handleErrorResponse(response);
      }
    } on SocketException {
      throw const AuthException('No Internet connection');
    } on TimeoutException {
      throw const AuthException('Request timed out');
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Exception _handleErrorResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = jsonDecode(response.body);
    final message = responseBody['message'] ?? 'Authentication failed';

    switch (statusCode) {
      case 401: return const AuthException('Invalid credentials');
      case 403: return const AuthException('Access denied');
      case 500: return const AuthException('Server error');
      default: return AuthException('$message (Status: $statusCode)');
    }
  }

  @override
  Future<void> logout() async {
    // No server-side logout needed for Basic Auth
    return Future.value();
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}