import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/game_mode.dart';
import '../../common/viewmodel/game_view_model.dart';
import '../../common/viewmodel/model/destination.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/navigation_button.dart';
import '../../maze/maze_page.dart';
import '../../stack_complete_page.dart';
import '../model/flashcard.dart';
import '../quiz_page.dart';
import 'flash_card_view.dart';

class QuizStateBuilder extends State<QuizPage> {

  Future<void> loadFlashcards() async {
    var appState = context.read<GameViewModel>();
    String jsonText = "";
    if (appState.gameMode == GameMode.newGame) {
      jsonText = appState.jsonText;
      var parsed = await json.decode(jsonText);
      var flashcards =
      (parsed[KEY_FLASHCARDS] as List)
          .map((e) => Flashcard.fromJson(e))
          .toList();
      var category = parsed[KEY_CATEGORY];
      appState.setFlashcards(flashcards, category);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(KEY_FLASHCARDS, jsonText);
      prefs.setString(KEY_CATEGORY, category);
      appState.setIsContinueAvailable(true);
    } else if (appState.gameMode == GameMode.demo) {
      jsonText = await DefaultAssetBundle.of(
        context,
      ).loadString("assets/mlb_flashcards.json");
      var parsed = await json.decode(jsonText);
      var flashcards =
      (parsed[KEY_FLASHCARDS] as List)
          .map((e) => Flashcard.fromJson(e))
          .toList();
      var category = parsed[KEY_CATEGORY];
      appState.setFlashcards(flashcards, category);
    } else if (appState.gameMode == GameMode.continueGame)  {
      final prefs = await SharedPreferences.getInstance();
      var parsed = await json.decode(prefs.getString(KEY_FLASHCARDS) ?? "");
      if(parsed.isNotEmpty) {
        var flashcards =
        (parsed[KEY_FLASHCARDS] as List)
            .map((e) => Flashcard.fromJson(e))
            .toList();
        var category = prefs.getString(KEY_CATEGORY) ?? "";
        appState.setFlashcards(flashcards, category);
      }
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();
    if (appState.flashcards.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
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
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: FlashcardView(),
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
                              bool isAllCorrect = appState.getNextQuestion(
                                false,
                              );
                              if (isAllCorrect) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StackCompletePage(),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.close),
                            label: Text('Incorrect'),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
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
                              bool isAllCorrect = appState.getNextQuestion(
                                true,
                              );
                              if (isAllCorrect) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StackCompletePage(),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.check),
                            label: Text('Correct'),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
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
              NavigationButton(
                buttonText: 'Maze',
                fromDestination: Destination.quiz,
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
