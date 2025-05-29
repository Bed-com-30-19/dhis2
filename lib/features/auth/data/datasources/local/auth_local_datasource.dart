abstract class AuthLocalDataSource {
  Future<void> saveAuthData(String token, String baseUrl, String userId);
  Future<Map<String, String?>> getAuthData();
  Future<void> clearAuthData();
}