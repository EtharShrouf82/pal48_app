import 'package:pal48/exports/exports.dart';
import 'package:pal48/exports/providers.dart';
import 'package:pal48/exports/routes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationInfo.message = message;
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void onSelectNotification(NotificationResponse val) async {
  if (NotificationInfo.message != null) {
    final screen = NotificationInfo.message!.data['screen'];
    final pageId = NotificationInfo.message!.data['page_id'];
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
      providers: Providers.getproviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Locale? _locale;

  setLocale(Locale locale) {
    if (_locale != locale) {
      setState(() {
        Provider.of<BottomBarProvider>(context, listen: false).lang =
            locale.languageCode;
        _locale = locale;
      });
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

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
    // FirebaseMessaging.instance.subscribeToTopic('pal48ps');
    FirebaseMessaging.instance.subscribeToTopic('pal48psps');
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        initialRoute: '/',
        routes: customRoutes,
      );
    });
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
