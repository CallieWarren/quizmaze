import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/viewmodel/game_view_model.dart';
import '../../common/viewmodel/model/destination.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/navigation_button.dart';
import '../../flashcard/quiz_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    var appState = Provider.of<GameViewModel>(context, listen: false);
    _controller = TextEditingController(text: appState.answersRequiredForSwipe.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();

    final theme = Theme.of(context);
    final largeText = theme.textTheme.bodyLarge!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            GameHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: InkWell(
                              onTap: () {
                                appState.resetFlashcards();
                              },
                              child: Text("Reset flashcard stack", style: largeText),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: InkWell(
                              onTap: () {
                                appState.shuffleFlashcards();
                              },
                              child: Text("Shuffle order", style: largeText),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: InkWell(
                              onTap: () {
                                appState.toggleIsCorrectFlashcardsRemoved();
                              },
                              child: Text(
                                "Correct flashcards are removed ",
                                style: largeText,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Switch(
                            value: appState.isCorrectFlashcardsRemoved,
                            onChanged: (bool value) {
                              appState.toggleIsCorrectFlashcardsRemoved();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: InkWell(
                              onTap: () {
                                appState.toggleBonusSwipesEnabled();
                              },
                              child: Text(
                                "Bonus swipes enabled",
                                style: largeText,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Switch(
                            value: appState.bonusSwipesEnabled,
                            onChanged: (bool value) {
                              appState.toggleBonusSwipesEnabled();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Text(
                              "Answers required for a swipe",
                              style: largeText,
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              int? intValue = int.tryParse(value);
                              if (intValue != null && intValue > 0) {
                                appState.setAnswersRequiredForSwipe(intValue);
                              }
                            },
                            onTap: () {
                              _controller.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: _controller.value.text.length,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: NavigationButton(
                      buttonText: "Done",
                      fromDestination: Destination.settings,
                      toDestination: Destination.quiz,
                      toDestinationWidget: QuizPage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
