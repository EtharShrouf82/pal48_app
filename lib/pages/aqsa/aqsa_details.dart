import 'package:flutter/material.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/article_info.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/title_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:provider/provider.dart';

class AqsaDetails extends StatelessWidget {
  const AqsaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final aqsaProvider = Provider.of<AqsaProvider>(context, listen: true);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id'];
    String title = args['title'];
    String? description = args['description'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'المسجد الأقصى',
          share: '${Api.url}/aqsa/$id',
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ArticleInfo(
              title: title,
              description: description,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: aqsaProvider.isDataLoaded
                    ? ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: (aqsaProvider.subAqsaCat[id] ?? [])
                            .map((e) => TitleCard(
                                  id: e.id,
                                  title: e.title,
                                  description: e.description,
                                  goToPage: 'aqsa_more_details',
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
