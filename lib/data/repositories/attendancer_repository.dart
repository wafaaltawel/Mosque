import 'package:quran/core/network/api_service.dart';
import 'package:quran/data/models/attendancemodel.dart';

class AttendanceRepository {
  final ApiService api;

  AttendanceRepository(this.api);

  Future<void> sendAttendance(List<AttendanceModel> list) async {
    await api.post('attendance/submit', data: list.map((e) => e.toJson()).toList());
  }
}
