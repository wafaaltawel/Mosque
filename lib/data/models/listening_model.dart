class ListeningModel {
  final String teacherName;
  final String studentName;
  final String time;
  final int points;
  final bool isPassed;

  ListeningModel({
    required this.teacherName,
    required this.studentName,
    required this.time,
    required this.points,
    required this.isPassed,
  });

  factory ListeningModel.fromJson(Map<String, dynamic> json) {
    return ListeningModel(
      teacherName: json['teacher_name'],
      studentName: json['student_name'],
      time: json['time'],
      points: json['points'],
      isPassed: json['is_passed'],
    );
  }
}
