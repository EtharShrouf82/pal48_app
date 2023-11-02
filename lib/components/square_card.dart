import 'package:flutter/material.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:provider/provider.dart';

import '../Api/Api.dart';
import '../constants/constants.dart';

class SquareCard extends StatelessWidget {
  final String img;
  final String title;
  final int id;
  final String description;
  final String routeWhere;
  final List? images;

  const SquareCard({
    super.key,
    required this.img,
    required this.title,
    required this.id,
    required this.description,
    required this.routeWhere,
    this.images,
  });
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (routeWhere == 'aqsa_more_details') {
          Provider.of<AqsaProvider>(context, listen: false).fetcAqsaSubCat(id);
        } else {
          Provider.of<NakbaProvider>(context, listen: false)
              .fetchNakbaSubCats(id);
        }
        Navigator.pushNamed(context, '/$routeWhere', arguments: {
          'title': title,
          'id': id,
          'description': description,
          'img': img,
          'images': images,
        });
      },
      style: OutlinedButton.styleFrom(
          minimumSize: const Size(110, 220),
          maximumSize: const Size(110, 220),
          padding: const EdgeInsets.all(8)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: NetworkImageWithLoader(
              Api.url + img,
              radius: defaultBorderRadious,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 2,
              vertical: defaultPadding / 2,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding / 3),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kPragraphTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
