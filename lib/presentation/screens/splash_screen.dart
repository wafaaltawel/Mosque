// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _checkLoginStatus(context);
    return const Scaffold(
      backgroundColor: Color(0xFF2b836b),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final teacherId = prefs.getInt('teacher_id');

    await Future.delayed(const Duration(seconds: 1)); // اختياري للتجربة البصرية

    if (token != null && teacherId != null) {
      // المستخدم مسجل دخول مسبقًا
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // المستخدم غير مسجل دخول
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
