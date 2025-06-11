import 'package:flutter/material.dart';
import '../../../data/models/studentinfo_model.dart'; // تأكد من المسار الصحيح

class StudentsList extends StatelessWidget {
  final List<StudentInfoModel> students;

  const StudentsList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: students.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final student = students[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffd8f4f0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  student.grade,
                  style: const TextStyle(
                    color: Color(0xff00b9b0),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  student.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundImage: NetworkImage(student.image),
                radius: 22,
              ),
            ],
          ),
        );
      },
    );
  }
}
