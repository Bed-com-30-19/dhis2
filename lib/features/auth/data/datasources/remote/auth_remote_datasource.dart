import '../../../auth_library.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(AuthModel model);
  Future<void> logout(String token);
}