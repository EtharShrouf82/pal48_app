import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';

class ErrorSuccessCheck extends StatelessWidget {
  final QuestionProvider questionProvider;

  const ErrorSuccessCheck({super.key, required this.questionProvider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.0,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
        ),
        crossAxisSpacing: 5,
        mainAxisSpacing: 4,
        crossAxisCount: 15,
        children: questionProvider.userAnswer.map((e) {
          return e == 1
              ? const Icon(
                  Icons.check,
                  color: successColor,
                )
              : const Icon(
                  Icons.close,
                  color: errorColor,
                );
        }).toList(),
      ),
    );
  }
}
