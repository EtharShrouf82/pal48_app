class AnswersModel {
  final int id;
  final String answer;
  AnswersModel({
    required this.id,
    required this.answer,
  });
  factory AnswersModel.fromJson(Map<String, dynamic> jsonRes) {
    return AnswersModel(
      id: jsonRes['id'] as int,
      answer: jsonRes['answer'] as String,
    );
  }
}
