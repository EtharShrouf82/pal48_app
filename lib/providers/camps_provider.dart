import 'package:flutter/material.dart';
import 'package:pal48/models/camp_model.dart';
import 'package:pal48/services/article_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CampsProvider extends ChangeNotifier {
  int page = 1;
  static int lastPage = 1;
  List? myActivities;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<CampModel> campModel = [];
  Future fetchCamps({withClear = false, country = const []}) async {
    if (withClear) {
      campModel = [];
    }
    if (page <= lastPage) {
      final articleService = ArticleService();
      final data = await articleService.fetchCamps(page, country);
      campModel.addAll(data['data']);
      lastPage = data['lastPage'];
      notifyListeners();
    }
  }

  void onRefresh() async {
    fetchCamps();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    page++;
    fetchCamps();
    refreshController.loadComplete();
    notifyListeners();
  }
}
