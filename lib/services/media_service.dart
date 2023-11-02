import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pal48/Api/api.dart';
import 'package:pal48/models/media_model.dart';

class MediaService {
  Future fetchVideos(int page) async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getVideos(page)))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        List data = json.decode(response.body)['data'];
        var res = {
          "data": data.map((cat) => MediaModel.fromJson(cat)).toList(),
          "lastPage": json.decode(response.body)['meta']['last_page']
        };
        return res;
      } else {
        throw Exception(statusCode);
      }
    });
  }
}
