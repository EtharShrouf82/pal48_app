import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/search_page.dart';
import 'package:share_plus/share_plus.dart';

class PageAppBar extends StatelessWidget {
  final String? title;
  final bool search;
  final String share;
  final bool favorite;
  final int follow;

  const PageAppBar({
    super.key,
    this.title,
    this.search = false,
    this.share = '',
    this.favorite = false,
    this.follow = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: kHeadingTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodySmall!.color!),
            )
          : const SizedBox(),
      actions: [
        search
            ? IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: Search(follow: follow));
                },
                icon: SvgPicture.asset(
                  "assets/svg/Search.svg",
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : const SizedBox(),
        share != ''
            ? IconButton(
                onPressed: () {
                  Share.share(share);
                },
                icon: SvgPicture.asset(
                  "assets/svg/Share.svg",
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : const SizedBox(),
        favorite
            ? IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/Bookmark.svg",
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
