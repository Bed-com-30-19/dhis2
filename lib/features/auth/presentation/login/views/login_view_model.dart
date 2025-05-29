import 'package:flutter/foundation.dart';
import '../../../auth_library.dart';

class LoginViewModel with ChangeNotifier {
  final AuthRepositoryImpl authRepository;
  bool isLoading = false;
  String? errorMessage;
  bool loginSuccess = false; // Add this flag

  LoginViewModel(this.authRepository);

  Future<void> login(String baseUrl, String username, String password) async {
    isLoading = true;
    errorMessage = null;
    loginSuccess = false; // Reset flag
    notifyListeners();

    try {
      final response = await authRepository.login(baseUrl, username, password);
      
      loginSuccess = response; // Set flag on success
    } on AuthException catch (e) {
      errorMessage = e.message;
      loginSuccess = false;
    } catch (e) {
      errorMessage = 'An unexpected error occurred';
      loginSuccess = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}