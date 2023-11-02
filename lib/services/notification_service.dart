import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pal48/Api/Api.dart';
import 'package:pal48/models/notification_model.dart';

class NotificationService {
  Future getData() async {
    await Api.getSegmentValue();
    final response = await http.get(
      Uri.parse(Api.getNotifications()),
    );
    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      List data = json.decode(response.body)['data'];
      return data
          .map((product) => NotificationModel.fromJson(product))
          .toList();
    } else {
      throw Exception(statusCode);
    }
  }
}
