import 'package:quran/core/constants/baseUrl.dart';
import 'package:quran/core/network/api_service.dart';
import 'package:quran/data/models/attendancemodel.dart';

class AttendanceRepository {
  final ApiService api;

  AttendanceRepository(this.api);

  Future<void> sendAttendance(int groupId, int campaignId, List<AttendanceModel> list) async {
    final url = '${AppConstants.baseUrl}/attendance/$groupId/$campaignId/batch-update';

    final payload = list.map((e) => e.toJson()).toList();

    await api.post(url, data: payload);
  }
}
