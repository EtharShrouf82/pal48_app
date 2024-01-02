import 'package:flutter/material.dart';

class AddCommentProvider extends ChangeNotifier {
  bool isDataLoaded = false;

  bool isCommentSent = false;

  inSendLoading() {
    isCommentSent = true;
    notifyListeners();
  }

  commentSent() {
    isCommentSent = false;
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
