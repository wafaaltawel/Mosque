import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/network/api_service.dart';
import 'package:quran/core/network/dio_helper.dart';
import 'package:quran/data/repositories/listening_session_repository.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_bloc.dart';
import 'package:quran/presentation/blocs/listeningsession/listeningsession_event.dart';
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
              final dio = DioHelper.createDio();
              final apiService = ApiService(dio);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => BlocProvider(
                  create: (_) => ListeningSessionBloc(
                    ListeningSessionRepository(),
                  )..add(LoadStudentsSessionEvent()),
                  child: const StartSessionSheet(),
                ),
              );
            },
            child: const Text(
              "بدء جلسة تسميع",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          const Spacer(),
          const Text(
            "جلسات التسميع",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
