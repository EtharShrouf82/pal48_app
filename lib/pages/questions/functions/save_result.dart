import 'package:shared_preferences/shared_preferences.dart';

saveResult(int catId, int correctAnswers) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('qcat$catId', correctAnswers);
}
