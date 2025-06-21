import 'package:quran/data/models/attendancemodel.dart';
import 'package:quran/presentation/widgets/attendance_widgets/enum_attendance.dart';

abstract class AttendanceEvent {}

class UpdateStudentAttendance extends AttendanceEvent {
  final int studentId;
  final AttendanceEnumStatus status;

  UpdateStudentAttendance(this.studentId, this.status);
}

class UpdateAllAttendance extends AttendanceEvent {
  final Map<int, AttendanceEnumStatus> statuses;
  final Map<int, int> delays;

  UpdateAllAttendance(this.statuses, this.delays);
}

class SubmitAttendance extends AttendanceEvent {
  SubmitAttendance(List<AttendanceModel> list);
}