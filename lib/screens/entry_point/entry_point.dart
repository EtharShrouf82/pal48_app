import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/components/drawer_items.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/get_locale.dart';
import 'package:pal48/pages/about/about_page.dart';
import 'package:pal48/providers/article_provider.dart';
import 'package:pal48/providers/bottom_nav_provider.dart';
import 'package:pal48/providers/notification_provider.dart';
import 'package:pal48/screens/home_screen/home_screen.dart';
import 'package:pal48/screens/map_screen/map_screen.dart';
import 'package:pal48/ui/bottom_nav_with_number.dart';
import 'package:provider/provider.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomBarProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final articleProvider = Provider.of<ArticleProvider>(context);
    List pages = [
      const HomeScreen(),
      const MapScreen(),
      const AboutScreen(),
    ];

    @override
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.9 : 1),
            BlendMode.srcIn),
      );
    }

    void onItemTapped(int index) async {
      bottomNavProvider.onItemTapped(index);

      if (index == 1) {
        if (articleProvider.sliderModel.isEmpty) {
          await articleProvider.fetchStory();
        }
      }
      if (index == 2) {}
      if (index == 3) {}
    }

    return Scaffold(
      appBar: AppBar(
        // pinned: true,
        // floating: true,
        // snap: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // leading: const SizedBox(),
        // leadingWidth: 0,
        centerTitle: false,
        title: Text(
          translation(context).palestine,
          style: kHeadingTextStyle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(children: <Widget>[
              SvgPicture.asset(
                "assets/svg/Notification.svg",
                colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.bodyLarge!.color!,
                    BlendMode.srcIn),
              ),
              notificationProvider.notificationCount > 0
                  ? BottomNavWithNumber(
                      count: notificationProvider.notificationCount.toString(),
                    )
                  : const SizedBox()
            ]),
            onPressed: () {
              if (notificationProvider.notifications.isEmpty) {
                notificationProvider.getNotifications();
                notificationProvider.reset();
              }
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      drawer: const DrawerItems(),
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: pages[bottomNavProvider.currentPage],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: bottomNavProvider.currentPage,
          onTap: (index) {
            onItemTapped(index);
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(color: primaryColor),
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/svg/home.svg"),
              activeIcon: svgIcon("assets/svg/home.svg", color: primaryColor),
              label: translation(context).home,
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/svg/Mylocation.svg"),
              activeIcon:
                  svgIcon("assets/svg/Mylocation.svg", color: primaryColor),
              label: translation(context).palestineMap,
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/svg/FAQ.svg"),
              activeIcon: svgIcon("assets/svg/FAQ.svg", color: primaryColor),
              label: translation(context).about,
            ),
          ],
        ),
      ),
    );
  }
}
