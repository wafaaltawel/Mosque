import 'package:dio/dio.dart';
import 'package:quran/core/constants/baseUrl.dart';
import 'package:quran/data/models/listening_model.dart';
import 'package:quran/presentation/screens/login_screen.dart';
import 'package:quran/session_manager.dart';
import '../../data/models/main_data_model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<dynamic> post(String path, {dynamic data, Options? options}) async {
    final response = await dio.post(path, data: data, options: options);
    return response.data;
  }

  Future<MainDataModel> fetchMainData() async {
    final teacherId =
        await SessionManager.getTeacherId(); // Get saved teacher ID
    print("Cached teacher ID: $teacherId");
    if (teacherId == null) {
      throw Exception("Teacher ID is null. Please login again.");
    }

    final response = await dio.get(
      '${AppConstants.baseUrl}/teachers/mobile/$teacherId',
      queryParameters: {
        'campaign_id': 1, // Manually add campaign_id=1 here
      },
    );
    return MainDataModel.fromJson(response.data);
  }

  Future<List<ListeningModel>> fetchListeningData() async {
    final teacherId = await SessionManager.getTeacherId();
    if (teacherId == null) {
      throw Exception("Teacher ID is null. Please login again.");
    }

    final response = await dio.get(
      '${AppConstants.baseUrl}/saving-sessions/filter?dateTo=2025-12-31&dateFrom=2024-01-01&teacherId=$teacherId',
    );

    final data = response.data;

    if (data is List) {
      return data.map((item) => ListeningModel.fromJson(item)).toList();
    } else {
      throw Exception("Unexpected response format: expected a list");
    }
  }

  Future<void> startListeningSession({
    required int studentId,
    required int startPage,
    required int endPage,
  }) async {
    final data = {
      'student_id': studentId,
      'start_page': startPage,
      'end_page': endPage,
    };

    await dio.post(
      '${AppConstants.baseUrl}/start-listening-session',
      data: data,
    ); // غيّر الرابط إذا لزم
  }

  Future<dynamic> get(String url, {Options? options}) async {
    final response = await dio.get(url, options: options);
    return response.data;
  }
}
