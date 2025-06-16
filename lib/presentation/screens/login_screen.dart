import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/presentation/blocs/auth/auth_bloc.dart';
import 'package:quran/presentation/blocs/auth/auth_event.dart';
import 'package:quran/presentation/blocs/auth/auth_state.dart';
import 'package:quran/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:quran/presentation/blocs/teacher/teacher_event.dart';
import 'package:quran/presentation/blocs/teacher/teacher_state.dart';
import 'package:quran/presentation/widgets/login_widgets/custom_text_field.dart';
import 'package:quran/presentation/widgets/login_widgets/login_button.dart';
import 'package:quran/presentation/widgets/login_widgets/logo_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b836b),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    // بعد نجاح تسجيل الدخول، حمّل بيانات الأستاذ
                    context.read<TeacherBloc>().add(LoadTeacherProfile());
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
              BlocListener<TeacherBloc, TeacherState>(
                listener: (context, state) async {
                  if (state is TeacherLoaded) {
                    final teacherId = state.teacher.id;
                    print('تم تحميل بيانات الأستاذ، ID: $teacherId');

                    // ✅ التخزين الدائم باستخدام SharedPreferences
                    await SessionManager.setTeacherId(teacherId);

                    // ثم الانتقال
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is TeacherError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
            ],
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoHeader(),
                    const SizedBox(height: 50),
                    CustomTextField(
                      controller: _phoneController,
                      label: 'رقم الموبايل',
                      hint: 'رقم الموبايل',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'كلمة المرور',
                      hint: '*********',
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    LoginButton(
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        final phone = _phoneController.text.trim();
                        final password = _passwordController.text.trim();
                        context.read<AuthBloc>().add(
                          LoginRequested(phone, password),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SessionManager {
  static const String _teacherIdKey = 'teacher_id';

  // حفظ ID
  static Future<void> setTeacherId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_teacherIdKey, id);
  }

  // جلب ID
  static Future<int?> getTeacherId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_teacherIdKey);
  }

  // حذف ID (اختياري لتسجيل الخروج)
  static Future<void> clearTeacherId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_teacherIdKey);
  }
}
