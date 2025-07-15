import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/session_repository.dart';
import 'package:quran/data/models/session_error_model.dart';
import 'package:quran/presentation/screens/login_screen.dart';
import 'package:quran/session_manager.dart';
import 'session_event.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepository repository;
  Timer? _timer;

  SessionBloc({required this.repository}) : super(SessionState.initial()) {
    on<StartSession>(_onStartSession);
    on<AddError>(_onAddError);
    on<EndPage>(_onEndPage);
    on<EndSession>(_onEndSession);
    on<Tick>(_onTick);
  }

  void _onStartSession(StartSession event, Emitter<SessionState> emit) {
  _timer?.cancel();

  _timer = Timer.periodic(const Duration(seconds: 1), (_) {
    add(Tick());
  });

  emit(
    state.copyWith(
      studentName: event.studentName,
      startPage: event.startPage,
      endPage: event.endPage,
      currentPage: event.startPage,
      duration: 0,
      errors: [],
      isSessionEnded: false,
      studentid: event.studentid,  // <-- أضف هذا السطر
    ),
  );
}

  void _onTick(Tick event, Emitter<SessionState> emit) {
    emit(state.copyWith(duration: state.duration + 1));
  }

  void _onAddError(AddError event, Emitter<SessionState> emit) {
    final newError = SessionErrorModel(
      id: event.error.id,
      title: event.error.title,
      campaignId: event.error.campaignId,
      removedPoints: event.error.removedPoints,
      pageNumber: state.currentPage, // ⬅️ أضف رقم الصفحة الحالي هنا
    );

    final updatedErrors = [...state.errors, newError];
    emit(state.copyWith(errors: updatedErrors));
  }

  void _onEndPage(EndPage event, Emitter<SessionState> emit) {
    if (state.currentPage < state.endPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  Future<void> _onEndSession(
  EndSession event,
  Emitter<SessionState> emit,
) async {
  _timer?.cancel();

  try {
final teacherId = await SessionManager.getTeacherId() ?? 0;
print({
  'teacherId': teacherId,
  'studentId': state.studentid,
  'start': state.startPage,
  'end': state.currentPage,
  'duration': state.duration,
  'rating': 0,
  'mistakes': state.errors.map((e) => e.toJson()).toList(),
});

    await repository.submitSession(
      startPage: state.startPage,
      endPage: state.currentPage,
      durationSeconds: state.duration,
      errors: state.errors,
      teacherId: teacherId, // ✅ استخدمه هنا
      studentId: state.studentid,
      campaignId: 1,
      rating: 1,
    );

    emit(state.copyWith(isSessionEnded: true));
  } catch (e) {
    print('❌ فشل إرسال الجلسة: $e');
  }
}

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
