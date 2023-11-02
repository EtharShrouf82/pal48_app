import 'package:flutter/material.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/add_review.dart';
import 'package:pal48/components/article_images.dart';
import 'package:pal48/components/article_info.dart';
import 'package:pal48/components/video_player.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/models/article_model.dart';
import 'package:pal48/pages/article/components/article_details_appbar.dart';
import 'package:pal48/services/article_service.dart';

class ArticleNotification extends StatelessWidget {
  const ArticleNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final articleService = ArticleService();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int id = args['id'];
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ArticleModel>(
          future: articleService.fetchArticleById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  ArticleDetailsAppbar(
                    img: snapshot.data!.img,
                    title: snapshot.data!.title,
                    id: id,
                  ),
                  ArticleInfo(
                    title: null,
                    description: snapshot.data!.description,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  ),
                  snapshot.data!.images!.isNotEmpty
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: ArticleImagesSlider(
                            title: snapshot.data!.description,
                            images: snapshot.data!.images!
                                .where((e) => e.type == 1)
                                .map((e) {
                              return "${Api.url}${e.filename}";
                            }).toList(),
                          ),
                        )
                      : const SliverToBoxAdapter(child: SizedBox()),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  ),
                  snapshot.data!.images!.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: Column(
                            children: snapshot.data!.images!
                                .where((element) => element.type == 2)
                                .map((e) {
                              return VideoPlayerSquare(
                                id: e.id,
                                url: e.filename,
                                description: e.desc,
                              );
                            }).toList(),
                          ),
                        )
                      : const SliverToBoxAdapter(child: SizedBox()),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  ),
                  SliverToBoxAdapter(
                    child: ReviewForm(
                      model: 'article',
                      id: id,
                      comment: 'التعليق',
                      title: 'شاركنا برأيك',
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
