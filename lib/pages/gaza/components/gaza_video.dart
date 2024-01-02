import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/html_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:share_plus/share_plus.dart';

class GazaVideo extends StatefulWidget {
  final String? url;
  final String? description, inDate;
  final int id;
  final int? imageableId, type;
  final bool withLink;

  const GazaVideo({
    super.key,
    required this.url,
    this.description,
    this.inDate,
    this.type,
    required this.id,
    this.imageableId,
    this.withLink = false,
  });
  @override
  GazaVideoState createState() => GazaVideoState();
}

class GazaVideoState extends State<GazaVideo> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    videoPlayerController =
        // ignore: deprecated_member_use
        VideoPlayerController.network(widget.url!)
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: AspectRatio(
                  aspectRatio: 1 / 1.1,
                  child: CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController,
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              widget.description != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlView(
                        txt: widget.description!,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                onPressed: () {
                  Share.share('${Api.url}/gaza/${widget.id}');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Send To Friend'),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    SvgPicture.asset(
                      'assets/svg/Send.svg',
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
