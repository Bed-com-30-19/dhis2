
abstract class AuthRepository {
  Future<bool> login(String baseUrl, String username, String password);
  Future<void> logout();
  Future<bool> isAuthenticated();
}