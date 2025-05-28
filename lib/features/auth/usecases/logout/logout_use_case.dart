import '../../auth_library.dart';

class LogoutUseCase {
  final AuthRepositoryImpl repository;

  LogoutUseCase(this.repository);

  Future<void> execute() async {
    await repository.logout();
  }
}
