class AuthResponse {
  final String baseUrl;
  final String userId;
  final String token;
  final String userData;

  AuthResponse({
    required this.baseUrl,
    required this.userId,
    required this.token,
    required this.userData,
  });
}