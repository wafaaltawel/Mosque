// import 'package:quran/core/network/api_service.dart';
// import 'package:quran/data/models/student_model.dart';

// class ListeningSessionRepository {
//   final ApiService apiService;

//   ListeningSessionRepository(this.apiService);

//   Future<void> startSession(int studentId, int startPage, int endPage) {
//     return apiService.startListeningSession(
//       studentId: studentId,
//       startPage: startPage,
//       endPage: endPage,
//     );
//   }

//   Future<List<StudentModel>> fetchStudents() async {
//     final response = await apiService.get('/students'); // غيّر الرابط حسب الحاجة
//     final data = response['data'] as List;
//     return data.map((e) => StudentModel.fromJson(e)).toList();
//   }
// }

//للتجريب

import 'package:quran/data/models/main_data_model.dart';
import 'package:quran/data/models/student_model.dart';

class ListeningSessionRepository {
  // ✅ لا حاجة لـ ApiService الآن
  ListeningSessionRepository();

  /// بيانات مؤقتة للطلاب
  // Future<List<StudentModel>> fetchStudents() async {
  //   await Future.delayed(const Duration(milliseconds: 500)); // محاكاة تأخير الشبكة

  //   // return [
  //   //   StudentModel(id: 1, name: 'محمد أحمد',),
  //   //   StudentModel(id: 2, name: 'سارة علي', ),
  //   //   StudentModel(id: 3, name: 'خالد يوسف',),
  //   // ];
  // }

  /// تنفيذ مؤقت لبدء الجلسة
  Future<void> startSession(int studentId, int startPage, int endPage) async {
    await Future.delayed(const Duration(seconds: 1)); // محاكاة الاتصال بالسيرفر

    // يمكنك طباعة أو تسجيل البيانات كمرجع
    print('بدء جلسة للطالب $studentId من الصفحة $startPage إلى $endPage');
  }
}
