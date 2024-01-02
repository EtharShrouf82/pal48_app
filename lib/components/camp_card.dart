import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/components/info_line_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';
import 'package:pal48/models/camp_model.dart';

class CampCard extends StatelessWidget {
  final CampModel campModel;

  const CampCard({super.key, required this.campModel});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<ArticleProvider>(context, listen: false).getComments(
          campModel.id,
        );
        Navigator.pushNamed(context, '/details', arguments: {
          'id': campModel.id,
          'images': campModel.images,
          'attachments': campModel.attachments,
          'img': campModel.img,
          'desc': campModel.desc,
          'title': campModel.title,
          'country': campModel.country,
          'city': campModel.city,
        });
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(256, 134),
        maximumSize: const Size(256, 134),
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.35,
            child: Stack(
              children: [
                campModel.img!.isEmpty
                    ? SvgPicture.asset(
                        "assets/svg/Search.svg",
                        height: 24,
                      )
                    : NetworkImageWithLoader(
                        radius: 0,
                        Api.url + campModel.img!,
                      ),
              ],
            ),
          ),
          const SizedBox(width: defaultPadding / 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoLineContainer(
                  text: campModel.title,
                ),
                const Spacer(),
                InfoLineContainer(
                  text: '${campModel.country!} - ${campModel.city!}',
                ),
                const Spacer(),
                InfoLineContainer(
                  text: campModel.result ?? '---',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
