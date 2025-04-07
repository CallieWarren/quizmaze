
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/flashcard/model/flash_card.dart';
import 'package:quizmaze/game/ui/flashcard/model/flashcard.dart';

import '../../common/viewmodel/game_view_model.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/navigation_button.dart';
import '../../maze/maze_page.dart';
import '../quiz_page.dart';
import 'flash_card_view.dart';

class QuizStateBuilder extends State<QuizPage> {
  Future<String> getFlashcards() async {
    return DefaultAssetBundle.of(context).loadString("assets/mlb_flashcards.json");
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();

    return FutureBuilder<String>(
      future: getFlashcards(), // a previously-obtained Future<String> or null
      builder:
          (BuildContext context, AsyncSnapshot<String> snapshot) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    GameHeader(isMazeView: false),
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                              child: FlashcardView(
                                currentFlashCard: currentFlashCard,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(32, 16, 8, 16),
                                child: FilledButton.icon(
                                  onPressed: () {
                                    appState.getNextQuestion(false);
                                  },
                                  icon: const Icon(Icons.close),
                                  label: Text('Incorrect'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(
                                          Color.fromARGB(255, 180, 0, 0),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(8, 16, 32, 16),
                                child: FilledButton.icon(
                                  onPressed: () {
                                    appState.getNextQuestion(true);
                                  },
                                  icon: const Icon(Icons.check),
                                  label: Text('Correct'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(
                                          Color.fromARGB(200, 5, 50, 37),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 1),
                    NavigationButton(
                      buttonText: 'Maze',
                      navDestination: MazePage(),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
