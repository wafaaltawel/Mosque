import 'package:dio/dio.dart';
import 'package:quran/core/constants/baseUrl.dart';
import 'package:quran/data/models/campaign.dart';

abstract class CampaignRepository {
  Future<List<Campaign>> fetchCampaigns();
}

class CampaignRepositoryImpl implements CampaignRepository {
  final Dio dio;

  CampaignRepositoryImpl(this.dio);

  @override
  Future<List<Campaign>> fetchCampaigns() async {
    final response = await dio.get('${AppConstants.baseUrl}/campaigns');

    // Extract the list under "data"
    final List<dynamic> dataList = response.data['data'] as List<dynamic>;

    return dataList.map((json) => Campaign.fromJson(json)).toList();
  }
}
