import 'package:flutter/material.dart';
import 'package:quran/core/constants/fonts.dart';
import 'package:quran/data/models/listening_model.dart';

class ListeningSessionCard extends StatelessWidget {
  final ListeningModel data;
  const ListeningSessionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.arrow_back_ios, size: 10, color: Colors.grey),
                Text(
                  "${data.teacher.firstName} ${data.teacher.lastName}",
                  style: FontStyles.bodyText.copyWith(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                Text(
                  data.evaluation.title,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "${data.evaluation.points} نقطة",
                  style: const TextStyle(color: Colors.purple, fontSize: 15),
                ),
                Text(
                  "${data.duration} الوقت",
                  style: const TextStyle(color: Colors.blue, fontSize: 15),
                ),
                Text(
                  "${data.student.firstName} ${data.student.lastName}",
                  style: const TextStyle(color: Colors.teal, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
