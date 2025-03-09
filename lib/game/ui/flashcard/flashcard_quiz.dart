import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/flashcard/quiz_page.dart';
import 'package:quizmaze/game/ui/flashcard/viewmodel/quiz_view_model.dart';


void main() {
  runApp(QuizMaze());
}

class QuizMaze extends StatelessWidget {
  const QuizMaze({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizViewModel(),
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
