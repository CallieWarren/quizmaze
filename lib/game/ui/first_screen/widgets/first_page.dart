import 'package:flutter/material.dart';
import 'package:quizmaze/game/ui/first_screen/widgets/input_flashcards_page.dart';

import '../../common/viewmodel/model/destination.dart';
import '../../common/widgets/navigation_button.dart';
import '../../flashcard/quiz_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediumHeadline = theme.textTheme.headlineMedium!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(child: Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        "Welcome to QuizMaze!",
                        style: mediumHeadline,
                      ),
                    ),
                  ))
                ],
              ),
              Expanded(child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Image(
                        image: AssetImage(
                          'assets/success_icon.png',
                        ),
                      ),
                    ),
                  ),
                ],
              )
              ),
              Row(
                children: [
                  Expanded(
                    child: NavigationButton(
                      buttonText: "Demo Mode",
                      fromDestination: Destination.firstPage,
                      toDestination: Destination.quiz,
                      toDestinationWidget: QuizPage(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: NavigationButton(
                      buttonText: "Continue Quiz",
                      fromDestination: Destination.firstPage,
                      toDestination: Destination.quiz,
                      toDestinationWidget: QuizPage(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: NavigationButton(
                      buttonText: "Change Flashcards",
                      fromDestination: Destination.firstPage,
                      toDestination: Destination.inputFlashcards,
                      toDestinationWidget: InputFlashcardsPage(),
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
