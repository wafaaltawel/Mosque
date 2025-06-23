import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/attendancemodel.dart';
import 'package:quran/data/models/main_data_model.dart';
import 'package:quran/data/repositories/attendancer_repository.dart';
import 'package:quran/presentation/blocs/attendance/attendance_event.dart';
import 'package:quran/presentation/blocs/attendance/attendance_state.dart';
import 'package:quran/presentation/widgets/attendance_widgets/enum_attendance.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repo;
  final List<StudentModel> students;
  final int campaignId;
  final int groupId;
  Map<int, int> delayMap = {};

Future<bool> sendAttendanceAndWait(List<AttendanceModel> list) async {
  try {
    await repo.sendAttendance(groupId, campaignId, list);
    return true;
  } catch (_) {
    return false;
  }
}
  AttendanceBloc(this.repo, this.students, this.campaignId, this.groupId)
      : super(AttendanceState(studentStatus: {})) {
    on<UpdateStudentAttendance>((event, emit) {
      final updated = Map<int, AttendanceEnumStatus>.from(state.studentStatus)
        ..[event.studentId] = event.status;
      emit(state.copyWith(studentStatus: updated));
    });

    on<UpdateAllAttendance>((event, emit) {
      delayMap = event.delays;
      emit(state.copyWith(studentStatus: event.statuses));
    });
    
    


    on<SubmitAttendance>((event, emit) async {
  emit(state.copyWith(submitting: true));
  try {
    final now = DateTime.now().toIso8601String().split('T').first;

    // فلترة الطلاب الذين لديهم حالة مسجلة
    final filteredStudents = students.where((student) {
      final status = state.studentStatus[student.id];
      return status != null && status != AttendanceEnumStatus.NOT_TAKEN;
    }).toList();

    if (filteredStudents.isEmpty) {
      emit(state.copyWith(
          submitting: false, error: 'لم يتم تسجيل أي حالة حضور للطلاب'));
      return;
    }

    final data = filteredStudents.map((student) {
      final status = state.studentStatus[student.id]!;

      final delay = status == AttendanceEnumStatus.DELAY
          ? delayMap[student.id] ?? 5
          : 0;

      return AttendanceModel(
        studentId: student.id,
        campaignId: campaignId,
        status: status.apiStatus,
        delay: delay,
        date: now,
      );
    }).toList();

    await repo.sendAttendance(groupId, campaignId, data);
    emit(state.copyWith(submitting: false, success: true));
  } catch (e) {
    emit(state.copyWith(submitting: false, error: e.toString()));
  }
});}}