import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';

class QuestionCatCard extends StatelessWidget {
  final int id;
  final String title;
  final int numberOfQuestions;
  final QuestionProvider questionProvider;

  const QuestionCatCard({
    super.key,
    required this.id,
    required this.title,
    required this.numberOfQuestions,
    required this.questionProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.02),
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          ),
        ),
        onPressed: () {
          questionProvider.fetchQuestions(id);

          Navigator.pushNamed(context, '/questions', arguments: {
            'title': title,
            'id': id,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title - ($numberOfQuestions)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                questionProvider.numCorrect[id] != null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: '$numberOfQuestions' ==
                                  '${questionProvider.numCorrect[id] ?? ""} '
                              ? Colors.green
                              : Colors.red,
                        ),
                        padding: const EdgeInsets.only(
                            right: 3.0, left: 3.0, bottom: 3.0),
                        child: Text(
                          '${questionProvider.numCorrect[id] ?? ""} / $numberOfQuestions',
                          style: kHintTextStyle.copyWith(color: Colors.white),
                        ),
                      )
                    : const SizedBox(),
                SvgPicture.asset(
                  "assets/svg/Arrow - Left.svg",
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
