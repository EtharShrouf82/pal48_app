import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';

import '../functions/show_result_modal.dart';

class SubmitAnswerButton extends StatelessWidget {
  final QuestionProvider questionProvider;
  final int questionCatId;

  const SubmitAnswerButton({
    super.key,
    required this.questionProvider,
    required this.questionCatId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        questionProvider.val == 0
            ? null
            : questionProvider.addAnswer(
                questionProvider
                    .questionsModel[questionProvider.questionNumber],
                questionProvider.questionsModel[questionProvider.questionNumber]
                    .correctAnswer,
                questionProvider.val,
              );
        questionProvider.questionsModel.length ==
                questionProvider.questionNumber + 1
            ? showResultModal(
                context,
                questionProvider,
                questionCatId,
              )
            : const SizedBox();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            questionProvider.val == 0 ? blackColor40 : primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: const Text("إجابة"),
    );
  }
}
