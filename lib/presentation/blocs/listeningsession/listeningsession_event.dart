abstract class ListeningSessionEvent {}

class LoadStudentsSessionEvent extends ListeningSessionEvent {}

class StartSessionEvent extends ListeningSessionEvent {
  final int studentId;
  final int startPage;
  final int endPage;

  StartSessionEvent({
    required this.studentId,
    required this.startPage,
    required this.endPage,
  });
}
