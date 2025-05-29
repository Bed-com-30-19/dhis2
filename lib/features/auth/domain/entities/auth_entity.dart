import '../../auth_library.dart';

class AuthEntity {
  final String baseUrl;
  final String username;
  final String password;

  AuthEntity({
    required this.baseUrl,
    required this.username,
    required this.password,
  });

  factory AuthEntity.fromModel(AuthModel entity) {
    return AuthEntity(
      baseUrl: entity.url,
      username: entity.username,
      password: entity.password,
    );
  }

}
