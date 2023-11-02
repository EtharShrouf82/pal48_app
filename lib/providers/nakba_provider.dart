import 'package:flutter/material.dart';
import 'package:pal48/models/main_nakba_cat_model.dart';
import 'package:pal48/models/sub_nakba_model.dart';
import 'package:pal48/services/nakba_service.dart';

class NakbaProvider extends ChangeNotifier {
  bool isDataLoaded = false;
  bool isFavorite = false;

  List<MainNakbaCatModel> mainNakbaCatModel = [];
  Map<int, List<SubNakbaCatModel>> subNakbaCatModel = {};

  Future fetcNakbaMainCat() async {
    isDataLoaded = false;
    mainNakbaCatModel = [];
    final nakbaService = NakbaService();
    final story = await nakbaService.fetchNakbaMainCats();
    mainNakbaCatModel = story['data'];
    isDataLoaded = true;
    notifyListeners();
  }

  Future fetchNakbaSubCats(int id) async {
    isDataLoaded = false;
    subNakbaCatModel[id] = [];
    final nakbaService = NakbaService();
    final nkb = await nakbaService.fetchNakbaSubCats(id);
    subNakbaCatModel[id] = nkb['data'];
    isDataLoaded = true;
    notifyListeners();
  }
}
