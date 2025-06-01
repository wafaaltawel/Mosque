import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/class_info_card.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/main_app_bar.dart';
import 'package:quran/presentation/widgets/main_screen_widgets.dart/students_list.dart';
import '../blocs/main_bloc.dart';
import '../blocs/main_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fb),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MainAppBar(),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoaded) {
            return Column(
              children: [
                ClassInfoCard(data: state.data),
                Expanded(child: StudentsList(students: state.data.students)),
              ],
            );
          } else if (state is MainLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xff00b9b0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'التسميع'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'الحضور'),
        ],
      ),
    );
  }
}
