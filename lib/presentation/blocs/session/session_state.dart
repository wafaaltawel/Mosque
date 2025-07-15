import 'package:quran/data/models/session_error_model.dart';

class SessionState {
  final int studentid;
  final String studentname;
  final int startPage;
  final int endPage;
  final int currentPage;
  final int duration;
  final List<SessionErrorModel> errors;
  final bool isSessionEnded;

  SessionState({
    required this.studentname,
    required this.studentid,
    required this.startPage,
    required this.endPage,
    required this.currentPage,
    required this.duration,
    required this.errors,
    required this.isSessionEnded,
  });

  factory SessionState.initial() => SessionState(
    studentid: 0,
    startPage: 0,
    endPage: 0,
    currentPage: 0,
    duration: 0,
    errors: [],
    isSessionEnded: false,
    studentname: '',
  );

  SessionState copyWith({
    int? studentid,
    String? studentName,
    int? startPage,
    int? endPage,
    int? currentPage,
    int? duration,
    List<SessionErrorModel>? errors,
    bool? isSessionEnded,
  }) {
    return SessionState(
      studentid: studentid ?? this.studentid,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      currentPage: currentPage ?? this.currentPage,
      duration: duration ?? this.duration,
      errors: errors ?? this.errors,
      isSessionEnded: isSessionEnded ?? this.isSessionEnded,
      studentname: studentName ?? studentname,

    );
  }
}
