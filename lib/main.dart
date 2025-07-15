import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/teachermodel.dart';
import 'package:quran/data/repositories/auth_repository.dart';
import 'package:quran/data/repositories/campaign_repository.dart';
import 'package:quran/data/repositories/main_repositries.dart';
import 'package:quran/data/repositories/teacher_repository.dart';
import 'package:quran/presentation/blocs/auth/auth_bloc.dart';
import 'package:quran/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:quran/presentation/blocs/campaign/campaign_event.dart';

import 'package:quran/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:quran/presentation/screens/attendance_screen.dart';
import 'package:quran/presentation/screens/campaign_screen.dart';
import 'package:quran/presentation/screens/home_screen.dart';
import 'package:quran/presentation/screens/login_screen.dart';
import 'package:quran/presentation/screens/main_screen.dart';
import 'package:quran/presentation/screens/splash_screen.dart';
import 'core/network/api_service.dart';
import 'core/network/dio_helper.dart';

void main() {
  final dio = DioHelper.createDio(); // ✅ إنشاء Dio
  final apiService = ApiService(dio); // ✅ خدمة API

  final mainRepo = MainRepository(apiService);
  final authRepo = AuthRepository(apiService); // ✅ مستودع تسجيل الدخول
  final teacherRepo = TeacherRepository(apiService);
  final campaignRepo = CampaignRepositoryImpl(dio);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>.value(value: dio),
        RepositoryProvider<CampaignRepository>(
          create: (context) => CampaignRepositoryImpl(context.read<Dio>()),
        ),
        // other repositories here
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepo)),
          BlocProvider<TeacherBloc>(create: (_) => TeacherBloc(teacherRepo)),
          // No CampaignBloc here yet, will create inside route
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/campaigns': (context) {
          final campaignRepo = RepositoryProvider.of<CampaignRepository>(
            context,
          );
          return BlocProvider(
            create: (_) => CampaignBloc(campaignRepo)..add(LoadCampaigns()),
            child: const CampaignsScreen(),
          );
        },
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        // '/login': (_) => const TeacherProfileScreen(),
        // '/home': (_) => const HomeScreen(),
        '/main': (_) => const MainScreen(),
        '/attendance': (_) => const AttendanceScreen(),
        // other routes...
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'منصة الحلقات',
//       theme: ThemeData(fontFamily: 'Cairo'),
//       routes: {
//         '/': (_) => const SplashScreen(),
//         '/login': (_) => const LoginScreen(),
//             '/campaigns': (_) => BlocProvider(
//           create: (_) => CampaignBloc(CampaignRepository())..add(LoadCampaigns()),
//           child: const CampaignsScreen(),
//         ),
//         // '/login': (_) => const TeacherProfileScreen(),
//         '/home': (_) => const HomeScreen(),
//         '/main': (_) => const MainScreen(),
//         '/attendance': (_) => const AttendanceScreen(),
//       },
//     );
//   }
// }

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data - you’ll probably get this from a provider or API
    final teacher = TeacherModel(
      id: 1,
      firstName: 'Ahmad',
      lastName: 'Yousef',
      birthDate: '1980-05-12',
      mobilePhoneNumber: '0998765432',
      educationalLevel: 'Bachelor\'s Degree',
      universityName: 'Damascus University',
      collegeName: 'Sharia College',
      specialTalent: 'Beautiful recitation',
      preservedParts: ['20'],
      workplaceName: 'Al-Iman Mosque',
      jobRole: 'Imam & Quran Teacher',
      addressArea: 'Barzeh',
      addressStreet: 'Main Street',
      addressBuilding: 'Bldg 5',
      imageUrl: 'assets/images/teacher_avatar.png',
      isWorking: true,
      isMojaz: true,
      otherMosqueNames: null,
      inAnotherMosque: false,
      fatherName: 'Yousef',
      partsTestedByEndowments: ['15'],
      password: null,
      role: 'teacher',
      createdAt: '',
      updatedAt: '',
      userType: 'Teacher',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  teacher.imageUrl ?? 'assets/images/default_avatar.png',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${teacher.firstName} ${teacher.lastName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (teacher.jobRole != null)
              Text(
                teacher.jobRole!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            const Divider(height: 32),

            // Personal Info
            _sectionTitle('Personal Info'),
            _infoTile('Birth Date', teacher.birthDate),
            _infoTile('Mobile', teacher.mobilePhoneNumber),
            _infoTile('Father Name', teacher.fatherName),
            const SizedBox(height: 16),

            // Education
            _sectionTitle('Education'),
            _infoTile('Educational Level', teacher.educationalLevel),
            _infoTile('University', teacher.universityName),
            _infoTile('College', teacher.collegeName),
            const SizedBox(height: 16),

            // Quran & Talents
            _sectionTitle('Quran & Talents'),
            _infoTile('Preserved Parts', teacher.preservedParts[0]),
            _infoTile(
              'Tested by Endowments',
              teacher.partsTestedByEndowments[0],
            ),
            _infoTile('Special Talent', teacher.specialTalent),
            const SizedBox(height: 16),

            // Work
            _sectionTitle('Work Info'),
            _infoTile('Current Job', teacher.jobRole),
            _infoTile('Workplace', teacher.workplaceName),
            _infoTile(
              'Also in another mosque?',
              teacher.inAnotherMosque == true ? 'Yes' : 'No',
            ),
            _infoTile('Other Mosques', teacher.otherMosqueNames),
            _infoTile('Is Working', teacher.isWorking == true ? 'Yes' : 'No'),
            _infoTile('Is Mojaz', teacher.isMojaz == true ? 'Yes' : 'No'),
            const SizedBox(height: 16),

            // Address
            _sectionTitle('Address'),
            _infoTile('Area', teacher.addressArea),
            _infoTile('Street', teacher.addressStreet),
            _infoTile('Building', teacher.addressBuilding),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _infoTile(String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
