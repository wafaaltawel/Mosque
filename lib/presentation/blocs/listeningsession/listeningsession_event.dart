abstract class ListeningSessionEvent {}

class LoadStudentsSessionEvent extends ListeningSessionEvent {}

class StartSessionEvent extends ListeningSessionEvent {
  final int studentid;
  final String studentname;
  final int startPage;
  final int endPage;

  StartSessionEvent({
    required this.studentid, 
    required this.studentname,
    required this.startPage,
    required this.endPage,
  });
}
