import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';
import 'package:quizmaze/game/ui/first_screen/widgets/input_flashcards_page.dart';

import 'game/ui/first_screen/widgets/first_page.dart';

void main() {
  runApp(QuizMaze());
}


class QuizMaze extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
        home: InputFlashcardsPage(),
      ),
    );
  }
}
