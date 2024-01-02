import 'package:flutter/material.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/article_info.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/title_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/get_locale.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:provider/provider.dart';

class AqsaDetails extends StatelessWidget {
  const AqsaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final aqsaProvider = Provider.of<AqsaProvider>(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id'];
    String title = args['title'];
    String? description = args['description'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).alaqsa,
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
                child: aqsaProvider.dataLoaded
                    ? ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: (aqsaProvider.subAqsaCat[id] ?? [])
                            .map((e) => TitleCard(
                                  id: e.id,
                                  title: e.title,
                                  description: e.description,
                                  images: e.images,
                                  goToPage: 'aqsa_more_details',
                                ))
                            .toList() // all the children is making an error
                        )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
