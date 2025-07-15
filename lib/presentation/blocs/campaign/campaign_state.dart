
import 'package:quran/data/models/campaign.dart';


abstract class CampaignState {}
class CampaignLoading extends CampaignState {}
class CampaignLoaded extends CampaignState {
  final List<Campaign> campaigns;
  CampaignLoaded(this.campaigns);
}
class CampaignError extends CampaignState {
  final String message;
  CampaignError(this.message);
}
