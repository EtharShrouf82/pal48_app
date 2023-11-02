import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';

class QuestionAnswers extends StatelessWidget {
  final QuestionProvider questionProvider;

  const QuestionAnswers({
    super.key,
    required this.questionProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: questionProvider
          .questionsModel[questionProvider.questionNumber].answers
          .map((e) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: defaultPadding,
          ),
          child: Material(
            child: RadioListTile(
              tileColor: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.02),
              title: Text(e.answer),
              groupValue: questionProvider.val,
              value: e.id,
              onChanged: (value) {
                questionProvider.setSelected(value);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
