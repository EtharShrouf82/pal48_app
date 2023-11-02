import 'package:flutter/material.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/article_provider.dart';
import 'package:pal48/providers/camps_provider.dart';
import 'package:pal48/providers/masscare_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:pal48/providers/place_provider.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:pal48/providers/video_provider.dart';
import 'package:provider/provider.dart';
// import 'package:pal48/Providers/article_provider.dart';
// import 'package:provider/provider.dart';

class MainAppCat extends StatelessWidget {
  final String img;
  final String type;
  final ArticleProvider articleProvider;

  const MainAppCat({
    Key? key,
    required this.img,
    required this.type,
    required this.articleProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final articleProvider = Provider.of<ArticleProvider>(context);
    return InkWell(
      onTap: () async {
        switch (type) {
          case 'Nakba':
            {
              final nakba = Provider.of<NakbaProvider>(context, listen: false);
              if (nakba.mainNakbaCatModel.isEmpty) {
                nakba.fetcNakbaMainCat();
              }
              Navigator.pushNamed(context, '/nakba');
            }
            break;
          case 'village':
            {
              Navigator.pushNamed(context, '/city');
            }
            break;
          case 'camps':
            {
              final campsProvider =
                  Provider.of<CampsProvider>(context, listen: false);
              if (campsProvider.campModel.isEmpty) {
                campsProvider.fetchCamps();
              }
              Navigator.pushNamed(context, '/camps');
            }
            break;
          case 'place':
            {
              final placeProvider =
                  Provider.of<PlaceProvider>(context, listen: false);
              if (placeProvider.placeModel.isEmpty) {
                placeProvider.fetchPlaces();
              }
              Navigator.pushNamed(context, '/place');
            }
            break;
          case 'articles':
            {
              if (articleProvider.articleModel.isEmpty) {
                articleProvider.fetchArticles();
              }
              Navigator.pushNamed(context, '/articles');
            }
            break;
          case 'mascare':
            {
              final massacreProvider =
                  Provider.of<MasscareProvider>(context, listen: false);
              if (massacreProvider.masscareModel.isEmpty) {
                massacreProvider.fetchMasscare();
              }
              Navigator.pushNamed(context, '/massacre');
            }
            break;
          case 'aqsa':
            {
              final aqsa = Provider.of<AqsaProvider>(context, listen: false);
              if (aqsa.aqsaModel.isEmpty) {
                aqsa.fetcAqsaMainCat();
              }
              Navigator.pushNamed(context, '/aqsa');
            }
            break;
          case 'questionsCat':
            {
              final questionProvider =
                  Provider.of<QuestionProvider>(context, listen: false);
              if (questionProvider.questionCatModel.isEmpty) {
                questionProvider.fetchQuestionsCat();
              }
              Navigator.pushNamed(context, '/questionsCat');
            }
            break;
          case 'videos':
            {
              final mediaProvider =
                  Provider.of<MediaProvider>(context, listen: false);
              if (mediaProvider.mediaArray.isEmpty) {
                mediaProvider.fetchVideos();
              }
              Navigator.pushNamed(context, '/media');
            }
            break;
          case 'calender':
            {
              DateTime today = DateTime.now();
              if (articleProvider.eventsModel.isEmpty) {
                articleProvider.fetchEvents(today.month, today.day);
              }
              Navigator.pushNamed(context, '/calender');
            }
            break;
          default:
            {
              // Provider.of<ArticleProvider>(context, listen: false)
              //     .fetchArticles(withClear: true);
            }
            break;
        }
      },
      child: Image.asset(
        "assets/img/$img",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
