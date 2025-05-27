import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackwise/features/app_view/app_view.dart';
import 'core/dependencies/dependency_injection.dart';
import 'login_screen.dart'; // <- import the login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final providers = await DependencyInjection.initialize();

  runApp(
    MultiProvider(
      providers: providers,
      child: AppView(), // replace with LoginScreen() if you want to start there
    ),
  );
}
