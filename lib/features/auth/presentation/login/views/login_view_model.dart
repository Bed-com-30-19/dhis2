import '../../../auth_library.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final LoginUseCase loginUseCase;
  bool isLoading = false;

  LoginViewModel(
    this.loginUseCase,
  );

  Future<void> login(
    String username,
    String password,
    String url,
    Function(String) onError,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      final authEntity = AuthEntity(url: url, username: username, password: password);
      await loginUseCase.execute(authEntity);
    } catch (e) {
      onError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
