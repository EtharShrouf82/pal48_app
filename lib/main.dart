import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pal48/helpers/firebase_route.dart';
import 'package:pal48/helpers/notification_info.dart';
import 'package:pal48/pages/aqsa/aqsa_details.dart';
import 'package:pal48/pages/aqsa/aqsa_more_details.dart';
import 'package:pal48/pages/aqsa/aqsa_page.dart';
import 'package:pal48/pages/article/article_notification.dart';
import 'package:pal48/pages/article/article_page.dart';
import 'package:pal48/pages/camp/camp_page.dart';
import 'package:pal48/pages/article/article_details.dart';
import 'package:pal48/pages/contact/contact_page.dart';
import 'package:pal48/pages/events/event_calender.dart';
import 'package:pal48/pages/massacre/massacre_page.dart';
import 'package:pal48/pages/media/media_page.dart';
import 'package:pal48/pages/place/place_page.dart';
import 'package:pal48/pages/privacy/privacy_page.dart';
import 'package:pal48/pages/terms/terms_screen.dart';
import 'package:pal48/pages/village/city_home_screen.dart';
import 'package:pal48/pages/nakba/nakba_details.dart';
import 'package:pal48/pages/nakba/nakba_page.dart';
import 'package:pal48/pages/questions/questions_cat_page.dart';
import 'package:pal48/pages/questions/questions_page.dart';
import 'package:pal48/pages/village/village_screen.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/article_provider.dart';
import 'package:pal48/providers/bottom_nav_provider.dart';
import 'package:pal48/providers/camps_provider.dart';
import 'package:pal48/providers/contact_us_provider.dart';
import 'package:pal48/providers/favorite_provider.dart';
import 'package:pal48/providers/masscare_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:pal48/providers/notification_provider.dart';
import 'package:pal48/providers/place_provider.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:pal48/providers/theme_provider.dart';
import 'package:pal48/providers/video_provider.dart';
import 'package:pal48/providers/village_provider.dart';
import 'package:pal48/screens/entry_point/entry_point.dart';
import 'package:pal48/screens/notification_screen.dart/notification_screen.dart';
import 'package:pal48/themes/dark_theme.dart';
import 'package:pal48/themes/light_theme.dart';
import 'package:provider/provider.dart';

import 'providers/add_comment_provider.dart';
import 'providers/device_token_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationInfo.message = message;
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void onSelectNotification(NotificationResponse val) async {
  if (NotificationInfo.message != null) {
    final screen = NotificationInfo.message!.data['screen'];
    final pageId = int.parse(NotificationInfo.message!.data['page_id']);
    final title = NotificationInfo.message!.data['title'];
    firebaseRoute(
      screen,
      NavigationService.navigatorKey,
      pageId,
      title,
      NavigationService.navigatorKey.currentContext,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title // description, // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeProvider>(
            create: (BuildContext context) {
          return AppThemeProvider();
        }),
        ChangeNotifierProvider<BottomBarProvider>(
            create: (BuildContext context) {
          return BottomBarProvider();
        }),
        ChangeNotifierProvider<DeviceTokensProvider>(
            create: (BuildContext context) {
          return DeviceTokensProvider();
        }),
        ChangeNotifierProvider<ContactProvider>(create: (BuildContext context) {
          return ContactProvider();
        }),
        ChangeNotifierProvider<NotificationProvider>(
            create: (BuildContext context) {
          return NotificationProvider();
        }),
        ChangeNotifierProvider<ArticleProvider>(create: (BuildContext context) {
          return ArticleProvider();
        }),
        ChangeNotifierProvider<FavoriteProvider>(
            create: (BuildContext context) {
          return FavoriteProvider();
        }),
        ChangeNotifierProvider<NakbaProvider>(create: (BuildContext context) {
          return NakbaProvider();
        }),
        ChangeNotifierProvider<AqsaProvider>(create: (BuildContext context) {
          return AqsaProvider();
        }),
        ChangeNotifierProvider<QuestionProvider>(
            create: (BuildContext context) {
          return QuestionProvider();
        }),
        ChangeNotifierProvider<VillageProvider>(create: (BuildContext context) {
          return VillageProvider();
        }),
        ChangeNotifierProvider<PlaceProvider>(create: (BuildContext context) {
          return PlaceProvider();
        }),
        ChangeNotifierProvider<MasscareProvider>(
            create: (BuildContext context) {
          return MasscareProvider();
        }),
        ChangeNotifierProvider<CampsProvider>(create: (BuildContext context) {
          return CampsProvider();
        }),
        ChangeNotifierProvider<MediaProvider>(create: (BuildContext context) {
          return MediaProvider();
        }),
        ChangeNotifierProvider<AddCommentProvider>(
            create: (BuildContext context) {
          return AddCommentProvider();
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    //request premissoon
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationInfo.message = message;
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                icon: 'launch_background',
              ),
            ));
      }
    });
    //local notification when app is opened

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = const DarwinInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin!.initialize(initSetttings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        onDidReceiveNotificationResponse: onSelectNotification);

    // subscribe to topic
    FirebaseMessaging.instance.subscribeToTopic('pal48ps');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//when app is killed
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      NotificationInfo.message = message;
      if (message != null) {
        NotificationInfo.message = message;
        final screen = message.data['screen'];
        final pageId = message.data['page_id'];
        final title = message.data['title'];
        firebaseRoute(
          screen,
          NavigationService.navigatorKey,
          pageId,
          title,
          NavigationService.navigatorKey.currentContext,
        );
      }
    });
    //wehn app is opened//if but route will resirect automatically
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // final route = message.data['screen'];
      // final pageId = int.parse(message.data['page_id']);
      // final title = message.data['title'];
      // print("title si " + title);
      // print("page" + pageId.toString());
      // print("route is " + route);
      // firebaseRoute(route, _navigatorKey, pageId, title);

      NotificationInfo.message = message;
      Provider.of<NotificationProvider>(context, listen: false).increment();
    });

    //when app in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      NotificationInfo.message = message;
      final screen = message.data['screen'];
      final pageId = message.data['page_id'];
      final title = message.data['title'];
      firebaseRoute(
        screen,
        NavigationService.navigatorKey,
        pageId,
        title,
        NavigationService.navigatorKey.currentContext,
      );
    });

    _firebaseMessaging.getToken().then((token) {
      Provider.of<DeviceTokensProvider>(context, listen: false)
          .setDeviceId(token.toString());
    });
    getNotificationCount();
    getSliderArticles();
    super.initState();
  }

  getNotificationCount() {
    Provider.of<NotificationProvider>(context, listen: false)
        .getNotificationCount();
  }

  Future getSliderArticles() async {
    final articleProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    if (articleProvider.sliderModel.isEmpty) {
      await articleProvider.fetchStory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (_, settings, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        title: 'pal48.ps',
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        // themeMode: ThemeMode.dark,
        themeMode: settings.themeMode,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar', 'SA')],
        locale: const Locale('ar', 'SA'),
        initialRoute: '/',
        routes: {
          // '/': (context) => const HomePage(),
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
        },
      );
    });
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
