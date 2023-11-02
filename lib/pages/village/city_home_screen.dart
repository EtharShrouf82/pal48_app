import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/city_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/page_message.dart';
import 'package:pal48/constants/constants.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map> city = [
      {
        'id': 1,
        'img': 'safad.png',
        'title': 'صفد',
        'color': const Color(0XFFaa8126),
        'map': 'safad_map.png',
      },
      {
        'id': 3,
        'img': 'akka.png',
        'title': 'عكا',
        'color': const Color(0XFF50664B),
        'map': 'akka_map.png',
      },
      {
        'id': 5,
        'img': 'tabaria.png',
        'title': 'طبريا',
        'color': const Color(0XFF2C6A4F),
        'map': 'tabaria_map.png',
      },
      {
        'id': 2,
        'img': 'nzareth.png',
        'title': 'الناصرة',
        'color': const Color(0XFF8E8325),
        'map': 'nzareth_map.png',
      },
      {
        'id': 6,
        'img': 'haifa.png',
        'title': 'حيفا',
        'color': const Color(0XFF849A80),
        'map': 'haifa_map.png',
      },
      {
        'id': 7,
        'img': 'besan.png',
        'title': 'بيسان',
        'color': const Color(0XFF7C9544),
        'map': 'bessan_map.png',
      },
      {
        'id': 8,
        'img': 'jenin.png',
        'title': 'جنين',
        'color': const Color(0XFF8E8325),
        'map': 'jenin_map.png',
      },
      {
        'id': 9,
        'img': 'tulkarem.png',
        'title': 'طولكرم',
        'color': const Color(0XFF0F4A72),
        'map': 'tulkarem_map.png',
      },
      {
        'id': 10,
        'img': 'yafa.png',
        'title': 'يافا',
        'color': const Color(0XFF8E431D),
        'map': 'yaffa_map.png',
      },
      {
        'id': 4,
        'img': 'ramleh.png',
        'title': 'الرملة',
        'color': const Color(0XFF75B5A5),
        'map': 'ramleh_map.png',
      },
      {
        'id': 11,
        'img': 'jerusalem.png',
        'title': 'القدس',
        'color': const Color(0XFFA2BF80),
        'map': 'jerusalem_map.png',
      },
      {
        'id': 12,
        'img': 'hebron.png',
        'title': 'الخليل',
        'color': const Color(0XFF695730),
        'map': 'hebron_map.png',
      },
      {
        'id': 13,
        'img': 'gaza.png',
        'title': 'غزة',
        'color': const Color(0XFF1C4B47),
        'map': 'gaza_map.png',
      },
      {
        'id': 14,
        'img': 'beer_saba.png',
        'title': 'بئر السبع',
        'color': const Color(0XFF7C9544),
        'map': 'ber-elsabah_map.png',
      }
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'القرى المهجرة',
          share: '${Api.url}/villages',
          search: true,
          follow: 5,
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.all(defaultPadding / 2),
            sliver: SliverToBoxAdapter(
              child: PageMessage(
                txt:
                    'كي لا ننسى، القرى الفلسطينية التي دمرتها القوات الصهيونية، إبان نكبة 1948.',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            sliver: AnimationLimiter(
              child: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  mainAxisSpacing: defaultPadding,
                  crossAxisSpacing: defaultPadding,
                  childAspectRatio: 1 / 1.2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        horizontalOffset: defaultPadding,
                        child: FadeInAnimation(
                          child: CityCards(
                            id: city[index]["id"],
                            color: city[index]["color"],
                            img: city[index]["img"],
                            title: city[index]["title"],
                            map: city[index]['map'],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: city.length,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
