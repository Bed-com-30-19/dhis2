import '../../auth_library.dart';

abstract class AuthRepository {
  Future<void> login(AuthEntity entity);
  Future<void> logout();
}