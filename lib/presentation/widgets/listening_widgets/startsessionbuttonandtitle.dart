import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/constants/fonts.dart';
import 'package:quran/data/repositories/listening_session_repository.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_bloc.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_event.dart';
import 'package:quran/presentation/blocs/main/main_bloc.dart';
import 'package:quran/presentation/blocs/main/main_state.dart';
import 'package:quran/presentation/widgets/listening_widgets/start_session_sheet.dart';

class StartSessionButtonAndTitle extends StatelessWidget {
  const StartSessionButtonAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              print("بدأ جلسة تسميع");
              // 👇 اجلب الطلاب من MainBloc
              final mainState = context.read<MainBloc>().state;
              if (mainState is MainLoaded) {
                if (mainState.data.groups.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('لا توجد مجموعات لعرض الطلاب'),
                    ),
                  );
                  return; // تمنع الاستمرار بدون بيانات
                }

                final students = mainState.data.groups[0].students;

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        ListeningSessionBloc(ListeningSessionRepository())
                          ..add(LoadStudentsSessionEvent()),
                    child: StartSessionSheet(students: students),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('الرجاء الانتظار حتى تحميل البيانات'),
                  ),
                );
              }
            },

            child: Text(
              "بدء جلسة تسميع",
              style: FontStyles.bodyText.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "جلسات التسميع",
            style: FontStyles.bodyText.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
