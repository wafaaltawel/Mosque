import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/auth_repository_interface.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryInterface repo;

  AuthBloc(this.repo) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await repo.login(phone: event.phone, password: event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure('فشل تسجيل الدخول'));
      }
    });
  }
}
