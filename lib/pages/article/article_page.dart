import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/article_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});
  @override
  Widget build(BuildContext context) {
    onArticleRefresh() {
      Provider.of<ArticleProvider>(context, listen: false).onArticleRefresh();
    }

    onArticleLoading() {
      Provider.of<ArticleProvider>(context, listen: false).onArticleLoading();
    }

    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'مقالات منوعة',
          share: '${Api.url}/articles',
          search: true,
          follow: 1,
        ),
      ),
      body: SafeArea(
        child: articleProvider.articleModel.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: articleProvider.refreshArticleController,
                          onRefresh: onArticleRefresh,
                          onLoading: onArticleLoading,
                          physics: const BouncingScrollPhysics(),
                          header: const WaterDropHeader(
                            waterDropColor: Colors.red,
                          ),
                          footer: const ClassicFooter(
                              loadStyle: LoadStyle.ShowWhenLoading),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 14,
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.2,
                              ),
                              itemCount: articleProvider.articleModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: ArticleCard(
                                        id: articleProvider
                                            .articleModel[index].id,
                                        img: articleProvider
                                            .articleModel[index].img!,
                                        description: articleProvider
                                            .articleModel[index].description,
                                        title: articleProvider
                                            .articleModel[index].title,
                                        images: articleProvider
                                            .articleModel[index].images,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
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
