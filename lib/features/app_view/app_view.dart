import 'package:flutter/material.dart';
import '../attendance/attendance_libray.dart';
import '../auth/auth_library.dart';
import '../dashboard/dashboard_library.dart';
import '../examination/examination_library.dart';
import '../excel_import/excel_library.dart';
import '../qr_code_scanning/qr_code_scanning_library.dart';
import '../getting-started/presentation/getting_started_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GettingStartedScreen(),
      routes: {
          '/login': (context) => const LoginScreen(),
          '/import-file': (context) => const ImportExcelFileScreen(),
          '/attendance': (context) => const AttendanceScreen(),
          '/examination': (context) => const ExaminationScreen(),
          '/managerial-dashboard': (context) => const ManagerialDashboard(),
          '/invigilation-dashboard': (context) => const InvigilationDashboard(),
          '/qrcode-scanner': (context) => const QRCodeScannerScreen(),
          '/select-attendance-method': (context) => SelectAttendanceMethodScreen(),
          '/use-old-data': (context) => UseOldDataScreen(),
        },
    );
  }
}