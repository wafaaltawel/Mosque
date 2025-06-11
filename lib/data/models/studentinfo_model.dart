class StudentInfoModel {
  final String name;
  final String image;
  final String grade;

  StudentInfoModel({
    required this.name,
    required this.image,
    required this.grade,
  });

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      name: json['name'],
      image: json['image'],
      grade: json['grade'],
    );
  }
}
