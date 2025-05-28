import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../auth_library.dart';
import 'dart:convert';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> login(AuthModel authModel) async {
    try {

      final response = await client.post(
        Uri.parse('https://project.ccdev.org/ictprojects/api/me'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(authModel.toJson()),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        String token = responseData['token'];
        
        return token;

      } else if (response.statusCode == 401) {

        throw Exception(responseBody['message'] ?? 'Invalid username or password. Please try again.');
      } else if (response.statusCode == 500) {

        throw Exception(responseBody['message'] ?? 'Server error. Please try again later.');
      } else {

        throw Exception(responseBody['message'] ?? 'Something went wrong. Please try again.');
      }
    } on SocketException {

      throw Exception('No Internet connection. Please check your network and try again.');
    } on TimeoutException {

      throw Exception('Request timed out. Please try again.');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout(String token) async {
    final response = await client.post(
      Uri.parse('/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Logout failed');
    }
  }

}