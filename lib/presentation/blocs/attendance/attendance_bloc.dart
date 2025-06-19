import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/attendancemodel.dart';
import 'package:quran/data/models/main_data_model.dart';
import 'package:quran/data/repositories/attendancer_repository.dart';
import 'package:quran/presentation/blocs/attendance/attendance_event.dart';
import 'package:quran/presentation/blocs/attendance/attendance_state.dart';
import 'package:quran/presentation/widgets/attendance_widgets/enum_attendance.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repo;
  final List<StudentModel> students; // من MainDataModel
  final int campaignId;
  final int groupId;

  AttendanceBloc(this.repo, this.students, this.campaignId, this.groupId)
      : super(AttendanceState(studentStatus: {})) {
    on<UpdateStudentAttendance>((event, emit) {
      final updated = Map<int, AttendanceEnumStatus>.from(state.studentStatus)
        ..[event.studentId] = event.status;
      emit(state.copyWith(studentStatus: updated));
    });

    on<SubmitAttendance>((event, emit) async {
      emit(state.copyWith(submitting: true));
      try {
        final now = DateTime.now();
        final data = students.map((student) {
          final status = state.studentStatus[student.id] ?? AttendanceEnumStatus.present;
          return AttendanceModel(
            studentId: student.id,
            campaignId: campaignId,
            groupId: groupId,
            takenDate: now,
            delay: status.delay,
          );
        }).toList();

        await repo.sendAttendance(data);
        emit(state.copyWith(submitting: false, success: true));
      } catch (e) {
        emit(state.copyWith(submitting: false, error: e.toString()));
      }
    });
  }
}
