import 'package:flutter/material.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/pages/article/components/nav_item.dart';
import 'package:pal48/ui/network_image_with_loader.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailsAppbar extends StatelessWidget {
  final String? img;
  final String title;
  final int id;

  const ArticleDetailsAppbar({
    super.key,
    this.img,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // final favoriteProvider = Provider.of<FavoriteProvider>(context);
    // bool inFavorite = favoriteProvider.favoriteArray.any((f) => f == id);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: img != null ? 220.0 : defaultPadding,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavItems(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: "assets/svg/Arrow - Right.svg",
            iconColor: Theme.of(context).textTheme.bodyLarge!.color!,
          ),
          Row(
            children: [
              NavItems(
                onPressed: () {
                  Share.share('${Api.url}/article/$id');
                },
                icon: "assets/svg/Share.svg",
                iconColor: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(defaultPadding),
        child: Container(
          color: Colors.black38,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: Center(
            child: Text(
              title,
              style: kHeadingTextStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: img != null
            ? AspectRatio(
                aspectRatio: 1,
                child: NetworkImageWithLoader(
                  Api.url + img!,
                  zoom: true,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
