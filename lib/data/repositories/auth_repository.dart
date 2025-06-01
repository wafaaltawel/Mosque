import 'package:quran/data/repositories/auth_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';

class AuthRepository implements AuthRepositoryInterface {
  final ApiService api;

  AuthRepository(this.api);

  @override
  Future<void> login({required String phone, required String password}) async {
    final response = await api.post('login', data: {
      'phone': phone,
      'password': password,
    });

    if (response['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
    } else {
      throw Exception('فشل تسجيل الدخول');
    }
  }
}
