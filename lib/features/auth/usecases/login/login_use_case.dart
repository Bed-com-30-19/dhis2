import '../../auth_library.dart';

class LoginUseCase {
  final AuthRepositoryImpl repository;

  LoginUseCase(this.repository);

  Future<void> execute(AuthEntity entity) async {
    
    return await repository.login(entity);
  }
}
