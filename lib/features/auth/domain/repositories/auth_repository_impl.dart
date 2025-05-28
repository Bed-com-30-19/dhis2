import '../../auth_library.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;
  final AuthLocalDataSourceImpl localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<void> login(AuthEntity entity) async {
    final authModel = AuthModel.fromEntity(entity);

    final token = await remoteDataSource.login(authModel);

    return localDataSource.saveToken(token);
    
  }
  
  @override
  Future<void> logout() async {
    final token = await localDataSource.getToken();
    if (token != null) {
      await remoteDataSource.logout(token);
      await localDataSource.clearToken();
    }
  }
  
}
