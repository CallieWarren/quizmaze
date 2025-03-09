import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../viewmodel/game_view_model.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key, required this.isMazeView});

  final bool isMazeView;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();
    String swipesText;
    if (isMazeView) {
      swipesText = 'Swipes Remaining :\n${appState.correct}';
    } else {
      swipesText = 'Swipes Earned :\n${appState.correct}';
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      color: Color.fromARGB(200, 46, 196, 181),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              swipesText,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Text(
              'Items Reviewed :\n${appState.total}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}