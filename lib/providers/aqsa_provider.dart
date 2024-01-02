import 'package:flutter/material.dart';
import 'package:pal48/models/aqsa/aqsa_model.dart';
import 'package:pal48/models/aqsa/aqsa_sub_model.dart';
import 'package:pal48/services/aqsa_service.dart';

class AqsaProvider extends ChangeNotifier {
  bool dataLoaded = false;

  List<AqsaModel> aqsaModel = [];
  Map<int, List<AqsaSubModel>> subAqsaCat = {};

  Future fetcAqsaMainCat() async {
    dataLoaded = false;
    notifyListeners();
    aqsaModel = [];
    final aqsaService = AqsaService();
    final aqsaMain = await aqsaService.fetchAqsaMainCat();
    aqsaModel = aqsaMain['data'];
    dataLoaded = true;
    notifyListeners();
  }

  Future fetcAqsaSubCat(int id) async {
    dataLoaded = false;
    subAqsaCat[id] = [];
    final aqsaService = AqsaService();
    final aqsaMain = await aqsaService.fetchAqsaSubCats(id);
    subAqsaCat[id] = aqsaMain['data'];
    dataLoaded = true;
    notifyListeners();
  }
}
