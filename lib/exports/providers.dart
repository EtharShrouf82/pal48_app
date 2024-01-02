import 'package:pal48/exports/exports.dart';

class Providers {
  static get getproviders => [
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
        ChangeNotifierProvider<GazaProvider>(create: (BuildContext context) {
          return GazaProvider();
        }),
      ];
}
