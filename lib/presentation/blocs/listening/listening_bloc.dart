import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/models/listening_model.dart';
import 'package:quran/data/repositories/listening_repository.dart';
import 'listening_event.dart';
import 'listening_state.dart';

class ListeningBloc extends Bloc<ListeningEvent, ListeningState> {
  final ListeningRepository repository;

  ListeningBloc(this.repository) : super(ListeningInitial()) {
    on<LoadListening>((event, emit) async {
      emit(ListeningLoading());
      try {
        // final data = await repository.getListeningData();
        // تجريب
         final data = await repository.fetchSessions();
        //  
        emit(ListeningLoaded(data as List<ListeningModel>));
      } catch (e) {
        emit(ListeningError("فشل تحميل جلسات التسميع"));
      }
    });
  }
}
