// import 'package:quran/data/models/listening_model.dart';

// import '../../core/network/api_service.dart';

// class ListeningRepository {
//   final ApiService api;

//   ListeningRepository(this.api);

//   Future<ListeningModel> getListeningData() {
//     return api.fetchListeningData();
//   }
// }
// للتجريب
import 'package:quran/data/models/listening_model.dart';


class ListeningRepository {
  Future<List<ListeningModel>> fetchSessions() async {
    // بيانات وهمية لتجربة الواجهة
    await Future.delayed(const Duration(seconds: 1));
    return [
      ListeningModel(
        teacherName: 'الشيخ أحمد',
        studentName: 'محمد عبد الله',
        time: '10',
        points: 8,
        isPassed: true,
      ),
      ListeningModel(
        teacherName: 'الشيخ خالد',
        studentName: 'علي منصور',
        time: '11',
        points: 5,
        isPassed: false,
      ),
      ListeningModel(
        teacherName: 'الشيخ أحمد',
        studentName: 'محمد عبد الله',
        time: '10',
        points: 8,
        isPassed: true,
      ),
      ListeningModel(
        teacherName: 'الشيخ خالد',
        studentName: 'علي منصور',
        time: '11',
        points: 5,
        isPassed: false,
      ),
      ListeningModel(
        teacherName: 'الشيخ أحمد',
        studentName: 'محمد عبد الله',
        time: '10',
        points: 8,
        isPassed: true,
      ),
      ListeningModel(
        teacherName: 'الشيخ خالد',
        studentName: 'علي منصور',
        time: '11',
        points: 5,
        isPassed: false,
      ),
    ];
  }
}
