import 'package:flutter/material.dart';
import 'package:pal48/helpers/get_img.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:pal48/providers/notification_provider.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:pal48/providers/village_provider.dart';
import 'package:provider/provider.dart';

import '../providers/gaza_provider.dart';

firebaseRoute(
  String? screen,
  GlobalKey<NavigatorState> navigatorKey,
  String? pageId,
  String? title,
  context,
) {
  var notificationProvider =
      Provider.of<NotificationProvider>(context, listen: false);
  notificationProvider.decrement();
  if (screen == 'City') {
    final villageProvider =
        Provider.of<VillageProvider>(context, listen: false);
    if (villageProvider.villageModel[int.parse(pageId!)] == null) {
      villageProvider.villageModel[int.parse(pageId)] = [];
      villageProvider.fetchVillages(int.parse(pageId));
    }
    Navigator.pushNamed(context, '/village', arguments: {
      'id': int.parse(pageId),
      'city': title,
      'map': getImg(int.parse(pageId)),
    });
  }
  if (screen == 'Gaza') {
    final gazaProvide = Provider.of<GazaProvider>(context);
    if (gazaProvide.gazaModel.isEmpty) {
      gazaProvide.getchGaza();
    }
    Navigator.pushNamed(context, '/gaza');
  }
  if (screen == 'Article') {
    Navigator.pushNamed(context, '/article_notification', arguments: {
      'title': title,
      'id': int.parse(pageId!),
    });
  }
  if (screen == 'Questions') {
    Provider.of<QuestionProvider>(context, listen: false)
        .fetchQuestions(int.parse(pageId!));
    Navigator.pushNamed(context, '/questions', arguments: {
      'title': title,
      'id': int.parse(pageId),
    });
  }

  if (screen == 'Nakba') {
    Provider.of<NakbaProvider>(context, listen: false)
        .fetchNakbaSubCats(int.parse(pageId!));
    Navigator.pushNamed(context, '/nakba_details', arguments: {
      'title': title,
      'id': int.parse(pageId),
    });
  }

  if (screen == 'Aqsa') {
    Provider.of<AqsaProvider>(context, listen: false)
        .fetcAqsaSubCat(int.parse(pageId!));
    Navigator.pushNamed(context, '/aqsa_details', arguments: {
      'title': title,
      'id': int.parse(pageId),
    });
  }
  if (screen == 'General') {
    final notificationProvider = Provider.of<NotificationProvider>(
      context,
      listen: false,
    );
    if (notificationProvider.notifications.isEmpty) {
      notificationProvider.getNotifications();
    }
    Navigator.pushNamed(context, '/notifications');
  }
}
