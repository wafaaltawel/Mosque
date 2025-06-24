import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/constants/fonts.dart';
import 'package:quran/data/models/attendancemodel.dart';
import 'package:quran/presentation/blocs/attendance/attendance_bloc.dart';

class StatusSubmitButton extends StatelessWidget {
  final Map<int, int> delays;
  final int campaignId;
  final int groupId;

  const StatusSubmitButton({
    super.key,
    required this.delays,
    required this.campaignId,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
            date: formattedDate,
          );
        }).toList();

        final bloc = context.read<AttendanceBloc>();
        final success = await bloc.sendAttendanceAndWait(list);

        if (!context.mounted) return;

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ تم إرسال الحضور بنجاح")),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("❌ فشل إرسال الحضور")));
        }
      },
      child: const Text('إرسال', style: FontStyles.bodyText),
    );
  }
}
