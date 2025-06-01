import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/main_repositries.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository repo;

  MainBloc(this.repo) : super(MainInitial()) {
    on<LoadMainData>((event, emit) async {
      emit(MainLoading());
      try {
        final data = await repo.getMainData();
        emit(MainLoaded(data));
      } catch (e) {
        emit(MainError('فشل تحميل البيانات'));
      }
    });
  }
}
