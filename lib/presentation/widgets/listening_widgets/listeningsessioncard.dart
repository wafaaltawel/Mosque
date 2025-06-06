import 'package:flutter/material.dart';
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
                Text(data.teacherName, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: data.isPassed ? Colors.green[50] : Colors.red[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    data.isPassed ? 'ناجح' : 'راسب',
                    style: TextStyle(
                      color: data.isPassed ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                Text(
                  "${data.points} نقطة",
                  style: const TextStyle(color: Colors.purple, fontSize: 11),
                ),
                Text(
                  "${data.time} دقائق",
                  style: const TextStyle(color: Colors.blue, fontSize: 11),
                ),
                Text(
                  data.studentName,
                  style: const TextStyle(color: Colors.teal, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
