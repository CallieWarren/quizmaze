import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/viewmodel/flash_card.dart';

void main() {
  runApp(QuizMaze());
}

class QuizMaze extends StatelessWidget {
  const QuizMaze({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizMazeState(),
      child: MaterialApp(
        title: 'Quiz Maze',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 38, 06, 13),
            secondary: Color.fromARGB(255, 47, 48, 44),
          ),
        ),
        home: QuizPage(),
      ),
    );
  }
}

class QuizMazeState extends ChangeNotifier {
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

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<QuizMazeState>();
    var currentFlashCard = appState.currentFlashCard;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                color: Color.fromARGB(200, 46, 196, 181),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Swipes Earned :\n${appState.correct}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Items Reviewed :\n${appState.total}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: FlashcardView(
                          currentFlashCard: currentFlashCard,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(32, 16, 0, 16),
                          child: FilledButton.icon(
                            onPressed: () {
                              appState.getNextQuestion(false);
                            },
                            icon: const Icon(Icons.close),
                            label: Text('Incorrect'),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Color.fromARGB(255, 180, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 32, 16),
                          child: FilledButton.icon(
                            onPressed: () {
                              appState.getNextQuestion(true);
                            },
                            icon: const Icon(Icons.check),
                            label: Text('Correct'),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Color.fromARGB(200, 5, 50, 37),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 64,
                      margin: EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () {
                          //todo
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Color.fromARGB(255, 255, 170, 90),
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                        ),
                        child: Text(
                          'Maze',
                          style: TextStyle(
                            color: Color.fromARGB(255, 47, 48, 44),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlashcardView extends StatelessWidget {
  const FlashcardView({super.key, required this.currentFlashCard});

  final FlashCard currentFlashCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final flashcardStyle = theme.textTheme.displayMedium!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );
    var appState = context.watch<QuizMazeState>();

    String flashCardText;
    if (currentFlashCard.isQuestionSide) {
      flashCardText = "Question ${currentFlashCard.count}";
    } else {
      flashCardText = "Answer ${currentFlashCard.count}";
    }

    return SizedBox(
      height: double.infinity,
      child: Card(
        color: Color.fromARGB(255, 255, 255, 230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Color.fromARGB(255, 7, 7, 7), // Black border color
            width: 1.0, // Border width
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            appState.getNextSide();
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                flashCardText,
                style: flashcardStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
