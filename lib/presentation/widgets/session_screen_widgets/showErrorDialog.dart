import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/session_error_model.dart';
import 'package:quran/presentation/blocs/session/session_bloc.dart';

Future<SessionErrorModel?> showErrorDialog(BuildContext context) async {
  final TextEditingController pageController = TextEditingController();
  SessionErrorModel? selectedError;
  List<SessionErrorModel> errors = [];

  try {
    errors = await context.read<SessionBloc>().repository.fetchErrors();
  } catch (_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("فشل الاتصال بالخادم. حاول مرة أخرى."), backgroundColor: Colors.red),
    );
    return null;
  }

  return showDialog<SessionErrorModel>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('إضافة خطأ'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Align(alignment: Alignment.centerRight, child: Text("اختر نوع الخطأ:")),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: errors.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<SessionErrorModel>(
                        title: Text(errors[index].title),
                        value: errors[index],
                        groupValue: selectedError,
                        onChanged: (value) => setState(() => selectedError = value),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: pageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'رقم الصفحة',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
            ElevatedButton(
              onPressed: () {
                if (selectedError == null || pageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("اختر الخطأ وأدخل رقم الصفحة")),
                  );
                  return;
                }

                final int page = int.tryParse(pageController.text) ?? 0;
                final errorWithPage = SessionErrorModel(
                  id: selectedError!.id,
                  campaignId: selectedError!.campaignId,
                  title: selectedError!.title,
                  removedPoints: selectedError!.removedPoints,
                  pageNumber: page,
                );

                Navigator.pop(context, errorWithPage);
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      );
    },
  );
}
