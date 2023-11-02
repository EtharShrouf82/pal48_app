import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/constants/constants.dart';

class VideoPlayerSquare extends StatefulWidget {
  final String? url;
  final String? description;
  final int id;
  final int? imageableId;
  final bool withLink;

  const VideoPlayerSquare({
    Key? key,
    required this.url,
    this.description,
    required this.id,
    this.imageableId,
    this.withLink = false,
  }) : super(key: key);
  @override
  VideoPlayerSquareState createState() => VideoPlayerSquareState();
}

class VideoPlayerSquareState extends State<VideoPlayerSquare> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    videoPlayerController =
        // ignore: deprecated_member_use
        VideoPlayerController.network("${Api.url}/${widget.url!}")
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          margin: const EdgeInsets.only(bottom: defaultPadding * 2),
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            boxShadow: const [kDefaultShadow],
            border: const Border(
              right: BorderSide(width: 3.0, color: primaryColor),
            ),
          ),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              widget.description != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.description!,
                        style: kPragraphTextStyle.copyWith(
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  : const SizedBox(),
              widget.withLink
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/article_notification',
                              arguments: {
                                'title': 'ثريد',
                                'id': widget.imageableId,
                              });
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/Arrow - Left.svg",
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyLarge!.color!,
                              BlendMode.srcIn),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: defaultPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
