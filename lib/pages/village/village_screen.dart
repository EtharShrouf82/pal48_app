import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/village_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/get_locale.dart';
import 'package:pal48/pages/village/components/map_img.dart';
import 'package:pal48/providers/village_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VillageScreen extends StatelessWidget {
  const VillageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id'];
    String title = args['city'];
    String map = args['map'];

    final villageProvider = Provider.of<VillageProvider>(context);

    onVillageRefresh() {
      villageProvider.onVillageRefresh(id);
    }

    onVillageLoading() {
      villageProvider.onVillageLoading(id);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title:
              '${translation(context).village} $title ( ${villageProvider.total} )',
          share: '${Api.url}/villages/$id',
          search: true,
          follow: 5,
        ),
      ),
      body: SafeArea(
        child: villageProvider.villageModel[id] != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: villageProvider.villageModel[id]!.isNotEmpty
                    ? AnimationLimiter(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: villageProvider.villageRefreshController,
                          onRefresh: onVillageRefresh,
                          onLoading: onVillageLoading,
                          physics: const BouncingScrollPhysics(),
                          header: const WaterDropHeader(
                            waterDropColor: primaryColor,
                          ),
                          footer: const ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                          ),
                          child: ListView(
                            children: [
                              MapImg(img: 'assets/img/$map'),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      villageProvider.villageModel[id]!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 14,
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.2,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: VillageCard(
                                            villageModel: villageProvider
                                                .villageModel[id]![index],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
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
