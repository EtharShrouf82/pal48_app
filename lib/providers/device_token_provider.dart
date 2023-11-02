import 'package:flutter/material.dart';
import 'dart:async';

class DeviceTokensProvider extends ChangeNotifier {
  String deviceToken = '';
  bool showDeviceToken = false;

  Future<void> setDeviceId(String deviceId) async {
    deviceToken = deviceId;
  }

  Future<void> showDeviceTokenFunc() async {
    showDeviceToken = true;
    notifyListeners();
  }
}
