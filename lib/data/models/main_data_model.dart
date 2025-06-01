import 'student_model.dart';

class MainDataModel {
  final String mosqueName;
  final String className;
  final String teacherName;
  final List<StudentModel> students;

  MainDataModel({
    required this.mosqueName,
    required this.className,
    required this.teacherName,
    required this.students,
  });

  factory MainDataModel.fromJson(Map<String, dynamic> json) {
    return MainDataModel(
      mosqueName: json['mosque_name'],
      className: json['class_name'],
      teacherName: json['teacher_name'],
      students: (json['students'] as List)
          .map((e) => StudentModel.fromJson(e))
          .toList(),
    );
  }
}
