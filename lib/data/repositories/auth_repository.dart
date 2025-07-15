import 'package:quran/core/constants/baseUrl.dart';
import 'package:quran/data/repositories/auth_repository_interface.dart';
import 'package:quran/presentation/screens/login_screen.dart';
import 'package:quran/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';

class AuthRepository implements AuthRepositoryInterface {
  final ApiService api;

  AuthRepository(this.api);

  @override
  Future<void> login({required String phone, required String password}) async {
    final response = await api.post(
      '${AppConstants.baseUrl}/auth/login/teacher',
      data: {'mobile_phone_number': phone, 'password': password},
    );

    print(response['access_token']);

    final token = response['access_token'];
    if (token != null) {
      // final prefs = await SharedPreferences.getInstance();
      await SessionManager.setToken(token);
      // await prefs.setString('token', token);
      print(token);
    } else {
      throw Exception('فشل تسجيل الدخول');
    }
  }
}
