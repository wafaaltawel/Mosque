import 'package:dio/dio.dart';
import 'package:quran/data/models/listening_model.dart';
import '../../data/models/main_data_model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
    final response = await dio.post(path, data: data);
    return response.data;
  }

  Future<MainDataModel> fetchMainData() async {
    final response = await dio.get('/main-data'); // ✨ غيّر النهاية حسب APIك
    return MainDataModel.fromJson(response.data);
  }

  Future<ListeningModel> fetchListeningData() async {
    final response = await dio.get(
      '//listening-data',
    ); // ✨ غيّر النهاية حسب APIك
    return ListeningModel.fromJson(response.data);
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

  await dio.post('/start-listening-session', data: data); // غيّر الرابط إذا لزم
}

  Future get(String s) async {}

}
