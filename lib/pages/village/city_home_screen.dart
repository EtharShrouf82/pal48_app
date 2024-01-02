import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/city_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/page_message.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map> city = [
      {
        'id': 1,
        'img': 'safad.png',
        'title': translation(context).safed,
        'color': const Color(0XFFaa8126),
        'map': 'safad_map.png',
      },
      {
        'id': 3,
        'img': 'akka.png',
        'title': translation(context).acre,
        'color': const Color(0XFF50664B),
        'map': 'akka_map.png',
      },
      {
        'id': 5,
        'img': 'tabaria.png',
        'title': translation(context).tiberius,
        'color': const Color(0XFF2C6A4F),
        'map': 'tabaria_map.png',
      },
      {
        'id': 2,
        'img': 'nzareth.png',
        'title': translation(context).nazareth,
        'color': const Color(0XFF8E8325),
        'map': 'nzareth_map.png',
      },
      {
        'id': 6,
        'img': 'haifa.png',
        'title': translation(context).yafa,
        'color': const Color(0XFF849A80),
        'map': 'haifa_map.png',
      },
      {
        'id': 7,
        'img': 'besan.png',
        'title': translation(context).besan,
        'color': const Color(0XFF7C9544),
        'map': 'bessan_map.png',
      },
      {
        'id': 8,
        'img': 'jenin.png',
        'title': translation(context).jenin,
        'color': const Color(0XFF8E8325),
        'map': 'jenin_map.png',
      },
      {
        'id': 9,
        'img': 'tulkarem.png',
        'title': translation(context).tulkarm,
        'color': const Color(0XFF0F4A72),
        'map': 'tulkarem_map.png',
      },
      {
        'id': 10,
        'img': 'yafa.png',
        'title': translation(context).yafa,
        'color': const Color(0XFF8E431D),
        'map': 'yaffa_map.png',
      },
      {
        'id': 4,
        'img': 'ramleh.png',
        'title': translation(context).ramla,
        'color': const Color(0XFF75B5A5),
        'map': 'ramleh_map.png',
      },
      {
        'id': 11,
        'img': 'jerusalem.png',
        'title': translation(context).jerusalem,
        'color': const Color(0XFFA2BF80),
        'map': 'jerusalem_map.png',
      },
      {
        'id': 12,
        'img': 'hebron.png',
        'title': translation(context).hebron,
        'color': const Color(0XFF695730),
        'map': 'hebron_map.png',
      },
      {
        'id': 13,
        'img': 'gaza.png',
        'title': translation(context).gaza,
        'color': const Color(0XFF1C4B47),
        'map': 'gaza_map.png',
      },
      {
        'id': 14,
        'img': 'beer_saba.png',
        'title': translation(context).beersheba,
        'color': const Color(0XFF7C9544),
        'map': 'ber-elsabah_map.png',
      }
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).displacedVillages,
          share: '${Api.url}/villages',
          search: true,
          follow: 5,
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            sliver: SliverToBoxAdapter(
              child: PageMessage(
                txt: translation(context).toNotForget,
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
