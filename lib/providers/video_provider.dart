import 'package:flutter/material.dart';
import 'package:pal48/models/media_model.dart';
import 'package:pal48/services/media_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MediaProvider extends ChangeNotifier {
  bool isDataLoaded = false;
  int mediaPage = 1;
  static int mediaLastPage = 1;
  final RefreshController refreshMediaController =
      RefreshController(initialRefresh: false);

  void onMediaRefresh() async {
    fetchVideos();
    refreshMediaController.refreshCompleted();
  }

  void onMediaLoading() async {
    mediaPage++;
    fetchVideos();
    refreshMediaController.loadComplete();
    notifyListeners();
  }

  List<MediaModel> mediaArray = [];

  Future fetchVideos() async {
    if (mediaPage <= mediaLastPage) {
      final mediaService = MediaService();
      final data = await mediaService.fetchVideos(mediaPage);
      mediaArray.addAll(data['data']);
      mediaLastPage = data['lastPage'];
      notifyListeners();
    }
  }
}
