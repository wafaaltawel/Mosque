import 'package:dio/dio.dart';
import 'package:quran/data/models/teachermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';

class TeacherRepository {
  final ApiService api;

  TeacherRepository(this.api);

  Future<TeacherModel> fetchTeacherProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token غير موجود');

    final response = await api.get(
      'https://b06d-149-34-244-163.ngrok-free.app/auth/profile',
     options: Options(
    headers: {
      'Authorization': 'Bearer $token',
    },
  ),
    );

    return TeacherModel.fromJson(response);
  }
}
