import 'package:flutter/material.dart';
import 'package:pal48/Services/notification_service.dart';
import 'package:pal48/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  bool isLoading = true;
  List<NotificationModel> notifications = [];

  int notificationCount = 0;
  getNotifications() async {
    isLoading = true;
    notifications = [];
    notifyListeners();
    var notificationService = NotificationService();
    var data = await notificationService.getData();
    notifications = data;
    isLoading = false;
    notifyListeners();
  }

  Future<void> increment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? badgeCount = prefs.getInt('badge');
    notificationCount++;
    if (badgeCount == null) {
      await prefs.setInt('badge', 1);
    } else {
      await prefs.setInt('badge', badgeCount + 1);
    }
    notifyListeners();
  }

  Future<void> decrement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? badgeCount = prefs.getInt('badge');
    if (badgeCount! > 0) {
      notificationCount--;
      await prefs.setInt('badge', badgeCount - 1);
      notifyListeners();
    }
  }

  Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notificationCount = 0;
    await prefs.setInt('badge', 0);
    notifyListeners();
  }

  getNotificationCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? badgeCount = prefs.getInt('badge');
    notificationCount = badgeCount ?? 0;
  }
}
