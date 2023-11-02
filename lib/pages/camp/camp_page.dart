import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/camp_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/camps_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/multi_select.dart';

class CampPage extends StatelessWidget {
  const CampPage({super.key});
  @override
  Widget build(BuildContext context) {
    final campProvider = Provider.of<CampsProvider>(context);
    onRefresh() {
      campProvider.onRefresh();
    }

    onLoading() {
      campProvider.onLoading();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'المخيمات الفلسطينية',
          share: '${Api.url}/camps',
          search: true,
          follow: 7,
        ),
      ),
      body: SafeArea(
        child: campProvider.campModel.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MultiCampSelect(
                      initialValue: campProvider.myActivities,
                      onSaved: (value) {
                        if (value.length > 0) {
                          campProvider.fetchCamps(
                            withClear: true,
                            country: value,
                          );
                        } else {
                          campProvider.page = 1;
                          campProvider.campModel = [];
                          campProvider.fetchCamps();
                        }
                      },
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: campProvider.refreshController,
                          onRefresh: onRefresh,
                          onLoading: onLoading,
                          physics: const BouncingScrollPhysics(),
                          header: const WaterDropHeader(
                            waterDropColor: Colors.red,
                          ),
                          footer: const ClassicFooter(
                              loadStyle: LoadStyle.ShowWhenLoading),
                          child: ListView.builder(
                              itemCount: campProvider.campModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: CampCard(
                                        campModel:
                                            campProvider.campModel[index],
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
