import 'package:flutter/material.dart';
import 'package:pal48/helpers/get_img.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:pal48/providers/notification_provider.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:pal48/providers/village_provider.dart';
import 'package:provider/provider.dart';

firebaseRoute(
  String? screen,
  GlobalKey<NavigatorState> navigatorKey,
  int? pageId,
  String? title,
  context,
) {
  var notificationProvider =
      Provider.of<NotificationProvider>(context, listen: false);
  notificationProvider.decrement();
  if (screen == 'City') {
    final villageProvider =
        Provider.of<VillageProvider>(context, listen: false);
    if (villageProvider.villageModel[pageId] == null) {
      villageProvider.villageModel[pageId!] = [];
      villageProvider.fetchVillages(pageId);
    }
    Navigator.pushNamed(context, '/village', arguments: {
      'id': pageId,
      'city': title,
      'map': getImg(pageId),
    });
  }
  if (screen == 'Article') {
    Navigator.pushNamed(context, '/article_notification', arguments: {
      'title': title,
      'id': pageId,
    });
  }
  if (screen == 'Questions') {
    Provider.of<QuestionProvider>(context, listen: false)
        .fetchQuestions(pageId!);
    Navigator.pushNamed(context, '/questions', arguments: {
      'title': title,
      'id': pageId,
    });
  }

  if (screen == 'Nakba') {
    Provider.of<NakbaProvider>(context, listen: false)
        .fetchNakbaSubCats(pageId!);
    Navigator.pushNamed(context, '/nakba_details', arguments: {
      'title': title,
      'id': pageId,
    });
  }

  if (screen == 'Aqsa') {
    Provider.of<AqsaProvider>(context, listen: false).fetcAqsaSubCat(pageId!);
    Navigator.pushNamed(context, '/aqsa_details', arguments: {
      'title': title,
      'id': pageId,
    });
  }
}
