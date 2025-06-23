import 'package:flutter/material.dart';

class SessionTimer extends StatelessWidget {
  final String time;
  final int currentPage;

  const SessionTimer({required this.time, required this.currentPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF2b836b),
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'الصفحة $currentPage',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
