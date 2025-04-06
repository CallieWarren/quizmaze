import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';

import '../../maze/widgets/maze_view.dart';

class MazeContainer extends StatelessWidget {
  MazeContainer({super.key, required this.mazeState});

  final GameViewModel mazeState;

  @override
  Widget build(BuildContext context) {
    Widget backgroundWidget;
    if (mazeState.swipesAvailable == 0) {
      backgroundWidget = Image(image: AssetImage('assets/static_image.png'));
    } else {
      backgroundWidget = Container(color: Colors.transparent);
    }
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 300,
            width: 300,
            child: Stack(children: [MazeView(mazeState: mazeState), backgroundWidget,]),
          ),
        ),
      ],
    );
  }
}
