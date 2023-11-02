import 'package:pal48/Api/api.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pal48/models/questions/question_cat_model.dart';
import 'package:pal48/models/questions/questions_model.dart';

class QuestionService {
  Future fetchQuestionsCat() async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getQuestionsCat()))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products =
            data.map((cat) => QuestionCatModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }

  Future fetchQuestions(int id) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getQuestions(id)))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var products = data.map((cat) => QuestionModel.fromJson(cat)).toList();
        return {
          'data': products,
        };
      } else {
        throw Exception(statusCode);
      }
    });
  }
}
