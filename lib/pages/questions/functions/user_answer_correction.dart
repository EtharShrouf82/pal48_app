import 'package:flutter/material.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:pal48/ui/network_image_with_loader.dart';

userAnswerCorrection(QuestionProvider questionProvider, BuildContext context) {
  return questionProvider.wrongAnswer.isNotEmpty
      ? TextButton(
          child: const Text('إظهار الإجابات الخاطئة'),
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              isDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'حلول الأسئلة الخاطئة',
                                style: kSubHeadTextStyle.copyWith(
                                  shadows: <Shadow>[
                                    const Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 5.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: questionProvider.wrongAnswer.map((e) {
                              List<Widget> lstAnswers = [];
                              for (var a in e['question'].answers) {
                                var isWrongAnswer = a.id == e['user_answer'];
                                var isRightAnswer =
                                    a.id == e['question'].correctAnswer;

                                lstAnswers.add(isWrongAnswer
                                    ? Container(
                                        padding: const EdgeInsets.only(
                                          bottom: defaultPadding,
                                          right: defaultPadding,
                                          top: 5.0,
                                        ),
                                        color: Colors.red,
                                        child: Text(a.answer,
                                            style: kSubHeadTextStyle.copyWith(
                                              color: Colors.white,
                                            )),
                                      )
                                    : isRightAnswer
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                              bottom: defaultPadding,
                                              right: defaultPadding,
                                              top: 5.0,
                                            ),
                                            color: Colors.green,
                                            child: Text(a.answer,
                                                style:
                                                    kSubHeadTextStyle.copyWith(
                                                        color: Colors.white)),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.only(
                                              bottom: defaultPadding,
                                              right: defaultPadding,
                                              top: 5.0,
                                            ),
                                            child: Text(
                                              a.answer,
                                            ),
                                          ));
                              }

                              return Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                  ),
                                  decoration: const BoxDecoration(
                                    // boxShadow: const [kDefaultShadow],
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e['question'].question,
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      ),
                                      e['question'].img != null
                                          ? Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: Center(
                                                child: NetworkImageWithLoader(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  '${Api.url}/images/questions/' +
                                                      e['question'].img!,
                                                  radius: defaultBorderRadious,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      ListView(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: lstAnswers,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          })
      : const Text(
          'مبارك،، لا يوجد إجابات خاطئة',
        );
}
