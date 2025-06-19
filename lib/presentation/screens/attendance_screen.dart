import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/attendancemodel.dart';
import 'package:quran/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:quran/presentation/blocs/attendance/attendance_event.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendanceScreen> {
  Map<int, int> delays = {}; // studentId -> delay

  int? selectedDelay(int studentId) => delays[studentId];

  void setDelay(int studentId, int delay) {
    setState(() => delays[studentId] = delay);
  }

  @override
  Widget build(BuildContext context) {
    final students = context.read<AttendanceBloc>().students;
    final campaignId = context.read<AttendanceBloc>().campaignId;
    final groupId = context.read<AttendanceBloc>().groupId;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text('التفقد والحضور', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: students.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final s = students[index];
                final selected = selectedDelay(s.id);
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(
                        children: [
                          _statusButton('متأخر', 500, selected, s.id, Colors.orange),
                          _statusButton('غائب', 1000, selected, s.id, Colors.pink),
                          _statusButton('حاضر', 0, selected, s.id, Colors.lightBlue),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${s.firstName} ${s.lastName}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(s.educationalClass??"لم يحدد"),
                        ],
                      ),
                     
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final now = DateTime.now();
              final list = delays.entries.map((e) => AttendanceModel(
                    studentId: e.key,
                    campaignId: campaignId,
                    groupId: groupId,
                    takenDate: now,
                    delay: e.value,
                  )).toList();
              context.read<AttendanceBloc>().add(SubmitAttendance(list));
            },
            child: const Text('إرسال'),
          )
        ],
      ),
    );
  }

  Widget _statusButton(String label, int delayValue, int? selected, int studentId, Color color) {
    final isSelected = delayValue == selected;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => setDelay(studentId, delayValue),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        ),
      ),
    );
  }
}
