class QuestionCatModel {
  final int id;
  final String title;
  final int numberOfQuestions;
  QuestionCatModel({
    required this.id,
    required this.title,
    required this.numberOfQuestions,
  });
  factory QuestionCatModel.fromJson(Map<String, dynamic> json) {
    return QuestionCatModel(
      id: json['id'] as int,
      title: json['title'] as String,
      numberOfQuestions: json['question_count'] as int,
    );
  }
}
