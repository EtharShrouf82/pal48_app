import 'package:pal48/Api/api.dart';
import 'package:pal48/models/main_nakba_cat_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pal48/models/sub_nakba_model.dart';

class NakbaService {
  Future fetchNakbaMainCats() async {
    await Api.getSegmentValue();
    print(Api.getMainNakbaCat());
    return http
        .get(Uri.parse(Api.getMainNakbaCat()))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products =
            data.map((cat) => MainNakbaCatModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }

  Future fetchNakbaSubCats(int id) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getSubNakbaCat(id)))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products =
            data.map((cat) => SubNakbaCatModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }
}
