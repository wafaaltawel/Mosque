import 'package:flutter/material.dart';
import 'package:quran/presentation/screens/attendance_screen.dart';

class Bottomnavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Bottomnavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF2b836b),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'التسميع'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: 'الحضور'),
      ],
    );
  }
}
