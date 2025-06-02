
import 'package:quran/data/models/listening_model.dart';

abstract class ListeningState {}

class ListeningInitial extends ListeningState {}
class ListeningLoading extends ListeningState {}
class ListeningLoaded extends ListeningState {
  final List<ListeningModel> listening;
  ListeningLoaded(this.listening);
}
class ListeningError extends ListeningState {
  final String message;
  ListeningError(this.message);
}
