import 'package:flutter/material.dart';
import 'package:pal48/models/gaza_model.dart';
import 'package:pal48/models/tag_model.dart';
import 'package:pal48/services/gaza_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GazaProvider extends ChangeNotifier {
  int page = 1;
  late int currentTag = 0;
  static int lastPage = 1;
  bool loadingIfno = false;

  String info = '';

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<GazaModel> gazaModel = [];
  List<TagModel> tagModel = [];

  filter(int id) {
    currentTag = id;
    page = 1;
    lastPage = 1;
    notifyListeners();
    getchGaza(withClear: true);
  }

  getAll() {
    currentTag = 0;
    page = 1;
    lastPage = 1;
    notifyListeners();
    getchGaza(withClear: true);
  }

  Future getTags() async {
    final gazaService = GazaService();
    final data = await gazaService.getTags();
    tagModel.addAll(data['data']);
    notifyListeners();
  }

  Future getchGaza({withClear = false}) async {
    if (tagModel.isEmpty) {
      getTags();
    }
    if (withClear == true) {
      gazaModel = [];
    }
    if (page <= lastPage) {
      final gazaService = GazaService();
      final data = await gazaService.fetchGaza(page, currentTag);
      gazaModel.addAll(data['data']);
      lastPage = data['lastPage'];
      notifyListeners();
    }
  }

  void onRefresh() async {
    getchGaza();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    page++;
    getchGaza();
    refreshController.loadComplete();
    notifyListeners();
  }
}
