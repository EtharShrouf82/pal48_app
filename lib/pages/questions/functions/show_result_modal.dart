import 'package:flutter/material.dart';
import 'package:pal48/components/custom_modal_bottom_sheet.dart';
import 'package:pal48/pages/questions/functions/save_result.dart';
import 'package:pal48/pages/questions/functions/user_answer_correction.dart';
import 'package:pal48/providers/question_provider.dart';

showResultModal(
  BuildContext context,
  QuestionProvider questionProvider,
  int questionCatId,
) {
  return customModalBottomSheet(
    context,
    isDismissible: false,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const Text('لقد إنتهت الأسئلة'),
          ListBody(
            children: <Widget>[
              Text(
                  'عدد الإجابات الصحيحة ( ${questionProvider.userAnswer.where((c) => c == 1).length.toString()} )'),
              Text(
                  'عدد الإجابات الخاطئة ( ${questionProvider.userAnswer.where((c) => c == 0).length.toString()} )'),
            ],
          ),
          TextButton(
            onPressed: () {
              saveResult(
                questionCatId,
                questionProvider.userAnswer.where((c) => c == 1).length,
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('الرجوع للصفحة السابقة'),
          ),
          questionProvider.wrongAnswer.isNotEmpty
              ? TextButton(
                  child: const Text(
                    'إعادة الإمتحان',
                  ),
                  onPressed: () {
                    saveResult(
                      questionCatId,
                      questionProvider.userAnswer.where((c) => c == 1).length,
                    );
                    questionProvider.resetValues();
                    Navigator.of(context).pop();
                  },
                )
              : const Text('تهانينا، جميع الإجابات صحيحة'),
          userAnswerCorrection(questionProvider, context)
        ],
      ),
    ),
  );
}
