import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/class_info_card.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/students_list.dart';
import '../blocs/main_bloc.dart';
import '../blocs/main_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fb),

      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoaded) {
            return Column(
              children: [
                ClassInfoCard(data: state.data),
                Expanded(
                  child: StudentsList(students: state.data.groups[0].students),
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
