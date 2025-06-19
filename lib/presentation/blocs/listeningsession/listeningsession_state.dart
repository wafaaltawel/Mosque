import 'package:quran/data/models/main_data_model.dart';

abstract class ListeningSessionState {}

class ListeningSessionInitial extends ListeningSessionState {}

class ListeningSessionLoading extends ListeningSessionState {}

class ListeningSessionLoaded extends ListeningSessionState {
  final List<StudentModel> students;

  ListeningSessionLoaded(this.students);
}

class ListeningSessionSuccess extends ListeningSessionState {}

class ListeningSessionError extends ListeningSessionState {
  final String message;

  ListeningSessionError(this.message);
}
