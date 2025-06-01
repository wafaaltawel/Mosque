class StudentModel {
  final String name;
  final String image;
  final String grade;

  StudentModel({
    required this.name,
    required this.image,
    required this.grade,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      image: json['image'],
      grade: json['grade'],
    );
  }
}
