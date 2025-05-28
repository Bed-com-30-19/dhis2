import 'package:flutter/material.dart';

import '../../../../../core/utils/user_prefs.dart';
import '../../../auth_library.dart';

class LogoutViewModel extends ChangeNotifier {
  final LogoutUseCase logoutUseCase;
  bool isLoading = false;

  LogoutViewModel(this.logoutUseCase);

  Future<void> logout({required VoidCallback onSuccess}) async {
    isLoading = true;
    notifyListeners();

    try {
      await logoutUseCase.execute();
      await UserPrefs.clearPrefs();
      onSuccess();
    } catch (e) {
      throw Exception('Logout Error: \n $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}