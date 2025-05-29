import '../../auth_library.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;
  final AuthLocalDataSourceImpl localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<bool> login(String baseUrl, String username, String password) async {
    final authData = await remoteDataSource.login(baseUrl, username, password);
    await localDataSource.saveAuthData(
      authData['token']!,
      authData['baseUrl']!,
      authData['userId']!,
    );
    if(authData.isNotEmpty){
      return true;
    } else{
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearAuthData();
    await remoteDataSource.logout();
  }

  @override
  Future<bool> isAuthenticated() async {
    final authData = await localDataSource.getAuthData();
    return authData['token'] != null && 
           authData['baseUrl'] != null && 
           authData['userId'] != null;
  }
}