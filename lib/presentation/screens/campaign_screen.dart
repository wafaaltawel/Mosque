import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran/data/models/campaign.dart' as model;
import 'package:quran/presentation/blocs/campaign/campaign_event.dart';
import 'package:quran/presentation/widgets/campaign_widgets/campaign_card.dart';
import 'package:quran/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:quran/presentation/blocs/campaign/campaign_state.dart';
import 'package:quran/data/repositories/campaign_repository.dart';
import 'package:dio/dio.dart'; // Make sure to import Dio

class CampaignsScreen extends StatelessWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CampaignRepositoryImpl(
        RepositoryProvider.of<Dio>(context), // <-- Fix here: explicitly get Dio
      ),
      child: BlocProvider(
        create: (context) =>
            CampaignBloc(RepositoryProvider.of<CampaignRepository>(context))
              ..add(LoadCampaigns()),
        child: const CampaignsBody(),
      ),
    );
  }
}

class CampaignsBody extends StatelessWidget {
  const CampaignsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('اختر دورة'), centerTitle: true),
        body: BlocBuilder<CampaignBloc, CampaignState>(
          builder: (context, state) {
            if (state is CampaignLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CampaignLoaded) {
              final List<model.Campaign> campaigns = state.campaigns;

              if (campaigns.isEmpty) {
                return const Center(child: Text('لا توجد دورات متاحة'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: campaigns.length,
                itemBuilder: (context, index) {
                  return CampaignCard(campaign: campaigns[index]);
                },
              );
            } else if (state is CampaignError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
