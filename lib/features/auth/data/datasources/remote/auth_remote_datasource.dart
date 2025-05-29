
abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String baseUrl, String username, String password);
  Future<void> logout();
}