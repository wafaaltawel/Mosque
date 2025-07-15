import 'package:quran/data/models/mosque.dart';

class Campaign {
  final int id;
  final String days;
  final String name;
  final Mosque mosque;
  final Map<String, dynamic>? metadata; // nullable if needed

  Campaign({
    required this.id,
    required this.days,
    required this.name,
    required this.mosque,
    this.metadata,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      days: json['days'],
      name: json['name'],
      mosque: Mosque.fromJson(json['mosque']), // watch for null here too
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
    );
  }
}
