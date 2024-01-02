import 'package:http/http.dart' as http;
import 'package:pal48/Api/Api.dart';
import 'package:pal48/models/article_model.dart';
import 'package:pal48/models/camp_model.dart';
import 'package:pal48/models/comment_model.dart';
import 'package:pal48/models/event_model.dart';
import 'package:pal48/models/masscare_model.dart';
import 'package:pal48/models/place_model.dart';
import 'dart:convert';
import 'dart:async';

import 'package:pal48/models/village_model.dart';

class ArticleService {
  Future fetchStory() async {
    await Api.getSegmentValue();
    print(Api.getStory());
    return http.get(Uri.parse(Api.getStory())).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products = data.map((cat) => ArticleModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }

  Future<dynamic> fetchCamps(int page, List country) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getCamps(page, country)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => CampModel.fromJson(cat)).toList(),
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

  Future<dynamic> fetchVillageService(int cityId, int page) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getVillages(cityId, page)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => VillageModel.fromJson(cat)).toList(),
          "lastPage": json.decode(response.body)['meta']['last_page'],
          "total": json.decode(response.body)['meta']['total']
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

  Future<dynamic> fetchPlace(int page, List country) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.fetchPlace(page, country)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => PlaceModel.fromJson(cat)).toList(),
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

  Future<dynamic> fetchMascares(int page) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.fetchMassacre(page)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => MasscareModel.fromJson(cat)).toList(),
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

  Future<dynamic> fetchArticles(int page) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.fetchArticles(page)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => ArticleModel.fromJson(cat)).toList(),
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

  Future<ArticleModel> fetchArticleById(int id) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.fetchArticleById(id)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ArticleModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception(statusCode);
      }
    });

    // } else {
    //   List data = json.decode(products)['data'];
    //   return data.map((product) => ProductModel.fromJson(product)).toList();
    // }
  }

  Future<dynamic> getEvents(int month, int day) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.fetchEvents(month, day)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products = data.map((cat) => EventModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });

    // } else {
    //   List data = json.decode(products)['data'];
    //   return data.map((product) => ProductModel.fromJson(product)).toList();
    // }
  }

  Future<dynamic> getComments(int id) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.fetchComments(id)))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products = data.map((cat) => CommentModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });

    // } else {
    //   List data = json.decode(products)['data'];
    //   return data.map((product) => ProductModel.fromJson(product)).toList();
    // }
  }

  Future<List<ArticleModel>> searchSuggestion(String query, int follow) async {
    await Api.getSegmentValue();
    final response = await http.post(
      Uri.parse(Api.searchArticles(query, follow)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': query,
      }),
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      return data.map((product) => ArticleModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
