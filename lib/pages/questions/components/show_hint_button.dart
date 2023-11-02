import 'package:flutter/material.dart';
import 'package:pal48/pages/questions/functions/show_hint_modal.dart';
import 'package:pal48/providers/question_provider.dart';

class ShowHintButton extends StatelessWidget {
  final QuestionProvider questionProvider;

  const ShowHintButton({super.key, required this.questionProvider});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showHintModal(
            context,
            questionProvider
                .questionsModel[questionProvider.questionNumber].question,
            questionProvider
                .questionsModel[questionProvider.questionNumber].hint!);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: const Text("إظهار المساعدة"),
    );
  }
}
