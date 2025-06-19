import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/network/api_service.dart';
import 'package:quran/core/network/dio_helper.dart';
import 'package:quran/data/models/main_data_model.dart';
import 'package:quran/data/repositories/session_repository.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_bloc.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_event.dart';
import 'package:quran/presentation/blocs/session/session_bloc.dart';
import 'package:quran/presentation/screens/session_screen.dart';

final dio = DioHelper.createDio(); // ✅ إنشاء Dio
final apiService = ApiService(dio); // ✅ خدمة API

class StartSessionSheet extends StatefulWidget {
  final List<StudentModel> students;

  const StartSessionSheet({super.key, required this.students});

  @override
  State<StartSessionSheet> createState() => _StartSessionSheetState();
}

class _StartSessionSheetState extends State<StartSessionSheet> {
  String? selectedStudentname;
  
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
      child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "جلسة تسميع جديدة",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: selectedStudentname,
                  items: widget.students.map((StudentModel student) {
                    return DropdownMenuItem<String>(
                      value: student.firstName,
                      child: Text(
                        "${student.firstName} ${student.lastName ?? ''}",
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStudentname = value;
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
                      if (selectedStudentname == null ||
                          startPageController.text.isEmpty ||
                          endPageController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('يرجى تعبئة جميع الحقول'),
                          ),
                        );
                        return;
                      }

                      final int start =
                          int.tryParse(startPageController.text) ?? 0;
                      final int end = int.tryParse(endPageController.text) ?? 0;

                      context.read<ListeningSessionBloc>().add(
                        StartSessionEvent(
                          studentname: selectedStudentname!,
                          startPage: start,
                          endPage: end,
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (_) =>
                                SessionBloc(repository: SessionRepository(apiService)),
                            child: SessionScreen(
                              studentName: selectedStudentname!,
                              startPage: start,
                              endPage: end,
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "بدء جلسة التسميع",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            
        
        
      ),
    );
  }
}
