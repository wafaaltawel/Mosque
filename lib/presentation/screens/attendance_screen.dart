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
  Map<int, int> delays = {}; // studentId -> delay in minutes

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
          const Text(
            'التفقد والحضور',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
                          _statusButton(
                            'متأخر',
                            500,
                            selected,
                            s.id,
                            Colors.orange,
                          ),
                          _statusButton(
                            'غائب',
                            1000,
                            selected,
                            s.id,
                            Colors.pink,
                          ),
                          _statusButton(
                            'حاضر',
                            0,
                            selected,
                            s.id,
                            Colors.lightBlue,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${s.firstName} ${s.lastName}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(s.educationalClass ?? "لم يحدد"),
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
            onPressed: () async {
              final now = DateTime.now();
              final formattedDate =
                  "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

              final valid = delays.entries.where((e) => e.value != -1).toList();

              if (valid.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("يرجى تحديد حالة حضور واحدة على الأقل"),
                  ),
                );
                return;
              }

              final list = valid.map((e) {
                final delay = e.value;
                String status;

                if (delay == 0) {
                  status = "ATTEND";
                } else if (delay >= 1000) {
                  status = "MISSED";
                } else {
                  status = "DELAY";
                }

                return AttendanceModel(
                  studentId: e.key,
                  campaignId: campaignId,
                  delay: delay,
                  status: status,
                  date: formattedDate, // ✅ التاريخ بصيغة yyyy-MM-dd
                );
              }).toList();

              final bloc = context.read<AttendanceBloc>();
              final success = await bloc.sendAttendanceAndWait(list);

              if (!mounted) return;

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ تم إرسال الحضور بنجاح")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ فشل إرسال الحضور")),
                );
              }
            },

            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }

  Widget _statusButton(
    String label,
    int delayValue,
    int? selected,
    int studentId,
    Color color,
  ) {
    if (delayValue == 500) {
      final isSelected = selected != null && selected > 0 && selected <= 90;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () async {
            final chosenDelay = await showModalBottomSheet<int>(
              context: context,
              builder: (context) {
                final options = [5, 10, 15, 20, 30, 45, 60, 90];
                return ListView(
                  children: options
                      .map(
                        (minute) => ListTile(
                          title: Text('متأخر $minute دقيقة'),
                          onTap: () => Navigator.pop(context, minute),
                        ),
                      )
                      .toList(),
                );
              },
            );

            if (chosenDelay != null) {
              setDelay(studentId, chosenDelay);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              isSelected ? 'متأخر ($selected د)' : label,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      );
    }

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
          child: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
