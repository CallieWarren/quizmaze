import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/viewmodel/game_view_model.dart';
import '../common/widgets/game_header.dart';
import '../maze/widgets/maze_container.dart';
import 'model/direction.dart';


class MazePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var mazeState = context.watch<GameViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(child: Column(
            children: [
              GameHeader(isMazeView: true),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                  int sensitivity = 4;
                  if (details.delta.dx > sensitivity) {
                    // Right Swipe
                    mazeState.move(Direction.right);
                  } else if (details.delta.dx < -sensitivity) {
                    //Left Swipe
                    mazeState.move(Direction.left);
                  }
                },
                onVerticalDragUpdate: (details) {
                  int sensitivity = 4;
                  if (details.delta.dy > sensitivity) {
                    // Down Swipe
                    mazeState.move(Direction.down);
                  } else if (details.delta.dy < -sensitivity) {
                    // Up Swipe
                    mazeState.move(Direction.up);
                  }
                },
                child: MazeContainer(maze: mazeState.maze,
                    currentI: mazeState.currentI,
                    currentJ: mazeState.currentJ,
                    exitI: mazeState.exitI,
                    exitJ: mazeState.exitJ),
              ),
            ]
        )
        ),
      ),
    );
  }
}