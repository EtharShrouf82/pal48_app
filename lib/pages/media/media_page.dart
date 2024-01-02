import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/video_player.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaProvider = Provider.of<MediaProvider>(context);
    onMediaRefresh() {
      mediaProvider.onMediaRefresh();
    }

    onMediaLoading() {
      mediaProvider.onMediaLoading();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).medialLibrary,
          share: '${Api.url}/media',
        ),
      ),
      body: SafeArea(
        child: mediaProvider.mediaArray.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimationLimiter(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: mediaProvider.refreshMediaController,
                    onRefresh: onMediaRefresh,
                    onLoading: onMediaLoading,
                    physics: const BouncingScrollPhysics(),
                    header: const WaterDropHeader(
                      waterDropColor: Colors.red,
                    ),
                    footer: const ClassicFooter(
                        loadStyle: LoadStyle.ShowWhenLoading),
                    child: ListView.builder(
                        itemCount: mediaProvider.mediaArray.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: VideoPlayerSquare(
                                  id: mediaProvider.mediaArray[index].id,
                                  url: mediaProvider.mediaArray[index].filename,
                                  imageableId: mediaProvider
                                      .mediaArray[index].imageableId,
                                  description: mediaProvider
                                      .mediaArray[index].description,
                                  withLink: true,
                                ),
                              ),
                            ),
                          );
                        }),
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
