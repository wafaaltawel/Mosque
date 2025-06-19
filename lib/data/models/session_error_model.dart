class SessionErrorModel {
  final int id;
  final String description;

  SessionErrorModel({required this.id, required this.description});

  factory SessionErrorModel.fromJson(Map<String, dynamic> json) {
    return SessionErrorModel(
      id: json['id'],
      description: json['description'],
    );
  }
}
