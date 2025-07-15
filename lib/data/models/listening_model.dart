import 'package:quran/data/models/campaign.dart';

class ListeningModel {
  final int id;
  final int teacherId;
  final int studentId;
  final int campaignId;
  final int evaluationId;
  final int start;
  final int end;
  final int rating;
  final int duration;
  final DateTime createdAt;
  final Student student;
  final Teacher teacher;
  final Campaign campaign;
  final Evaluation evaluation;
  final List<Mistake> mistakes;

  ListeningModel({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.campaignId,
    required this.evaluationId,
    required this.start,
    required this.end,
    required this.rating,
    required this.duration,
    required this.createdAt,
    required this.student,
    required this.teacher,
    required this.campaign,
    required this.evaluation,
    required this.mistakes,
  });

  factory ListeningModel.fromJson(Map<String, dynamic> json) {
    try {
      return ListeningModel(
        id: json['id'] ?? 0,
        teacherId: json['teacherId'] ?? 0,
        studentId: json['studentId'] ?? 0,
        campaignId: json['campaignId'] ?? 0,
        evaluationId: json['evaluationId'] ?? 0,
        start: json['start'] ?? 0,
        end: json['end'] ?? 0,
        rating: json['rating'] ?? 0,
        duration: json['duration'] ?? 0,
        createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
        student: Student.fromJson(json['student'] ?? {}),
        teacher: Teacher.fromJson(json['teacher'] ?? {}),
        campaign: Campaign.fromJson(json['campaign'] ?? {}),
        evaluation: Evaluation.fromJson(json['evaluation'] ?? {}),
        mistakes: (json['mistakes'] as List<dynamic>? ?? [])
            .map((e) => Mistake.fromJson(e))
            .toList(),
      );
    } catch (e) {
      print('❌ Error parsing ListeningModel: $e');
      rethrow;
    }
  }
}

class Student {
  final int id;
  final String firstName;
  final String? lastName;

  Student({
    required this.id,
    required this.firstName,
    this.lastName,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'], // nullable
    );
  }
}

class Teacher {
  final int id;
  final String firstName;
  final String lastName;

  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}

// class Campaign {
//   final int id;
//   final String name;

//   Campaign({
//     required this.id,
//     required this.name,
//   });

//   factory Campaign.fromJson(Map<String, dynamic> json) {
//     return Campaign(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//     );
//   }
// }

class Evaluation {
  final String title;
  final int points;

  Evaluation({
    required this.title,
    required this.points,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      title: json['title'] ?? '',
      points: json['points'] ?? 0,
    );
  }
}

class Mistake {
  final int id;
  final int page;
  final String title;

  Mistake({
    required this.id,
    required this.page,
    required this.title,
  });

  factory Mistake.fromJson(Map<String, dynamic> json) {
    return Mistake(
      id: json['id'] ?? 0,
      page: json['page'] ?? 0,
      title: json['title'] ?? '',
    );
  }
}
