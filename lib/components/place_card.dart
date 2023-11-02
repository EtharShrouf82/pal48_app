import 'package:flutter/material.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import '../Api/Api.dart';
import '../constants/constants.dart';

class PlaceCard extends StatelessWidget {
  final String img;
  final String title;
  final String city;
  final int id;
  final List? images;
  final String description;

  const PlaceCard({
    super.key,
    required this.img,
    required this.title,
    required this.id,
    required this.city,
    required this.images,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/details', arguments: {
          'title': title,
          'id': id,
          'img': img,
          'images': images,
          'desc': description,
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
                  Text(
                    city,
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
