import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/constants/fonts.dart';
import 'package:quran/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:quran/presentation/widgets/attendance_widgets/AttendanceListItem.dart';
import 'package:quran/presentation/widgets/attendance_widgets/StatusSubmitButton.dart';

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
    final bloc = context.read<AttendanceBloc>();
    final students = bloc.students;
    final campaignId = bloc.campaignId;
    final groupId = bloc.groupId;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'التفقد والحضور',
           style:  FontStyles.bodyText,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: students.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 80),
                            Icon(Icons.info_outline,
                                size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'لا يوجد طلاب في هذه المجموعة',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    itemCount: students.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final s = students[index];
                      return AttendanceListItem(
                        student: s,
                        selectedDelay: selectedDelay(s.id),
                        onSetDelay: (delay) => setDelay(s.id, delay),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          StatusSubmitButton(
            delays: delays,
            campaignId: campaignId,
            groupId: groupId,
          ),
        ],
      ),
    );
  }
}
