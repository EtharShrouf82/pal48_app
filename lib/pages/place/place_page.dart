import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/place_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/place_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/multi_select.dart';

class PlacePage extends StatelessWidget {
  const PlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);
    onPlaceRefresh() {
      placeProvider.onPlaceRefresh();
    }

    onPlaceLoading() {
      placeProvider.onPlaceLoading();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'الأماكن الأثرية',
          share: '${Api.url}/place',
          search: true,
          follow: 6,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MultiSelect(
              initialValue: placeProvider.placeMyActivities,
              onSaved: (value) {
                if (value.length > 0) {
                  placeProvider.fetchPlaces(
                    withClear: true,
                    country: value,
                  );
                } else {
                  placeProvider.placePage = 1;
                  placeProvider.placeModel = [];
                  placeProvider.fetchPlaces();
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
                  controller: placeProvider.refreshPlaceController,
                  onRefresh: onPlaceRefresh,
                  onLoading: onPlaceLoading,
                  physics: const BouncingScrollPhysics(),
                  header: const WaterDropHeader(
                    waterDropColor: primaryColor,
                  ),
                  footer:
                      const ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 14,
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.3,
                      ),
                      itemCount: placeProvider.placeModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: PlaceCard(
                                id: placeProvider.placeModel[index].id,
                                img: placeProvider.placeModel[index].img,
                                title: placeProvider.placeModel[index].title,
                                description:
                                    placeProvider.placeModel[index].desc,
                                city: placeProvider.placeModel[index].city,
                                images: placeProvider.placeModel[index].images,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
