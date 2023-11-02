import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/components/info_line_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/models/masscare_model.dart';

class MassacreCard extends StatelessWidget {
  final MasscareModel masscareModel;

  const MassacreCard({super.key, required this.masscareModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/details', arguments: {
            'title': masscareModel.title,
            'id': masscareModel.id,
            'img': masscareModel.img,
            'images': masscareModel.images,
            'desc': masscareModel.desc,
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
                  masscareModel.img != null
                      ? NetworkImageWithLoader(
                          radius: 0,
                          Api.url + masscareModel.img!,
                        )
                      : Center(
                          child: SvgPicture.asset(
                            "assets/svg/mascare.svg",
                          ),
                        )
                ],
              ),
            ),
            const SizedBox(width: defaultPadding / 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoLineContainer(
                    text: masscareModel.title,
                  ),
                  const Spacer(),
                  InfoLineContainer(
                    text: masscareModel.inDate ?? '---',
                  ),
                  const Spacer(),
                  InfoLineContainer(
                    text: masscareModel.result ?? '---',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
