import 'package:flutter/material.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/components/add_review.dart';
import 'package:pal48/components/article_images.dart';
import 'package:pal48/components/html_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/square_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:provider/provider.dart';

class AqsaMoreDetails extends StatelessWidget {
  const AqsaMoreDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final aqsaProvider = Provider.of<AqsaProvider>(context, listen: true);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id'];
    String title = args['title'];
    String? description = args['description'];
    String? img = args['img'];
    List? images = args['images'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'المسجد الأقصى - $title',
          share: '${Api.url}/aqsa/$id',
        ),
      ),
      body: SafeArea(
        child: aqsaProvider.isDataLoaded
            ? CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          img != null
                              ? AspectRatio(
                                  aspectRatio: 1.15,
                                  child: NetworkImageWithLoader(
                                    Api.url + img,
                                    radius: defaultBorderRadious,
                                  ),
                                )
                              : const SizedBox(),
                          HtmlView(txt: description),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  ),
                  images != null
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: ArticleImagesSlider(
                            images: images.map((e) {
                              return "${Api.url}${e.filename}";
                            }).toList(),
                          ),
                        )
                      : const SliverToBoxAdapter(child: SizedBox()),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: defaultPadding,
                        crossAxisSpacing: defaultPadding,
                        childAspectRatio: 0.78,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return SquareCard(
                            id: aqsaProvider.subAqsaCat[id]![index].id,
                            title: aqsaProvider.subAqsaCat[id]![index].title,
                            img: aqsaProvider.subAqsaCat[id]![index].image!,
                            description: aqsaProvider
                                .subAqsaCat[id]![index].description!,
                            routeWhere: 'aqsa_more_details',
                            images: aqsaProvider.subAqsaCat[id]![index].images,
                          );
                        },
                        childCount: aqsaProvider.subAqsaCat[id]!.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ReviewForm(
                      comment: 'التعليق',
                      title: 'شاركنا برأيك',
                      onPressed: () {},
                      id: id,
                      model: 'aqsa',
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
