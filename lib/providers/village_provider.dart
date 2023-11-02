import 'package:flutter/material.dart';
import 'package:pal48/models/village_model.dart';
import 'package:pal48/services/article_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VillageProvider extends ChangeNotifier {
  int villagePage = 1;
  int total = 0;
  static int villagelastPage = 1;
  final RefreshController villageRefreshController =
      RefreshController(initialRefresh: false);
  void onVillageRefresh(int id) async {
    fetchVillages(id);
    villageRefreshController.refreshCompleted();
  }

  void onVillageLoading(int id) async {
    villagePage++;
    fetchVillages(id);
    villageRefreshController.loadComplete();
    notifyListeners();
  }

  Map<int, List<VillageModel>> villageModel = {};

  Future fetchVillages(int id) async {
    if (villagePage <= villagelastPage) {
      final articleService = ArticleService();
      final data = await articleService.fetchVillageService(id, villagePage);
      villageModel[id]?.addAll(data['data']);
      villagelastPage = data['lastPage'];
      total = data['total'];
      notifyListeners();
    }
  }
}
