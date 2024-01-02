import 'package:flutter/material.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/models/village_model.dart';
import 'package:pal48/providers/article_provider.dart';
import 'package:provider/provider.dart';

import '../Api/Api.dart';
import '../constants/constants.dart';

class VillageCard extends StatelessWidget {
  final VillageModel villageModel;

  const VillageCard({
    super.key,
    required this.villageModel,
  });
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<ArticleProvider>(context, listen: false)
            .getComments(villageModel.id);
        Navigator.pushNamed(context, '/details', arguments: {
          'id': villageModel.id,
          'images': villageModel.images,
          'attachments': villageModel.attachments,
          'img': villageModel.img,
          'desc': villageModel.desc,
          'title': villageModel.title,
          'lat': villageModel.latitude,
          'long': villageModel.longitude,
        });
      },
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(8)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.25,
            child: NetworkImageWithLoader(
              Api.url + villageModel.img,
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
                    villageModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kPragraphTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  villageModel.inDate != null
                      ? Text(
                          villageModel.inDate!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kPragraphTextStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge!.fontSize,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
