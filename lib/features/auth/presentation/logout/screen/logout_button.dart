import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth_library.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutViewModel = context.watch<LogoutViewModel>();

    return logoutViewModel.isLoading
      ? const Center(child: CircularProgressIndicator())
        : ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {
            logoutViewModel.logout(
              onSuccess: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            );
          },
        );
  }
}
