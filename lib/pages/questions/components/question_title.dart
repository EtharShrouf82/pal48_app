import 'package:flutter/material.dart';
import 'package:pal48/providers/question_provider.dart';

class QuestionTitle extends StatelessWidget {
  final QuestionProvider questionProvider;

  const QuestionTitle({super.key, required this.questionProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            questionProvider
                .questionsModel[questionProvider.questionNumber].question,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.3,
              color: Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
        ),
        Text(
          '${questionProvider.questionNumber + 1} / ${questionProvider.questionsModel.length}',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!,
            color: Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
      ],
    );
  }
}
