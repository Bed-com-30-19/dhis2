import 'package:flutter/material.dart';

import '../programs/screen/program_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProgramScreen(personId: "personId"),
      routes: {
          
        },
    );
  }
}