import '../../core/network/api_service.dart';
import '../models/main_data_model.dart';

class MainRepository {
  final ApiService api;

  MainRepository(this.api);

  Future<MainDataModel> getMainData() {
    return api.fetchMainData();
  }
}

// //  لل تجريب
// import 'package:quran/data/models/main_data_model.dart';

// import '../models/studentinfo_model.dart';

// class MainRepository {
//   Future<MainDataModel> getMainData() async {
//     // تأخير وهمي لمحاكاة تحميل البيانات
//     await Future.delayed(Duration(seconds: 1));

//     return MainDataModel(
//       mosqueName: "مسجد الفرقان",
//       className: "حلقة النور",
//       teacherName: "الشيخ أحمد",
//       students: [
//         StudentInfoModel(
//           name: "علي محمد",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الرابع",
//         ),
//         StudentInfoModel(
//           name: "سعيد عبد الله",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الخامس",
//         ),
//         StudentInfoModel(
//           name: "فهد صالح",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف السادس",
//         ),
//         StudentInfoModel(
//           name: "علي محمد",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الرابع",
//         ),
//         StudentInfoModel(
//           name: "علي محمد",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الرابع",
//         ),
//         StudentInfoModel(
//           name: "علي محمد",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الرابع",
//         ),
//         StudentInfoModel(
//           name: "علي محمد",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الرابع",
//         ),
//         StudentInfoModel(
//           name: "علي محمد",
//           image: "https://via.placeholder.com/150",
//           grade: "الصف الرابع",
//         ),
//       ],
//     );
//   }
// }
