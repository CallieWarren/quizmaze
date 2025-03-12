import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/viewmodel/game_view_model.dart';
import '../common/widgets/game_header.dart';
import '../maze/widgets/maze_container.dart';


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
              MazeContainer(maze: mazeState.maze, currentX: mazeState.currentX, currentY: mazeState.currentY, exit: mazeState.exit),
            ]
        )
        ),
      ),
    );
  }
}