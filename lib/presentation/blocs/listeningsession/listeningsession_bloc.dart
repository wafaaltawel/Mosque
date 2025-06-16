
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/listening_session_repository.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_event.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_state.dart';

class ListeningSessionBloc extends Bloc<ListeningSessionEvent, ListeningSessionState> {
  final ListeningSessionRepository repository;

  ListeningSessionBloc(this.repository) : super(ListeningSessionInitial()) {
    on<LoadStudentsSessionEvent>((event, emit) async {
      emit(ListeningSessionLoading());
      try {
       // final students = await repository.fetchStudents();
       // emit(ListeningSessionLoaded(students));
      } catch (e) {
        emit(ListeningSessionError("فشل في جلب الطلاب"));
      }
    });

    on<StartSessionEvent>((event, emit) async {
      emit(ListeningSessionLoading());
      try {
        await repository.startSession(event.studentId, event.startPage, event.endPage);
        emit(ListeningSessionSuccess());
        add(LoadStudentsSessionEvent()); // إعادة تحميل عند نجاح
      } catch (e) {
        emit(ListeningSessionError("فشل في بدء الجلسة"));
      }
    });
  }
}
