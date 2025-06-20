class SessionErrorModel {
  final int id;
  final int campaignId;
  final String title;
  final int removedPoints;
  final int? pageNumber; // أضف هذا لو لم يكن موجود

  SessionErrorModel({
    required this.id,
    required this.campaignId,
    required this.title,
    required this.removedPoints,
    this.pageNumber,
  });

  factory SessionErrorModel.fromJson(Map<String, dynamic> json) {
    return SessionErrorModel(
      id: json['id'],
      campaignId: json['campaignId'],
      title: json['title'],
      removedPoints: json['removed_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "campaignId": campaignId,
      "title": title,
      "removed_points": removedPoints,
      "pageNumber": pageNumber,
    };
  }
}
