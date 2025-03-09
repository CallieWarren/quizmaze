import 'package:flutter/cupertino.dart';

import '../model/flash_card.dart';

class QuizViewModel extends ChangeNotifier {
  var currentFlashCard = FlashCard();
  var correct = 0;
  var total = 0;

  void getNextQuestion(bool isCorrect) {
    if (isCorrect) {
      correct++;
    }
    total++;
    currentFlashCard.nextQuestion();
    notifyListeners();
  }

  void getNextSide() {
    currentFlashCard.nextSide();
    notifyListeners();
  }
}