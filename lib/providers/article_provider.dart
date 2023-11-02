import 'package:flutter/material.dart';
import 'package:pal48/models/article_model.dart';
import 'package:pal48/models/comment_model.dart';
import 'package:pal48/models/event_model.dart';
import 'package:pal48/services/article_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleProvider extends ChangeNotifier {
  bool isDataLoaded = false;
  bool isComentLoaded = false;
  bool notificationLoaded = false;

  List<ArticleModel> sliderModel = [];

  Map<String, dynamic> notificationModel = {};

  List<EventModel> eventsModel = [];

  List<CommentModel> commentArray = [];

  Future fetchEvents(int month, int day) async {
    isDataLoaded = true;
    notifyListeners();
    final articleService = ArticleService();
    final event = await articleService.getEvents(month, day);
    eventsModel = event['data'];
    isDataLoaded = false;
    notifyListeners();
  }

  Future getComments(int id) async {
    isComentLoaded = true;
    final articleService = ArticleService();
    final story = await articleService.getComments(id);
    commentArray = story['data'];
    isComentLoaded = false;
    notifyListeners();
  }

  Future fetchStory() async {
    isDataLoaded = true;
    final articleService = ArticleService();
    final story = await articleService.fetchStory();
    sliderModel = story['data'];
    isDataLoaded = false;
    notifyListeners();
  }

  int articlePage = 1;
  static int marticleLastPage = 1;
  final RefreshController refreshArticleController =
      RefreshController(initialRefresh: false);
  void onArticleRefresh() async {
    fetchArticles();
    refreshArticleController.refreshCompleted();
  }

  void onArticleLoading() async {
    articlePage++;
    fetchArticles();
    refreshArticleController.loadComplete();
    notifyListeners();
  }

  List<ArticleModel> articleModel = [];
  Future fetchArticles() async {
    if (articlePage <= marticleLastPage) {
      final articleService = ArticleService();
      final data = await articleService.fetchArticles(articlePage);
      articleModel.addAll(data['data']);
      marticleLastPage = data['lastPage'];
      notifyListeners();
    }
  }
}
