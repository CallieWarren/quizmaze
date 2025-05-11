import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                            children:[
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                                    child: SvgPicture.asset('assets/star_filled_icon.svg')
                                ),
                              ),
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                                    child: SvgPicture.asset('assets/star_outline_icon.svg')
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
                              Text(
                                "Maze complete!",
                                style: largeText,
                              ),
                              Text(
                                "${appState.bonusSwipesReceived} bonus swipes received",
                                style: largeText,
                              ),
                            ],
                          ),
                        )
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
        )
    );
  }

}