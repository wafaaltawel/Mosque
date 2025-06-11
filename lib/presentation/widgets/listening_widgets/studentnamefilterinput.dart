import 'package:flutter/material.dart';

class StudentNameFilterInput extends StatelessWidget {
  const StudentNameFilterInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.calendar_today, color: Colors.teal),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "اسم الطالب",
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
