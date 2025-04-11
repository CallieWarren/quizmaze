import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../viewmodel/game_view_model.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();
    String swipesText = 'Swipes Available\n${appState.swipesAvailable}';
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      color: Color.fromARGB(200, 46, 196, 181),
      child: Column(
        children: [
          Row(
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
                  'Items Reviewed\n${appState.total}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  appState.category,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
