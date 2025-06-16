import 'package:quran/data/models/teachermodel.dart';

abstract class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoaded extends TeacherState {
  final TeacherModel teacher;

  TeacherLoaded(this.teacher);
}

class TeacherError extends TeacherState {
  final String message;

  TeacherError(this.message);
}