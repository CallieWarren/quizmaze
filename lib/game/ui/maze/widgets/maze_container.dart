import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';

import '../../maze/widgets/maze_view.dart';

class MazeContainer extends StatelessWidget {
  MazeContainer();

  @override
  Widget build(BuildContext context) {
    var mazeState = context.watch<GameViewModel>();
    Widget disabledBackgroundWidget = Image(image: AssetImage('assets/static_image.png'));
    Widget mazeView = MazeView(mazeState: mazeState,);
    List<Widget> children;
    if (mazeState.swipesAvailable == 0) {
      children = [mazeView, disabledBackgroundWidget];
    } else {
      children = [mazeView];
    }
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 300,
            width: 300,
            child: Stack(children: children),
          ),
        ),
      ],
    );
  }
}
