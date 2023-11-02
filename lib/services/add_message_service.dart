import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:pal48/Api/api.dart';

class SendMessageClass {
  Future sendMessage(
    String name,
    String email,
    String message,
    String deviceToken,
  ) async {
    await Api.getSegmentValue();
    final response = await http.post(
      Uri.parse(Api.sendMessage()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'message': message,
        'deviceToken': deviceToken,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future addComment(
    String name,
    String email,
    String message,
    String deviceToken,
    int id,
    String model,
  ) async {
    await Api.getSegmentValue();
    final response = await http.post(
      Uri.parse(Api.addComment()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'comment': message,
        'deviceToken': deviceToken,
        'id': id.toString(),
        'model': model,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
