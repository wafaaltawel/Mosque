// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran/core/constants/appBar.dart';
// import 'package:quran/core/constants/fonts.dart';
// import 'package:quran/core/network/api_service.dart';
// import 'package:quran/core/network/dio_helper.dart';
// import 'package:quran/data/repositories/attendancer_repository.dart';
// import 'package:quran/data/repositories/listening_repository.dart';
// import 'package:quran/data/repositories/main_repositries.dart';
// import 'package:quran/presentation/blocs/attendance/attendance_bloc.dart';
// import 'package:quran/presentation/blocs/listening/listening_bloc.dart';
// import 'package:quran/presentation/blocs/listening/listening_event.dart';
// import 'package:quran/presentation/blocs/main/main_bloc.dart';
// import 'package:quran/presentation/blocs/main/main_event.dart';
// import 'package:quran/presentation/blocs/main/main_state.dart';
// import 'package:quran/presentation/blocs/teacher/teacher_bloc.dart';
// import 'package:quran/presentation/blocs/teacher/teacher_event.dart';
// import 'package:quran/presentation/screens/listening_screen.dart';
// import 'package:quran/presentation/screens/main_screen.dart';
// import 'package:quran/presentation/screens/attendance_screen.dart';
// import 'package:quran/presentation/widgets/home_widgets/buildEmptyState.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int currentIndex = 1;

//   late final MainRepository mainRepo;
//   late final ListeningRepository listeningRepo;
//   late final AttendanceRepository attendanceRepo;

//   @override
//   void initState() {
//     super.initState();
//     final dio = DioHelper.createDio();
//     final apiService = ApiService(dio);

//     mainRepo = MainRepository(apiService);
//     listeningRepo = ListeningRepository(apiService);
//     attendanceRepo = AttendanceRepository(apiService);

//     // تحميل بيانات الأستاذ
//     context.read<TeacherBloc>().add(LoadTeacherProfile());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => MainBloc(mainRepo)..add(LoadMainData())),
//         BlocProvider(
//           create: (_) => ListeningBloc(listeningRepo)..add(LoadListening()),
//         ),
//       ],
//       child: BlocBuilder<MainBloc, MainState>(
//         builder: (context, state) {
//           if (state is MainLoaded) {
//             final mainData = state.data;

//             if (mainData.groups.isEmpty) {
//               return EmptyStateWidget(
//                 icon: Icons.info_outline,
//                 title: "عذراً، لا يوجد أي بيانات لعرضها حالياً.",
//                 subtitle: "يرجى المحاولة مرة أخرى لاحقاً.",
//                 onRetry: () => context.read<MainBloc>().add(LoadMainData()),
//               );
//             }

//             final group = mainData.groups[0];

//             if (group.students.isEmpty) {
//               return EmptyStateWidget(
//                 icon: Icons.group_off,
//                 title: "لا يوجد طلاب في هذه المجموعة.",
//                 subtitle: "يرجى إضافة طلاب أو اختيار مجموعة أخرى.",
//                 onRetry: () => context.read<MainBloc>().add(LoadMainData()),
//               );
//             }

//             return BlocProvider(
//               create: (_) =>
//                   AttendanceBloc(attendanceRepo, group.students, 1, group.id),
//               child: buildScaffold(),
//             );
//           }

//           if (state is MainLoading) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (state is MainError) {
//             print(state.message);
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.message,
//                     style: const TextStyle(fontSize: 16, color: Colors.red),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<MainBloc>().add(LoadMainData());
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF2b836b),
//                     ),
//                     child: const Text('إعادة المحاولة'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   Widget buildScaffold() {
//     return Scaffold(
//       backgroundColor: const Color(0xfff3f6fb),
//       appBar: CustomAppBar(),
//       body: IndexedStack(
//         index: currentIndex,
//         children: const [ListeningScreen(), MainScreen(), AttendanceScreen()],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         selectedItemColor: const Color(0xFF2b836b),
//         unselectedItemColor: Colors.grey,

//         selectedLabelStyle: FontStyles.bodyText,
//         unselectedLabelStyle: FontStyles.bodyText,

//         onTap: (index) {
//           setState(() => currentIndex = index);
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'التسميع'),
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
//           BottomNavigationBarItem(icon: Icon(Icons.check), label: 'الحضور'),
//         ],
//       ),
//     );
//   }
// }
