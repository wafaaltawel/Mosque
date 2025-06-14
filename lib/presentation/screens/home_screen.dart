import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/constants/appBar.dart';
import 'package:quran/core/constants/bottomNavigation.dart';
import 'package:quran/core/network/api_service.dart';
import 'package:quran/core/network/dio_helper.dart';
import 'package:quran/data/repositories/listening_repository.dart';
import 'package:quran/data/repositories/main_repositries.dart';
import 'package:quran/presentation/blocs/listening/listening_bloc.dart';
import 'package:quran/presentation/blocs/listening/listening_event.dart';
import 'package:quran/presentation/blocs/main_bloc.dart';
import 'package:quran/presentation/blocs/main_event.dart';
import 'package:quran/presentation/blocs/main_state.dart';
import 'package:quran/presentation/screens/listening_screen.dart';
import 'package:quran/presentation/screens/main_screen.dart';
// استورد صفحة الحضور
import 'package:quran/presentation/screens/attendance_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  late final MainRepository mainRepo;
  late final ListeningRepository listeningRepo;

  @override
  void initState() {
    super.initState();
    final dio = DioHelper.createDio();
    final apiService = ApiService(dio);
    // mainRepo = MainRepository(apiService);
    // listeningRepo = ListeningRepository(apiService);
    // تجريب
    mainRepo = MainRepository();
    listeningRepo = ListeningRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainBloc(mainRepo)..add(LoadMainData())),
        BlocProvider(
          create: (_) => ListeningBloc(listeningRepo)..add(LoadListening()),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfff3f6fb),

        appBar: CustomAppBar(),

        body: IndexedStack(
          index: currentIndex,
          children: const [ListeningScreen(), MainScreen(), AttendancePage()],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: const Color(0xFF2b836b),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'التسميع'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: 'الحضور'),
          ],
        ),
      ),
    );
  }
}
