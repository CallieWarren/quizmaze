import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/viewmodel/game_view_model.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GameHeader(isMazeView: true),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
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
              Spacer(flex: 1),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          '${getSwipeText(mazeState.swipesAvailable)} Remaining\n${mazeState.swipesAvailable}',
                          style: largeText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1),
              NavigationButton(buttonText: 'Quiz', navDestination: QuizPage()),
            ],
          ),
        ),
      ),
    );
  }

  String getSwipeText(int swipesAvailable) {
    if (swipesAvailable == 1) {
      return 'Swipe';
    } else {
      return 'Swipes';
    }
  }
}
