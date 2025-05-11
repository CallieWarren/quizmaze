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

    final theme = Theme.of(context);
    final largeText = theme.textTheme.headlineMedium!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );

    var bonusSwipesText = "";
    if (appState.bonusSwipesEnabled) {
      var swipesText = "swipes";
      if(appState.bonusSwipesReceived == 1) {
        swipesText = "swipe";
      }
      bonusSwipesText = "${appState.bonusSwipesReceived} bonus $swipesText received";
    }

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(200, 46, 196, 181),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 8.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/success_icon.png',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Image(
                                        image: AssetImage(
                                          'assets/treasure_open_icon.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("Maze complete!", style: largeText),
                            Text(bonusSwipesText, style: largeText),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NavigationButton(
                buttonText: 'Next Level',
                fromDestination: Destination.levelUp,
                toDestination: Destination.maze,
                toDestinationWidget: MazePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
