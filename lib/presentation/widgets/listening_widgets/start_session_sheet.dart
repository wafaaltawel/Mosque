import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/student_model.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_bloc.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_event.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_state.dart';

class StartSessionSheet extends StatefulWidget {
  const StartSessionSheet({super.key});

  @override
  State<StartSessionSheet> createState() => _StartSessionSheetState();
}

class _StartSessionSheetState extends State<StartSessionSheet> {
  int? selectedStudentId;
  final TextEditingController startPageController = TextEditingController();
  final TextEditingController endPageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: BlocBuilder<ListeningSessionBloc, ListeningSessionState>(
        builder: (context, state) {
          if (state is ListeningSessionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ListeningSessionLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "جلسة تسميع جديدة",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: selectedStudentId,
                  items: state.students.map((StudentModel student) {
                    return DropdownMenuItem<int>(
                      value: student.id,
                      child: Text(student.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStudentId = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "اسم الطالب",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: startPageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "صفحة البداية",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: endPageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "صفحة النهاية",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedStudentId == null ||
                          startPageController.text.isEmpty ||
                          endPageController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى تعبئة جميع الحقول')),
                        );
                        return;
                      }

                      final int start = int.tryParse(startPageController.text) ?? 0;
                      final int end = int.tryParse(endPageController.text) ?? 0;

                      context.read<ListeningSessionBloc>().add(
                            StartSessionEvent(
                              studentId: selectedStudentId!,
                              startPage: start,
                              endPage: end,
                            ),
                          );

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("بدء جلسة التسميع", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            );
          }

          if (state is ListeningSessionError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
