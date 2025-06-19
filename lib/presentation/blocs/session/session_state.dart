

import 'package:quran/data/models/session_error_model.dart';

class SessionState {
  final String studentName;
  final int startPage;
  final int endPage;
  final int currentPage;
  final int duration;
  final List<SessionErrorModel> errors;
  final bool isSessionEnded;

  SessionState({
    required this.studentName,
    required this.startPage,
    required this.endPage,
    required this.currentPage,
    required this.duration,
    required this.errors,
    required this.isSessionEnded,
  });

  factory SessionState.initial() => SessionState(
        studentName: '',
        startPage: 0,
        endPage: 0,
        currentPage: 0,
        duration: 0,
        errors: [],
        isSessionEnded: false,
      );

  SessionState copyWith({
    String? studentName,
    int? startPage,
    int? endPage,
    int? currentPage,
    int? duration,
    List<SessionErrorModel>? errors,
    bool? isSessionEnded,
  }) {
    return SessionState(
      studentName: studentName ?? this.studentName,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      currentPage: currentPage ?? this.currentPage,
      duration: duration ?? this.duration,
      errors: errors ?? this.errors,
      isSessionEnded: isSessionEnded ?? this.isSessionEnded,
    );
  }
}
