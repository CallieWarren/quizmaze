import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/viewmodel/game_view_model.dart';
import '../../common/viewmodel/model/destination.dart';
import '../../common/widgets/game_header.dart';
import '../../common/widgets/navigation_button.dart';
import '../../flashcard/quiz_page.dart';

class SettingsPage extends StatelessWidget {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GameHeader(),
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
                      child: Expanded(
                        child: Text(
                          "Correct flashcards are removed ",
                          style: largeText,
                        ),
                      ),
                    ),
                  ),
                  Switch(
                    value: appState.isCorrectFlashcardsRemoved,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      appState.toggleIsCorrectFlashcardsRemoved();
                    },
                  ),
                ],
              ),
              Expanded(child: Row(children: [Expanded(child: Spacer())])),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
