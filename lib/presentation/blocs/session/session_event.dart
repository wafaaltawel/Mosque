

import 'package:quran/data/models/session_error_model.dart';

abstract class SessionEvent {}

class StartSession extends SessionEvent {
  final String studentName;
  final int startPage;
  final int endPage;

  StartSession({required this.studentName, required this.startPage, required this.endPage});
}

class AddError extends SessionEvent {
  final SessionErrorModel error;
  AddError(this.error);
}

class EndPage extends SessionEvent {}

class EndSession extends SessionEvent {}
class Tick extends SessionEvent {} // جديد

