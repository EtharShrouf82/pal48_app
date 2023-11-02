import 'package:flutter/material.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/Helpers/open_link.dart';
import 'package:pal48/components/profile_menu_list_tile.dart';
import 'package:pal48/components/social_icon.dart';
import 'package:pal48/helpers/change_theme.dart';
import 'package:pal48/providers/contact_us_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/constants.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({Key? key}) : super(key: key);

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
                  text: "إتصل بنا",
                  svgSrc: "assets/svg/Help.svg",
                  press: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
                ProfileMenuListTile(
                  text: "سياسة الخصوصية",
                  svgSrc: "assets/svg/Standard.svg",
                  press: () {
                    contactProvider.privaceData.isEmpty
                        ? contactProvider.getPrivacyData()
                        : null;
                    Navigator.pushNamed(context, '/privacy');
                  },
                ),
                ProfileMenuListTile(
                  text: "سياسة الإستخدام",
                  svgSrc: "assets/svg/info.svg",
                  press: () {
                    contactProvider.privaceData.isEmpty
                        ? contactProvider.getTermsData()
                        : null;
                    Navigator.pushNamed(context, '/terms');
                  },
                ),
                ProfileMenuListTile(
                  text: 'أرسل التطبيق لصديق',
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
              'برمجة وتطوير : إيثار شروف',
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
