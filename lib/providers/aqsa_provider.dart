import 'package:flutter/material.dart';
import 'package:pal48/models/aqsa/aqsa_model.dart';
import 'package:pal48/models/aqsa/aqsa_sub_model.dart';
import 'package:pal48/services/aqsa_service.dart';

class AqsaProvider extends ChangeNotifier {
  bool isDataLoaded = false;

  List<AqsaModel> aqsaModel = [];
  Map<int, List<AqsaSubModel>> subAqsaCat = {};

  Future fetcAqsaMainCat() async {
    isDataLoaded = false;
    aqsaModel = [];
    final aqsaService = AqsaService();
    final aqsaMain = await aqsaService.fetchAqsaMainCat();
    aqsaModel = aqsaMain['data'];
    isDataLoaded = true;
    notifyListeners();
  }

  Future fetcAqsaSubCat(int id) async {
    isDataLoaded = false;
    subAqsaCat[id] = [];
    final aqsaService = AqsaService();
    final aqsaMain = await aqsaService.fetchAqsaSubCats(id);
    subAqsaCat[id] = aqsaMain['data'];
    isDataLoaded = true;
    notifyListeners();
  }
}
