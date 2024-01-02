import 'package:flutter/material.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/Helpers/open_link.dart';
import 'package:pal48/components/profile_menu_list_tile.dart';
import 'package:pal48/components/social_icon.dart';
import 'package:pal48/helpers/change_theme.dart';
import 'package:pal48/helpers/get_locale.dart';
import 'package:pal48/helpers/language.dart';
import 'package:pal48/main.dart';
import 'package:pal48/providers/bottom_nav_provider.dart';
import 'package:pal48/providers/contact_us_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/constants.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    final contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    return Drawer(
        child: Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountEmail: Text(
                    'العودة - حق يأبى النسيان',
                    style: kHeadingTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  accountName: Text(
                    'فلسطيننا',
                    style: kPragraphTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).textTheme.bodyLarge!.backgroundColor,
                  ),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: Image.asset(
                      "assets/img/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                ProfileMenuListTile(
                  text: translation(context).contactUs,
                  svgSrc: "assets/svg/Help.svg",
                  press: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
                ProfileMenuListTile(
                  text: translation(context).privacyScreen,
                  svgSrc: "assets/svg/Standard.svg",
                  press: () {
                    contactProvider.privaceData.isEmpty
                        ? contactProvider.getPrivacyData()
                        : null;
                    Navigator.pushNamed(context, '/privacy');
                  },
                ),
                ProfileMenuListTile(
                  text: translation(context).terms,
                  svgSrc: "assets/svg/info.svg",
                  press: () {
                    contactProvider.privaceData.isEmpty
                        ? contactProvider.getTermsData()
                        : null;
                    Navigator.pushNamed(context, '/terms');
                  },
                ),
                ProfileMenuListTile(
                  text: translation(context).shareApp,
                  svgSrc: "assets/svg/Send.svg",
                  press: () {
                    final Size size = MediaQuery.of(context).size;
                    Share.share(
                      '${Api.url}/app',
                      sharePositionOrigin:
                          Rect.fromLTWH(0, 0, size.width, size.height / 2),
                    );
                  },
                ),
                const Center(
                  child: SizedBox(
                    width: 80.0,
                    child: ChangeTheme(),
                  ),
                ),
                Row(
                  children: Language.languageList()
                      .where((e) => e.languageCode != lang)
                      .map((e) {
                    return TextButton(
                        onPressed: () async {
                          Provider.of<BottomBarProvider>(context, listen: false)
                              .changeLang(e.languageCode);
                          Locale locale = await setLocale(e.languageCode);
                          // ignore: use_build_context_synchronously
                          MyApp.setLocale(context, locale);
                        },
                        child: Text(e.name));
                  }).toList(),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              SocialIcon(url: 'facebook', icon: 'assets/svg/Facebook.svg'),
              SocialIcon(url: 'facebook', icon: 'assets/svg/Instagram.svg'),
              SocialIcon(url: 'facebook', icon: 'assets/svg/Twitter.svg'),
              SocialIcon(url: 'facebook', icon: 'assets/svg/tiktok.svg')
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          TextButton(
            onPressed: () {
              openLink('https://etharshrouf.com');
            },
            child: Text(
              translation(context).developedBy,
              style: kSubHeadTextStyle.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    ));
  }
}
