// ignore: constant_identifier_names
enum AttendanceStatus { present, absent, late } // ✅ صحيح

class Student {
  final String name;
  final String grade;
  AttendanceStatus? status;
  String? delayDuration;

  Student({required this.name, required this.grade});
}
