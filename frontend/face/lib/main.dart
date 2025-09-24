import 'dashboard/mark_attendance_page.dart';
import 'package:flutter/material.dart';
import 'screen/login.dart'; // Login screen
import 'dashboard/home.dart'; // Home screen
import 'services/api_service.dart'; // API calls
import 'dashboard/Face_Registration_page.dart';
import 'dashboard/Face_Recognition_page.dart';

void main() {
  runApp(const FaceApp());
}

class FaceApp extends StatelessWidget {
  const FaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face Attendance App',
      theme: ThemeData(
        fontFamily: "Roboto",
        scaffoldBackgroundColor: const Color(0xFFF5F8FD),
      ),
      // App starts at LoginPage
      home: const LoginPage(), // 👈 Directly open this page
      routes: {
        // '/': (context) =>
        //     const LoginPage(), // Set the default route as LoginPage
        '/home': (context) => const HomePage(),
        '/mark_attendance': (context) => const MarkAttendancePage(),
        '/face_registration': (context) => const FaceRegistrationPage(),
        '/face_recognition': (context) => const FaceRecognitionPage(),
      },
    );
  }
}
