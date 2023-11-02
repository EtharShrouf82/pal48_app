import 'package:flutter/material.dart';
import 'package:pal48/components/html_card.dart';

import '../constants/constants.dart';

class ArticleInfo extends StatelessWidget {
  const ArticleInfo({
    Key? key,
    this.title,
    this.description,
  }) : super(key: key);

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Text(
                    title!,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                : const SizedBox(),
            const SizedBox(height: defaultPadding / 2),
            description != null
                ? HtmlView(
                    txt: description,
                  )
                : const SizedBox(),
            const SizedBox(height: defaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
