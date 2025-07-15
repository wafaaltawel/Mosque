import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/data/repositories/campaign_repository.dart';
import 'package:quran/presentation/blocs/campaign/campaign_event.dart';
import 'package:quran/presentation/blocs/campaign/campaign_state.dart';


class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository repository;

  CampaignBloc(this.repository) : super(CampaignLoading()) {
    on<LoadCampaigns>((event, emit) async {
      emit(CampaignLoading());
      try {
        final campaigns = await repository.fetchCampaigns();
        emit(CampaignLoaded(campaigns));
      } catch (e) {
        emit(CampaignError(e.toString()));
      }
    });
  }
}
