import 'package:flutter/material.dart';

class ListeningInfoBanner extends StatelessWidget {
  const ListeningInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD6E9F9),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.info, color: Colors.blue),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "تقوم هذه الصفحة بعرض جميع جلسات التسميع",
              style: TextStyle(color: Colors.black87, fontSize: 14),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
