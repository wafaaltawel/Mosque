import 'package:flutter/material.dart';
import 'package:quran/core/constants/appBar.dart';
import 'package:quran/core/constants/bottomNavigation.dart';
import 'package:quran/presentation/widgets/attendance_widgets/student_attendance_card.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Student> students = [
    Student(name: 'محمد الأسعد', grade: 'الصف السادس'),
    Student(name: 'أحمد الخالد', grade: 'الصف السابع'),
    Student(name: 'علي الحسين', grade: 'الصف الثامن'),
  ];

  int currentIndex = 2; // لأنك فاتح صفحة الحضور

  void _submitAttendance() {
    for (var student in students) {
      print('${student.name} - ${student.status} - ${student.delayDuration}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("صفحة التفقد", style: TextStyle(fontSize: 32)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return StudentAttendanceCard(
                    student: students[index],
                    onStatusChanged: (status) {
                      setState(() {
                        students[index].status = status;
                      });
                    },
                  );
                },
              ),
            ),
             ElevatedButton(
              onPressed: _submitAttendance,
              child: const Text('إرسال'),
            ),
          ],
        ),
      ),

     
    );
  }
}
