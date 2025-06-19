import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/session_repository.dart';
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
    on<Tick>(_onTick); // جديد
  }

  void _onStartSession(StartSession event, Emitter<SessionState> emit) {
    _timer?.cancel();

    // تشغيل العداد الزمني
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(Tick()); // نرسل حدث Tick لزيادة الوقت
    });

    emit(state.copyWith(
      studentName: event.studentName,
      startPage: event.startPage,
      endPage: event.endPage,
      currentPage: event.startPage,
      duration: 0,
      errors: [],
      isSessionEnded: false,
    ));
  }

  void _onTick(Tick event, Emitter<SessionState> emit) {
    emit(state.copyWith(duration: state.duration + 1)); // فقط زيادة الوقت
  }

  void _onAddError(AddError event, Emitter<SessionState> emit) {
    final newErrors = [...state.errors, event.error];
    emit(state.copyWith(errors: newErrors));
  }

  void _onEndPage(EndPage event, Emitter<SessionState> emit) {
    if (state.currentPage < state.endPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  Future<void> _onEndSession(EndSession event, Emitter<SessionState> emit) async {
    _timer?.cancel();

    await repository.submitSession(
      studentName: state.studentName,
      durationSeconds: state.duration,
      endPage: state.currentPage,
      errorIds: state.errors.map((e) => e.id).toList(),
    );

    emit(state.copyWith(isSessionEnded: true));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
