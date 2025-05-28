import '../../auth_library.dart';

class AuthEntity {
  final String url;
  final String username;
  final String password;

  AuthEntity({
    required this.url,
    required this.username,
    required this.password,
  });

  factory AuthEntity.fromModel(AuthModel entity) {
    return AuthEntity(
      url: entity.url,
      username: entity.username,
      password: entity.password,
    );
  }

}
