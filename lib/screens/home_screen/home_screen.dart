import 'package:flutter/material.dart';
import 'package:pal48/components/main_app_cat.dart';
import 'package:pal48/components/slider_carousel.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/article_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);
    final List<Map> screens = [
      {
        'img': 'nakba.png',
        'type': 'Nakba',
      },
      {
        'img': 'village.png',
        'type': 'village',
      },
      {
        'img': 'mascare.png',
        'type': 'mascare',
      },
      {
        'img': 'aqsa.png',
        'type': 'aqsa',
      },
      {
        'img': 'camps.png',
        'type': 'camps',
      },
      {
        'img': 'place.png',
        'type': 'place',
      },
      {
        'img': 'articles.png',
        'type': 'articles',
      },
      {
        'img': 'questions.png',
        'type': 'questionsCat',
      },
      {
        'img': 'media.jpeg',
        'type': 'videos',
      },
      {
        'img': 'calender.jpeg',
        'type': 'calender',
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: articleProvider.sliderModel.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SliderCarousel(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300.0,
                        childAspectRatio: 2 / 1.3,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return MainAppCat(
                            img: screens[index]["img"],
                            type: screens[index]["type"],
                            articleProvider: articleProvider,
                          );
                        },
                        childCount: screens.length,
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
      ),
    );
  }
}
