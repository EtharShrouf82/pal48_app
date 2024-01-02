import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/add_review.dart';
import 'package:pal48/components/article_images.dart';
import 'package:pal48/components/article_info.dart';
import 'package:pal48/components/comment_box.dart';
import 'package:pal48/components/download_button.dart';
import 'package:pal48/components/video_player.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';
import 'package:pal48/helpers/open_link.dart';
import 'package:pal48/models/photo_model.dart';
import 'package:pal48/pages/article/components/article_details_appbar.dart';

import 'components/article_map.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int id = args['id'];
    final List? images = args['images']!;
    final List? attachments = args['attachments']!;
    final String? img = args['img'];
    final String title = args['title'];
    final String desc = args['desc'];
    final String? lat = args['lat'];
    final String? long = args['long'];
    if (img != null) {
      images!.add(
        PhotoModel(filename: args['img'], desc: args['title'], id: id, type: 1),
      );
    }
    // CampModel camp = args['campModel'];

    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ArticleDetailsAppbar(
              img: img,
              title: title,
              id: id,
            ),
            lat != null
                ? MarkerIconsBody(
                    lat: lat,
                    long: long!,
                    title: title,
                  )
                : const SliverToBoxAdapter(child: SizedBox()),
            ArticleInfo(
              title: null,
              description: desc,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            ),
            attachments!.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Column(
                      children: attachments.map((e) {
                        return DownloadButton(
                          url: Api.url + e.filename,
                          desc: e.desc != null ? e.desc! : title,
                        );
                      }).toList(),
                    ),
                  )
                : const SliverToBoxAdapter(child: SizedBox()),
            images!.isNotEmpty
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: ArticleImagesSlider(
                      images: images.where((e) => e.type == 1).map((e) {
                        return "${Api.url}${e.filename}";
                      }).toList(),
                    ),
                  )
                : const SliverToBoxAdapter(child: SizedBox()),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            ),
            images.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Column(
                      children:
                          images.where((element) => element.type == 2).map((e) {
                        return VideoPlayerSquare(
                          id: e.id,
                          url: e.filename,
                          description: e.desc,
                        );
                      }).toList(),
                    ),
                  )
                : const SliverToBoxAdapter(child: SizedBox()),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: articleProvider.isComentLoaded == false
                    ? articleProvider.commentArray.isNotEmpty
                        ? Column(
                            children: articleProvider.commentArray.map((e) {
                              return CommentBox(
                                name: e.name,
                                reply: e.reply,
                                comment: e.comment,
                                updatedAt: e.updatedAt,
                                time: e.date,
                              );
                            }).toList(),
                          )
                        : const SizedBox()
                    : const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            ),
            SliverToBoxAdapter(
              child: ReviewForm(
                model: 'article',
                id: id,
                comment: translation(context).comment,
                title: translation(context).shareYourOpinion,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
