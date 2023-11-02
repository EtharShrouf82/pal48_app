import 'package:flutter/material.dart';

class AddCommentProvider extends ChangeNotifier {
  bool isDataLoaded = false;

  bool isCommentSent = false;

  changeLoadingStatus() {
    isCommentSent = !isCommentSent;
    notifyListeners();
  }

  emptyField() {
    name.text = '';
    email.text = '';
    message.text = '';
    notifyListeners();
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController message = TextEditingController();
}
