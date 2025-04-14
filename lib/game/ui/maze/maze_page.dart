import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/levelup/level_up_page.dart';

import '../common/viewmodel/game_view_model.dart';
import '../common/viewmodel/model/destination.dart';
import '../common/widgets/game_header.dart';
import '../common/widgets/navigation_button.dart';
import '../flashcard/quiz_page.dart';
import '../maze/widgets/maze_container.dart';
import 'model/direction.dart';

class MazePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mazeState = context.watch<GameViewModel>();
    Direction? movementDirection;
    final theme = Theme.of(context);
    final largeText = theme.textTheme.headlineMedium!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );

    NavigationButton navButton = NavigationButton(
      buttonText: 'Quiz',
      fromDestination: Destination.maze,
      toDestination: Destination.quiz,
      toDestinationWidget: QuizPage(),
    );

    if(mazeState.foundExit) {
      navButton = NavigationButton(
        buttonText: 'Level Up',
        fromDestination: Destination.maze,
        toDestination: Destination.levelUp,
        toDestinationWidget: LevelUpPage(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            GameHeader(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (mazeState.swipesAvailable == 0) {
                        return;
                      }
                      // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                      int sensitivity = 3;
                      if (details.delta.dx > sensitivity) {
                        // Right Swipe
                        movementDirection = Direction.right;
                      } else if (details.delta.dx < -sensitivity) {
                        //Left Swipe
                        movementDirection = Direction.left;
                      }
                    },
                    onVerticalDragUpdate: (details) {
                      if (mazeState.swipesAvailable == 0) {
                        return;
                      }
                      int sensitivity = 3;
                      if (details.delta.dy > sensitivity) {
                        // Down Swipe
                        movementDirection = Direction.down;
                      } else if (details.delta.dy < -sensitivity) {
                        // Up Swipe
                        movementDirection = Direction.up;
                      }
                    },
                    onHorizontalDragEnd: (details) {
                      if (mazeState.swipesAvailable == 0) {
                        return;
                      }
                      if (movementDirection == Direction.right) {
                        // Right Swipe
                        mazeState.move(Direction.right);
                        movementDirection = null;
                      } else if (movementDirection == Direction.left) {
                        //Left Swipe
                        mazeState.move(Direction.left);
                        movementDirection = null;
                      }
                    },
                    onVerticalDragEnd: (detail) {
                      if (mazeState.swipesAvailable == 0) {
                        return;
                      }
                      if (movementDirection == Direction.down) {
                        // Down Swipe
                        mazeState.move(Direction.down);
                        movementDirection = null;
                      } else if (movementDirection == Direction.up) {
                        // Up Swipe
                        mazeState.move(Direction.up);
                        movementDirection = null;
                      }
                    },
                    child: MazeContainer(mazeState: mazeState),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              '${mazeState.getSwipeText(mazeState.swipesAvailable)} Remaining\n${mazeState.swipesAvailable}',
                              style: largeText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  navButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

