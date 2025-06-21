import 'dart:convert';
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

    await Future.delayed(const Duration(seconds: 1));

    if (token != null && teacherId != null && !_isTokenExpired(token)) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // حذف البيانات المنتهية
      await prefs.remove('token');
      await prefs.remove('teacher_id');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'];

      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return true; // إذا فشل التحليل نعتبر التوكن غير صالح
    }
  }
}
