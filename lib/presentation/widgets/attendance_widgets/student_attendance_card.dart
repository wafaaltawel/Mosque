// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AttendanceStatus { present, absent, late } // ✅ صحيح

class Student {
  final String name;
  final String grade;
  AttendanceStatus? status;
  String? delayDuration;

  Student({required this.name, required this.grade});
}

class StudentAttendanceCard extends StatefulWidget {
  final Student student;
  final Function(AttendanceStatus?) onStatusChanged;

  const StudentAttendanceCard({
    required this.student,
    required this.onStatusChanged,
    super.key,
  });

  @override
  State<StudentAttendanceCard> createState() => _StudentAttendanceCardState();
}

class _StudentAttendanceCardState extends State<StudentAttendanceCard> {
  void _chooseDelayDuration() async {
    final duration = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => const DelayDurationPicker(),
    );

    if (duration != null) {
      setState(() {
        widget.student.delayDuration = duration;
      });
    }
  }

  Widget _buildStatusButton(
    String label,
    AttendanceStatus status,
    Color color,
  ) {
    final isSelected = widget.student.status == status;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.student.status = status;
          widget.onStatusChanged(status);
        });

        if (status == AttendanceStatus.late) {
          _chooseDelayDuration();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // جهة اليسار: أزرار الحالة + عرض مدة التأخير إذا موجودة
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 4),
                    _buildStatusButton(
                      'متأخر',
                      AttendanceStatus.late,
                      Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    _buildStatusButton(
                      'غائب',
                      AttendanceStatus.absent,
                      Colors.pink,
                    ),
                    _buildStatusButton(
                      'حاضر',
                      AttendanceStatus.present,
                      Colors.blue,
                    ),
                  ],
                ),
                if (widget.student.status == AttendanceStatus.late &&
                    widget.student.delayDuration != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'متأخر: ${widget.student.delayDuration}',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  // backgroundImage: AssetImage('images/WIN_20250423_13_35_50_Pro.jpg'),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.student.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  widget.student.grade,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DelayDurationPicker extends StatelessWidget {
  const DelayDurationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final durations = [
      'خمس دقائق',
      'عشر دقائق',
      'ربع ساعة',
      'نصف ساعة',
      'ثلاث أرباع الساعة',
      'ساعة',
    ];

    return ListView.builder(
      itemCount: durations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(durations[index]),
          onTap: () => Navigator.pop(context, durations[index]),
        );
      },
    );
  }
}
