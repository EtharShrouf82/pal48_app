import 'package:pal48/models/questions/answer_model.dart';

class QuestionModel {
  final int id, correctAnswer;
  final String question;
  final String? hint;
  final String? img;
  final List<AnswersModel> answers;
  QuestionModel({
    required this.id,
    required this.correctAnswer,
    required this.question,
    this.hint,
    required this.answers,
    this.img,
  });
  factory QuestionModel.fromJson(Map<String, dynamic> jsonRes) {
    List<AnswersModel> lsAnswers = List<AnswersModel>.from(
      jsonRes['answers'].map(
        (model) => AnswersModel.fromJson(model),
      ),
    );
    return QuestionModel(
      id: jsonRes['id'] as int,
      correctAnswer: jsonRes['correct_answer'] as int,
      question: jsonRes['question'] as String,
      hint: jsonRes['hint'] as String?,
      img: jsonRes['img'] as String?,
      answers: lsAnswers,
    );
  }
}
