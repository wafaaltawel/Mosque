// import 'package:dio/dio.dart';
// import '../models/session_error.dart';

// class SessionRepository {
//   final Dio dio;

//   SessionRepository(this.dio);

//   Future<List<SessionErrorModel>> fetchErrors() async {
//     final response = await dio.get('https://your-api.com/api/session-errors');
//     final List data = response.data['data'];
//     return data.map((e) => SessionErrorModel.fromJson(e)).toList();
//   }

//   Future<void> submitSession({
//     required int studentId,
//     required int durationSeconds,
//     required int endPage,
//     required List<int> errorIds,
//   }) async {
//     await dio.post('https://your-api.com/api/session-submit', data: {
//       "student_id": studentId,
//       "duration": durationSeconds,
//       "page": endPage,
//       "errors": errorIds,
//     });
//   }
// }

//للتجريب

import 'package:quran/core/network/api_service.dart';
import 'package:quran/data/models/session_error_model.dart';

class SessionRepository {
   final ApiService api;

  SessionRepository(this.api);

  Future<List<SessionErrorModel>> fetchErrors() async {
    // بيانات وهمية مؤقتة
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      SessionErrorModel(id: 1, description: 'نسي الآية'),
      SessionErrorModel(id: 2, description: 'أخطأ في التجويد'),
      SessionErrorModel(id: 3, description: 'أعاد الآية'),
    ];
  }

  Future<void> submitSession({
    required String studentName,
    required int durationSeconds,
    required int endPage,
    required List<int> errorIds,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // كأننا نرسل للـ API
    print('تم إرسال الجلسة بنجاح:');
    print('الطالب: $studentName');
    print('المدة: $durationSeconds');
    print('آخر صفحة: $endPage');
    print('الأخطاء: $errorIds');
  }
}
