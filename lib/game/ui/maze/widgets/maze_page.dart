import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/game_header.dart';
import '../../flashcard/viewmodel/quiz_view_model.dart';

class MazePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<QuizViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(child: Column(
            children: [
              GameHeader(isMazeView: true)
            ]
        )
        ),
      ),
    );
  }
}