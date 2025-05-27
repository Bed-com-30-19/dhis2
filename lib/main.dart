import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackwise/features/app_view/app_view.dart';
import 'core/dependencies/dependency_injection.dart';

void main() async {
  //Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  
  final providers = await DependencyInjection.initialize();

  runApp(
    MultiProvider(
      providers: providers,
      child: AppView(),
    ),
  );
}
