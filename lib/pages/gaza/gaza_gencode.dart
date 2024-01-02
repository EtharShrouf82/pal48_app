import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/pages/gaza/components/gaza_show_image.dart';
import 'package:pal48/pages/gaza/components/gaza_video.dart';
import 'package:pal48/providers/gaza_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/filter_form.dart';

class GazaGincode extends StatelessWidget {
  const GazaGincode({super.key});

  @override
  Widget build(BuildContext context) {
    final gazaProvide = Provider.of<GazaProvider>(context);
    onMediaRefresh() {
      gazaProvide.onRefresh();
    }

    onMediaLoading() {
      gazaProvide.onLoading();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'Gaza Genocide',
          share: '${Api.url}/gaza',
        ),
      ),
      body: SafeArea(
        child: gazaProvide.gazaModel.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FilterForm(
                      gazaProvide: gazaProvide,
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: gazaProvide.refreshController,
                          onRefresh: onMediaRefresh,
                          onLoading: onMediaLoading,
                          physics: const BouncingScrollPhysics(),
                          header: const WaterDropHeader(
                            waterDropColor: Colors.red,
                          ),
                          footer: const ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                          ),
                          child: ListView.builder(
                              itemCount: gazaProvide.gazaModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: getMedia(gazaProvide, index),
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

getMedia(GazaProvider gazaProvide, index) {
  if (gazaProvide.gazaModel[index].type == 1) {
    return GazaVideo(
      id: gazaProvide.gazaModel[index].id,
      url: gazaProvide.gazaModel[index].link,
      description: gazaProvide.gazaModel[index].description,
      inDate: gazaProvide.gazaModel[index].inDate,
      withLink: true,
    );
  } else {
    return GazaShowImage(
      id: gazaProvide.gazaModel[index].id,
      url: gazaProvide.gazaModel[index].link,
      description: gazaProvide.gazaModel[index].description,
      inDate: gazaProvide.gazaModel[index].inDate,
    );
  }
}
