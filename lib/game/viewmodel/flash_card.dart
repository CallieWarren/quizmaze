class FlashCard {
  bool isQuestionSide = true;
  int count = 1;

  void nextSide() {
    isQuestionSide = !isQuestionSide;
  }

  void nextQuestion() {
    count++;
    isQuestionSide = true;
  }

  FlashCard();
}