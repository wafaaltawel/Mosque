import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/main/main_event.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/class_info_card.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/students_list.dart';
import '../blocs/main/main_bloc.dart';
import '../blocs/main/main_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fb),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoaded) {
            final groups = state.data.groups;

            if (groups.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد مجموعات لهذا المعلم',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            final firstGroup = groups.first;

            if (firstGroup.students.isEmpty) {
              return const Center(
                child: Text(
                  'لا يوجد طلاب في هذه المجموعة',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return Column(
              children: [
                ClassInfoCard(data: state.data),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MainBloc>().add(LoadMainData());
                    },
                    child: StudentsList(students: firstGroup.students),
                  ),
                ),
              ],
            );
          } else if (state is MainLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
          }
        },
      ),
    );
  }
}
