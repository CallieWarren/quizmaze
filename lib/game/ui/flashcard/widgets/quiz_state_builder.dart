
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/viewmodel/game_view_model.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/navigation_button.dart';
import '../../maze/maze_page.dart';
import '../model/flashcard.dart';
import '../quiz_page.dart';
import 'flash_card_view.dart';

class QuizStateBuilder extends State<QuizPage> {
  var flashcards = List<Flashcard>.empty(growable: true);

  Future<void> getFlashcards() async {
    var jsonText = await DefaultAssetBundle.of(context).loadString("assets/mlb_flashcards.json");
    var parsed = await json.decode(jsonText);
    flashcards = (parsed['Flashcards'] as List)
        .map((e) => Flashcard.fromJson(e))
        .toList();
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      getFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();
    appState.flashcards = flashcards;

    return Scaffold(
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
                                currentFlashCard: appState.getCurrentFlashcard(),
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
            )
    );
  }
}
