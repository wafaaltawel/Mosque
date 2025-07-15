import 'package:dio/dio.dart';
import 'package:quran/core/constants/baseUrl.dart';
import 'package:quran/core/network/api_service.dart';
import 'package:quran/data/models/teachermodel.dart';
import 'package:quran/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherRepository {
  final ApiService api;

  TeacherRepository(this.api);

  Future<TeacherModel> getProfile() async {
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('token');
    final token = await SessionManager.getToken();
    print('📦 التوكن المستعمل في getProfile: $token');

    if (token == null || token.isEmpty) {
      throw Exception('❌ التوكن غير موجود أو فارغ');
    }

    final response = await api.post(
      '${AppConstants.baseUrl}/auth/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    print('✅ استجابة السيرفر: $response');

    return TeacherModel.fromJson(response);
  }
}
