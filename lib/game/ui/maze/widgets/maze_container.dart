import 'package:flutter/material.dart';
import 'package:quizmaze/game/ui/maze/model/maze.dart';

import '../../maze/widgets/maze_view.dart';


class MazeContainer extends StatelessWidget {
  const MazeContainer({super.key, required this.maze});
  final Maze maze;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: 300,
        width: 300,
        child: MazeView(maze: maze),
        ),
    );
  }
}
