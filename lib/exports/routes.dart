import 'package:pal48/exports/exports.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const EntryPoint(),
  '/camps': (context) => const CampPage(),
  '/details': (context) => const ArticleDetails(),
  '/nakba': (context) => const NakbaPage(),
  '/nakba_details': (context) => const NakbaDetails(),
  '/aqsa': (context) => const AqsaPage(),
  '/aqsa_details': (context) => const AqsaDetails(),
  '/aqsa_more_details': (context) => const AqsaMoreDetails(),
  '/questionsCat': (context) => const QuestionCatPage(),
  '/questions': (context) => const QuestionsPage(),
  '/city': (context) => const CityScreen(),
  '/village': (context) => const VillageScreen(),
  '/notifications': (context) => const NotificationsScreen(),
  '/place': (context) => const PlacePage(),
  '/massacre': (context) => const MassacrePage(),
  '/articles': (context) => const ArticlePage(),
  '/media': (context) => const MediaPage(),
  '/contact': (context) => const ContactScreen(),
  '/privacy': (context) => const PrivacyPage(),
  '/terms': (context) => const TermsPage(),
  '/calender': (context) => const EventCalendar(),
  '/article_notification': (context) => const ArticleNotification(),
  '/gaza': (context) => const GazaGincode(),
};
