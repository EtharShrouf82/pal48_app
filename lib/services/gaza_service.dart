import 'package:http/http.dart' as http;
import 'package:pal48/Api/Api.dart';
import 'dart:convert';
import 'dart:async';

import 'package:pal48/models/gaza_model.dart';
import 'package:pal48/models/tag_model.dart';

class GazaService {
  Future<dynamic> fetchGaza(int page, id) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getGaza(page, id)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => GazaModel.fromJson(cat)).toList(),
          "lastPage": json.decode(response.body)['meta']['last_page']
        };
        return res;
      } else {
        throw Exception(statusCode);
      }
    });

    // } else {
    //   List data = json.decode(products)['data'];
    //   return data.map((product) => ProductModel.fromJson(product)).toList();
    // }
  }

  Future<dynamic> getTags() async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getTags()))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => TagModel.fromJson(cat)).toList(),
        };
        return res;
      } else {
        throw Exception(statusCode);
      }
    });

    // } else {
    //   List data = json.decode(products)['data'];
    //   return data.map((product) => ProductModel.fromJson(product)).toList();
    // }
  }
}
