import 'package:flutter/material.dart';
import 'package:pal48/models/place_model.dart';
import 'package:pal48/services/article_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlaceProvider extends ChangeNotifier {
  int placePage = 1;
  static int placeLastPage = 1;
  List? placeMyActivities;
  final RefreshController refreshPlaceController =
      RefreshController(initialRefresh: false);
  void onPlaceRefresh() async {
    fetchPlaces();
    refreshPlaceController.refreshCompleted();
  }

  void onPlaceLoading() async {
    placePage++;
    fetchPlaces();
    refreshPlaceController.loadComplete();
    notifyListeners();
  }

  List<PlaceModel> placeModel = [];
  Future fetchPlaces({withClear = false, country = const []}) async {
    if (withClear) {
      placeModel = [];
    }
    if (placePage <= placeLastPage) {
      final articleService = ArticleService();
      final data = await articleService.fetchPlace(placePage, country);
      placeModel.addAll(data['data']);
      placeLastPage = data['lastPage'];
      notifyListeners();
    }
  }
}
