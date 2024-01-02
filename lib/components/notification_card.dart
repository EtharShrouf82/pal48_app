import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/helpers/get_img.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:pal48/providers/village_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.time,
    required this.screen,
    this.pageId,
  });

  final String title, time;
  final int? pageId;
  final String? screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            screen != 'General'
                ? getRoute(screen!, pageId!, context, title)
                : null;
          },
          leading: Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: getBackgroundColor(screen!),
                child: SvgPicture.asset(
                  getSvgIcon(screen!),
                  height: 35,
                  colorFilter: const ColorFilter.mode(
                    whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            title,
            style: kPragraphTextStyle.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          subtitle: Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const Divider(),
      ],
    );
  }

  getRoute(String screen, int pageId, BuildContext context, String title) {
    if (screen == 'City') {
      final villageProvider =
          Provider.of<VillageProvider>(context, listen: false);
      if (villageProvider.villageModel[pageId] == null) {
        villageProvider.villageModel[pageId] = [];
        villageProvider.fetchVillages(pageId);
      }
      Navigator.pushNamed(context, '/village', arguments: {
        'id': pageId,
        'city': title,
        'map': getImg(pageId),
      });
    }
    if (screen == 'Article') {
      Navigator.pushNamed(context, '/article_notification', arguments: {
        'title': title,
        'id': pageId,
      });
    }
    if (screen == 'Questions') {
      Provider.of<QuestionProvider>(context, listen: false)
          .fetchQuestions(pageId);
      Navigator.pushNamed(context, '/questions', arguments: {
        'title': title,
        'id': pageId,
      });
    }

    if (screen == 'Nakba') {
      Provider.of<NakbaProvider>(context, listen: false)
          .fetchNakbaSubCats(pageId);
      Navigator.pushNamed(context, '/nakba_details', arguments: {
        'title': title,
        'id': pageId,
      });
    }

    if (screen == 'Aqsa') {
      Provider.of<AqsaProvider>(context, listen: false).fetcAqsaSubCat(pageId);
      Navigator.pushNamed(context, '/aqsa_details', arguments: {
        'title': title,
        'id': pageId,
      });
    }
  }

  Color getBackgroundColor(String screen) {
    if (screen == 'City') {
      return const Color(0xFFF3B923);
    }
    if (screen == 'Village') {
      return primaryColor;
    }
    if (screen == 'Nakba') {
      return const Color(0xFFE5614F);
    }
    if (screen == 'Questions') {
      return successColor;
    }
    return Colors.blue;
  }

  getSvgIcon(String screen) {
    if (screen == 'City') {
      return "assets/svg/key1.svg";
    }
    if (screen == 'Village') {
      return "assets/svg/key1.svg";
    }
    if (screen == 'Nakba') {
      return "assets/svg/pal_map_svg.svg";
    }
    if (screen == 'Questions') {
      return "assets/svg/FAQ.svg";
    }
    return "assets/svg/pal_map_svg.svg";
  }
  // svgSrc: index.isEven
  //   ? "assets/icons/Discount.svg"
  //   : "assets/icons/diamond.svg",
}
