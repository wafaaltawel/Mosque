import 'package:quran/data/models/listening_model.dart';

import '../../core/network/api_service.dart';

class ListeningRepository {
  final ApiService api;

  ListeningRepository(this.api);

  Future<List<ListeningModel>> getListeningData() {
    return api.fetchListeningData();
  }
}


