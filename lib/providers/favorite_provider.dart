import 'package:flutter/material.dart';
import 'package:pal48/database/database_helper.dart';
import 'package:pal48/models/favorite_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List favoriteArray = [];
  List<FavoriteModel> favoriteModel = [];

  Future<void> addToFavorite(
    int id,
    String title,
    String img,
    String description,
    String type,
    String date,
    String city,
    String result,
    String indDate,
  ) async {
    var db = DatabaseHelper();
    await db.saveFavorite(
      id,
      title,
      description,
      type,
      img,
      date,
      city,
      result,
      indDate,
    );
    favoriteArray.add(id);
    notifyListeners();
  }

  Future<void> removeFromFavorite(int id) async {
    var db = DatabaseHelper();
    await db.deleteFavorite(id);
    // favoriteArray.remove(id);
    // favoriteModel.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
