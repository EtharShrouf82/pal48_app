import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/pages/questions/components/question_img.dart';
import 'package:pal48/pages/questions/components/question_title.dart';
import 'package:pal48/pages/questions/components/show_hint_button.dart';
import 'package:pal48/pages/questions/components/submit_answer_button.dart';
import 'package:pal48/providers/question_provider.dart';

import 'error_success_check.dart';
import 'question_answers.dart';

class QuestionCard extends StatelessWidget {
  final QuestionProvider questionProvider;
  final int questionCatId;

  const QuestionCard({
    super.key,
    required this.questionProvider,
    required this.questionCatId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [kDefaultShadow],
        color: Theme.of(context).cardColor,
      ),
      margin: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
      ),
      padding: const EdgeInsets.all(defaultPadding),
      transform: Matrix4.translationValues(0.0, transformValue, 0.0),
      child: Column(
        children: [
          QuestionTitle(questionProvider: questionProvider),
          QuestionImage(questionProvider: questionProvider),
          QuestionAnswers(questionProvider: questionProvider),
          SubmitAnswerButton(
            questionProvider: questionProvider,
            questionCatId: questionCatId,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          questionProvider
                      .questionsModel[questionProvider.questionNumber].hint !=
                  null
              ? ShowHintButton(questionProvider: questionProvider)
              : const SizedBox(),
          const SizedBox(
            height: defaultPadding,
          ),
          ErrorSuccessCheck(questionProvider: questionProvider)
        ],
      ),
    );
  }
}
