import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/auth_repository.dart';
import 'package:quran/data/repositories/main_repositries.dart';
import 'package:quran/data/repositories/teacher_repository.dart';
import 'package:quran/presentation/blocs/auth/auth_bloc.dart';
import 'package:quran/presentation/blocs/main_bloc.dart';
import 'package:quran/presentation/blocs/main_event.dart';
import 'package:quran/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:quran/presentation/screens/attendance_screen.dart';
import 'package:quran/presentation/screens/home_screen.dart';
import 'package:quran/presentation/screens/login_screen.dart';
import 'package:quran/presentation/screens/main_screen.dart';
import 'core/network/api_service.dart';
import 'core/network/dio_helper.dart';

void main() {
  final dio = DioHelper.createDio(); // ✅ إنشاء Dio
  final apiService = ApiService(dio); // ✅ خدمة API

  final mainRepo = MainRepository(apiService);
  final authRepo = AuthRepository(apiService); // ✅ مستودع تسجيل الدخول
  final teacherRepo = TeacherRepository(apiService); 

  runApp(
    // للتجريب
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepo)),
        // BlocProvider(create: (_) => MainBloc(mainRepo)..add(LoadMainData())),
        BlocProvider(create: (_) => TeacherBloc(teacherRepo)),
      ],
      child: const MyApp(),
    ),
  );

  // MultiBlocProvider(
  //   providers: [
  //     BlocProvider(create: (_) => AuthBloc(authRepo)),
  //     BlocProvider(create: (_) => MainBloc(mainRepo)),
  //   ],
  //   child: const MyApp(),
  // ),
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'منصة الحلقات',
      theme: ThemeData(fontFamily: 'Cairo'), // اختياري
      routes: {
        '/': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(), // <- تغيير هنا
        '/main': (_) => const MainScreen(), // ✅ أضف هذا السطر لحل المشكلة
        '/attendance': (_) => const AttendancePage(),
      },
    );
  }
}
