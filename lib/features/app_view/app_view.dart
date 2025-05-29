import 'package:flutter/material.dart';
import 'package:trackwise/features/home_page/screens/home_screen.dart';
//import 'package:trackwise/features/programs/screen/personal_register_screen.dart';
import '../auth/auth_library.dart';
//import 'package:trackwise/features/mapping_service/patient-screening_screen.dart';
//import 'package:trackwise/lib/pages/login_screen.dart';


class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/home-page': (context) => const HomeScreen(),
        //'/program-register': (context) => const PersonRegisterScreen(),
          // '/attendance': (context) => const AttendanceScreen(),
          // '/examination': (context) => const ExaminationScreen(),
          // '/managerial-dashboard': (context) => const ManagerialDashboard(),
          // '/invigilation-dashboard': (context) => const InvigilationDashboard(),
          // '/qrcode-scanner': (context) => const QRCodeScannerScreen(),
          // '/select-attendance-method': (context) => SelectAttendanceMethodScreen(),
          // '/use-old-data': (context) => UseOldDataScreen(), 
      },
    );
  }
}