import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';
import 'package:quizmaze/game/ui/flashcard/quiz_page.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';

import 'game/ui/maze/maze_page.dart';


void main() {
  runApp(MazeOnly());
}

class MazeOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: MaterialApp(
        title: 'Quiz Maze',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 38, 06, 13),
            secondary: Color.fromARGB(255, 47, 48, 44),
          ),
        ),
        home: MazePage(),
      ),
    );
  }
}


class QuizMaze extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
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
