import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizmaze/game/ui/maze/model/maze.dart';

import '../../maze/widgets/maze_view.dart';


class MazeContainer extends StatelessWidget {
  const MazeContainer(
      {super.key, required this.maze, required this.currentI, required this.currentJ, required this.exitI, required this.exitJ});
  final Maze maze;
  final int currentI;
  final int currentJ;
  final int exitI;
  final int exitJ;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: 300,
        width: 300,
        child: MazeView(maze: maze, currentI: currentI, currentJ: currentJ, exitI: exitI, exitJ: exitJ),
        ),
    );
  }
}
