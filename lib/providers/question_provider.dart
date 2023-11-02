import 'package:flutter/material.dart';
import 'package:pal48/models/questions/question_cat_model.dart';
import 'package:pal48/models/questions/questions_model.dart';
import 'package:pal48/services/question_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionProvider extends ChangeNotifier {
  bool isDataLoaded = false;
  bool showResultDialog = false;

  int questionNumber = 0;
  int val = 0;
  int btnColor = 0;
  Map<int, int> numCorrect = {};

  late List userAnswer = [];
  late List wrongAnswer = [];

  List<QuestionCatModel> questionCatModel = [];
  List<QuestionModel> questionsModel = [];

  Future fetchQuestionsCat() async {
    isDataLoaded = false;
    questionCatModel = [];
    final questionService = QuestionService();
    final questionsCat = await questionService.fetchQuestionsCat();
    questionCatModel = questionsCat['data'];
    isDataLoaded = true;
    notifyListeners();
  }

  Future fetchQuestions(int id) async {
    isDataLoaded = false;
    questionsModel = [];
    final questionService = QuestionService();
    final que = await questionService.fetchQuestions(id);
    questionsModel = que['data'];
    isDataLoaded = true;
    notifyListeners();
  }

  setSelected(value) {
    val = value;
    notifyListeners();
  }

  addAnswer(dynamic question, int correctAnswer, int userSelectedAnswer) {
    if (correctAnswer == userSelectedAnswer) {
      userAnswer.add(1);
    } else {
      userAnswer.add(0);
      wrongAnswer
          .add({'question': question, 'user_answer': userSelectedAnswer});
    }
    if (questionsModel.length == questionNumber + 1) {
      showResultDialog = true;
    } else {
      questionNumber++;
    }

    val = 0;

    notifyListeners();
  }

  resetValues() {
    questionNumber = 0;
    userAnswer = [];
    wrongAnswer = [];
    notifyListeners();
  }

  Future<void> fetchCorrect(int questionId) async {
    final prefs = await SharedPreferences.getInstance();
    int? cat = prefs.getInt('qcat$questionId');
    if (cat != null) {
      numCorrect[questionId] = cat;
      isDataLoaded = true;
      notifyListeners();
    }
  }
}
