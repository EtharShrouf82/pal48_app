import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/article_info.dart';
import 'package:pal48/components/title_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NakbaDetails extends StatelessWidget {
  const NakbaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final nakbaProvider = Provider.of<NakbaProvider>(context, listen: true);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id'];
    String title = args['title'];
    String? description = args['description'];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              title: Text(
                title,
                style: kHeadingTextStyle.copyWith(
                  color: Theme.of(context).textTheme.titleLarge!.color!,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Share.share('${Api.url}/nkbh/$id');
                  },
                  icon: SvgPicture.asset(
                    "assets/svg/Share.svg",
                    colorFilter: ColorFilter.mode(
                      nakbaProvider.isFavorite
                          ? errorColor
                          : Theme.of(context).textTheme.bodyLarge!.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            ArticleInfo(
              title: null,
              description: description,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: nakbaProvider.isDataLoaded
                    ? ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: (nakbaProvider.subNakbaCatModel[id] ?? [])
                            .map((e) => TitleCard(
                                  id: e.id,
                                  title: e.title,
                                  description: e.description,
                                  goToPage: 'nakba_details',
                                ))
                            .toList() // all the children is making an error
                        )
                    : const SizedBox(),
              ),
            ),
            // ProductListTile(
            //   title: "إضافة تقييم",
            //   svgSrc: "assets/icons/Chat-add.svg",
            //   isShowBottomBorder: true,
            //   press: () {
            //     showRatingDialog(product.id.toString(), context, formKey);
            //   },
            // ),
            // SliverPadding(
            //   padding: const EdgeInsets.all(defaultPadding),
            //   sliver: SliverToBoxAdapter(
            //     child: Text(
            //       "قد يعجبك أيضاً.",
            //       style: Theme.of(context).textTheme.titleSmall!,
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 260,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: productProvider.similarProductArray.length,
            //       itemBuilder: (context, index) => Padding(
            //         padding: EdgeInsets.only(
            //             left: defaultPadding,
            //             right: index == 4 ? defaultPadding : 0),
            //         child: ProductCard(
            //           productProvider: productProvider,
            //           product: productProvider.similarProductArray[index],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
