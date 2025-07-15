// --- session_repository.dart ---

import 'package:quran/core/constants/baseUrl.dart';
import 'package:quran/data/models/session_error_model.dart';
import 'package:quran/presentation/screens/login_screen.dart';
import 'package:quran/session_manager.dart';
import '../../core/network/api_service.dart';

class SessionRepository {
  final ApiService api;

  SessionRepository(this.api);

  Future<void> submitSession({
    required int teacherId,
    required int studentId,
    required int campaignId,
    required int startPage,
    required int endPage,
    required int rating,
    required int durationSeconds,
    required List<SessionErrorModel> errors,
  }) async {
    final List<Map<String, dynamic>> mistakesPayload = errors
        .map(
          (e) => {
            "mistakeId": e.id,
            "pageNumber": e.pageNumber, // 👈 تحتاج إضافته في الموديل
          },
        )
        .toList();
    final teacherId = await SessionManager.getTeacherId();
    final data = {
      "teacherId": teacherId,
      "studentId": studentId,
      "campaignId": 1,
      "start": startPage,
      "end": endPage,
      "rating": 0, // يمكنك حسابه لاحقًا أو استلامه كمعامل
      "duration": durationSeconds,
      "mistakes": mistakesPayload,
    };

    await api.post('${AppConstants.baseUrl}/saving-sessions', data: data);
  }

  Future<List<SessionErrorModel>> fetchErrors() async {
    final response = await api.get(
      '${AppConstants.baseUrl}/mistakes/campaign/${1}',
    );

   final List<dynamic> list = response;
return list.map((e) => SessionErrorModel.fromJson(e)).toList();

  }
}

//للتجريب

// import 'package:quran/core/network/api_service.dart';
// import 'package:quran/data/models/session_error_model.dart';

// class SessionRepository {
//    final ApiService api;

//   SessionRepository(this.api);

//   Future<List<SessionErrorModel>> fetchErrors() async {
//     // بيانات وهمية مؤقتة
//     await Future.delayed(const Duration(milliseconds: 500));
//     return [
//       SessionErrorModel(id: 1, description: 'نسي الآية'),
//       SessionErrorModel(id: 2, description: 'أخطأ في التجويد'),
//       SessionErrorModel(id: 3, description: 'أعاد الآية'),
//     ];
//   }

//   Future<void> submitSession({
//     required String studentName,
//     required int durationSeconds,
//     required int endPage,
//     required List<int> errorIds,
//   }) async {
//     await Future.delayed(const Duration(seconds: 1)); // كأننا نرسل للـ API
//     print('تم إرسال الجلسة بنجاح:');
//     print('الطالب: $studentName');
//     print('المدة: $durationSeconds');
//     print('آخر صفحة: $endPage');
//     print('الأخطاء: $errorIds');
//   }
// }
