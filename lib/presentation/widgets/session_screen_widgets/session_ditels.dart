
import 'package:flutter/material.dart';
import 'package:quran/presentation/blocs/session/session_state.dart';

class SessionDetails extends StatelessWidget {
  final SessionState state;
  const SessionDetails({required this.state});

  @override
  Widget build(BuildContext context) {
    final heardPages = state.currentPage - state.startPage;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'اسم الطالب',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(state.studentname),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'الكمية المسمعة',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('$heardPages صفحات'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _pageLabel('الصفحة ${state.endPage}'),
              _pageLabel('الصفحة ${state.startPage}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}
