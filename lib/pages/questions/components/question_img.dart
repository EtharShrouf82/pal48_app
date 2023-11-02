import 'package:flutter/material.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/Ui/network_image_with_loader.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';

class QuestionImage extends StatelessWidget {
  final QuestionProvider questionProvider;

  const QuestionImage({super.key, required this.questionProvider});

  @override
  Widget build(BuildContext context) {
    return questionProvider
                .questionsModel[questionProvider.questionNumber].img !=
            ''
        ? Container(
            margin: const EdgeInsets.only(top: defaultPadding),
            height: 150,
            child: NetworkImageWithLoader(
              Api.url +
                  questionProvider
                      .questionsModel[questionProvider.questionNumber].img!,
              radius: defaultBorderRadious,
              fit: BoxFit.contain,
            ),
          )
        : Container();
  }
}
