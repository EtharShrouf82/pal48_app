import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int currentPage = 0;
  Color color = Colors.red;

  Future<void> onItemTapped(index) async {
    currentPage = index;
    notifyListeners();
  }

  String lang = "";
  Future<void> changeLang(locale) async {
    lang = locale;
    notifyListeners();
  }
}
