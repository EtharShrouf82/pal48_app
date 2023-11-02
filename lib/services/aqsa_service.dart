import 'package:pal48/Api/api.dart';
import 'package:pal48/models/aqsa/aqsa_model.dart';
import 'package:pal48/models/aqsa/aqsa_sub_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class AqsaService {
  Future fetchAqsaMainCat() async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getAqsaMainCat()))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products = data.map((cat) => AqsaModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }

  Future fetchAqsaSubCats(int id) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getSubAqsaCat(id)))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products = data.map((cat) => AqsaSubModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }
}
