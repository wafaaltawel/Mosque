import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/teacher_repository.dart';
import 'package:quran/presentation/blocs/teacher/teacher_event.dart';
import 'package:quran/presentation/blocs/teacher/teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final TeacherRepository repo;

  TeacherBloc(this.repo) : super(TeacherInitial()) {
    on<LoadTeacherProfile>((event, emit) async {
      emit(TeacherLoading());
  try {
    final teacher = await repo.getProfile();
    emit(TeacherLoaded(teacher));
  } catch (e, stackTrace) {
    print('❌ خطأ أثناء جلب بيانات الأستاذ: $e');
    print(stackTrace);
    emit(TeacherError('فشل تحميل بيانات الأستاذ'));
  }
    });
  }
}
