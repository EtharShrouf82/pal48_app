import 'package:flutter/material.dart';
import 'package:pal48/models/masscare_model.dart';
import 'package:pal48/services/article_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MasscareProvider extends ChangeNotifier {
  int masscaePage = 1;
  static int masscareLastPage = 1;
  List? masscareMyActivities;
  final RefreshController refreshMassacreController =
      RefreshController(initialRefresh: false);
  void onMassacreRefresh() async {
    fetchMasscare();
    refreshMassacreController.refreshCompleted();
  }

  void onMassacreLoading() async {
    masscaePage++;
    fetchMasscare();
    refreshMassacreController.loadComplete();
    notifyListeners();
  }

  List<MasscareModel> masscareModel = [];
  Future fetchMasscare() async {
    if (masscaePage <= masscareLastPage) {
      final articleService = ArticleService();
      final data = await articleService.fetchMascares(masscaePage);
      masscareModel.addAll(data['data']);
      masscareLastPage = data['lastPage'];
      notifyListeners();
    }
  }
}
