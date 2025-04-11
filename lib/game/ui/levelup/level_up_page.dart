import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/viewmodel/game_view_model.dart';
import '../common/viewmodel/model/destination.dart';
import '../common/widgets/game_header.dart';
import '../common/widgets/navigation_button.dart';
import '../maze/maze_page.dart';

class LevelUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();

    var bonusSwipes = Random().nextInt(5);
    appState.setBonusSwipes(bonusSwipes);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GameHeader(),
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                          child: Image(image: AssetImage('assets/star_shine_icon.png'))
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text(
                        "Maze complete!\n$bonusSwipes Bonus swipes received"
                      )
                    ],
                  ),
                ),
                NavigationButton(
                  buttonText: 'Next Level',
                  fromDestination: Destination.levelUp,
                  toDestination: Destination.quiz,
                  toDestinationWidget: MazePage(),
                ),
              ],
            ),
          ),
        )
    );
  }

}