import 'package:flutter/material.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:provider/provider.dart';

import 'components/question_card.dart';
import 'components/question_page_header.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = args['id'];
    String title = args['title'];
    return Scaffold(
      body: questionProvider.isDataLoaded
          ? questionProvider.questionsModel.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      QuestionPageHeader(
                        title: title,
                      ),
                      QuestionCard(
                        questionCatId: id,
                        questionProvider: questionProvider,
                      ),
                    ],
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('نأسف لم يتم إضافة أسئلة لهذا القسم'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('العودة للصفحة السابقة'),
                        )
                      ],
                    ),
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
    );
  }
}
