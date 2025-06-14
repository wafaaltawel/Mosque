import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/teacher_repository.dart';
import 'teacher_event.dart';
import 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final TeacherRepository repo;

  TeacherBloc(this.repo) : super(TeacherInitial()) {
    on<FetchTeacherProfile>((event, emit) async {
      emit(TeacherLoading());
      try {
        final teacher = await repo.fetchTeacherProfile();
        emit(TeacherLoaded(teacher));
      } catch (e) {
        emit(TeacherError('فشل في تحميل بيانات الأستاذ'));
      }
    });
  }
}
