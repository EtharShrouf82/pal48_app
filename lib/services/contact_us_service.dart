import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../Api/Api.dart';

class ContactService {
  Future fetchContactUsInfo() async {
    await Api.getSegmentValue();
    return await http
        .get(Uri.parse(Api.getContactData()))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        var data = json.decode(response.body)['data'];
        return data;
      } else {
        throw Exception(statusCode);
      }
    });
  }

  Future sendMessage(
    String name,
    String phoneNumber,
    String message,
  ) async {
    await Api.getSegmentValue();
    final response = await http.post(
      Uri.parse(Api.sendMessage()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phoneNumber': phoneNumber,
        'message': message,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<String> getTerms() async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getTerms()))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        String data = json.decode(response.body)['data']['terms'];
        return data;
      } else {
        throw Exception(statusCode);
      }
    });
  }

  Future<String> getPrivacy() async {
    await Api.getSegmentValue();
    return http
        .get(Uri.parse(Api.getPrivacy()))
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        String data = json.decode(response.body)['data']['privacy'];
        return data;
      } else {
        throw Exception(statusCode);
      }
    });
  }
}
