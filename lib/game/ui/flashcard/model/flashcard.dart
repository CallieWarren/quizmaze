class Flashcard{
  final String question;
  final String answer;

  Flashcard(this.question, this.answer);
  bool isQuestionSide = true;

  void nextSide() {
    isQuestionSide = !isQuestionSide;
  }

  Flashcard.fromJson(Map<String, dynamic> json):
        question = json['Question'] as String,
        answer = json['Answer'] as String;

  Map<String, dynamic> toJson() => {'Question': question, 'Answer': answer};
}