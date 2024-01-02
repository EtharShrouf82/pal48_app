import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/html_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:share_plus/share_plus.dart';

class GazaShowImage extends StatelessWidget {
  final String? url;
  final String? description, inDate;
  final int id;
  final int? imageableId;

  const GazaShowImage({
    super.key,
    this.url,
    this.description,
    this.inDate,
    required this.id,
    this.imageableId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          AspectRatio(
            aspectRatio: 2 / 1,
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: url!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          description != null
              ? Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlView(
                        txt: description!,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
            onPressed: () {
              Share.share('${Api.url}/gaza/$id');
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
    );
  }
}
