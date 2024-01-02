import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/exports/exports.dart';

import '../Api/Api.dart';
import '../constants/constants.dart';

class ArticleCard extends StatelessWidget {
  final String img;
  final String title;
  final int id;
  final List? images;
  final List? attachments;
  final String description;

  const ArticleCard({
    super.key,
    required this.img,
    required this.title,
    required this.id,
    required this.description,
    this.images,
    this.attachments,
  });
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<ArticleProvider>(context, listen: false).getComments(
          id,
        );
        Navigator.pushNamed(context, '/details', arguments: {
          'id': id,
          'img': img,
          'images': images,
          'desc': description,
          'title': title,
          'attachments': attachments,
        });
      },
      style: OutlinedButton.styleFrom(
          minimumSize: const Size(110, 220),
          maximumSize: const Size(110, 220),
          padding: const EdgeInsets.all(5)),
      child: Stack(
        children: [
          NetworkImageWithLoader(
            Api.url + img,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              color: blackColor.withOpacity(0.7),
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: kPragraphTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
