import '../../data/models/main_data_model.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final MainDataModel data;
  MainLoaded(this.data);
}

class MainError extends MainState {
  final String message;
  MainError(this.message);
}
