import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';

import '../../maze/widgets/maze_view.dart';


class MazeContainer extends StatelessWidget {
  MazeContainer(
      {super.key, required this.mazeState});
  final GameViewModel mazeState;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: 300,
        width: 300,
        child: MazeView(
          mazeState: mazeState,
        ),
        ),
    );
  }
}
