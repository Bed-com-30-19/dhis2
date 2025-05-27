import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackwise/features/app_view/app_view.dart';
import 'core/dependencies/dependency_injection.dart';
import 'login_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final providers = await DependencyInjection.initialize();

  runApp(
    MultiProvider(
      providers: providers,
      child: Auth(), 
    ),
  );
}
