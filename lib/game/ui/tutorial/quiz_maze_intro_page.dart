import 'package:flutter/material.dart';

import '../common/viewmodel/model/destination.dart';
import '../common/widgets/navigation_button.dart';
import '../flashcard/quiz_page.dart';

class QuizMazeIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediumHeadline = theme.textTheme.headlineMedium!.copyWith(
      color: const Color.fromARGB(255, 47, 48, 44),
    );

    const line1 = "You are about to begin Quiz Mode. Quiz Mode is a digital stack of flashcards. You can tap on the vocabulary word flashcard to reveal the answer.";
    const line2 = "With each correct answer, you earn swipes. Swipes can be redeemed in Maze Mode.";
    const line3 = "Maze Mode can be accessed at the bottom of the screen in Quiz Mode.";
    const line4 = "In Maze Mode, swipe on the maze to reveal walls and paths within the maze.";
    const line5 = "If a fork in the road icon is displayed, you can click on it to revisit that square and try a new direction.";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Quiz Mode and Maze Mode", style: mediumHeadline),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: const Text(
                line1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                line2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: const Text(
                line3,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: const Text(
                line4,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: const Text(
                line5,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Image.asset(
                  'assets/fork_icon.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            // Button
            NavigationButton(
              buttonText: 'Try it',
              fromDestination: Destination.introPage2,
              toDestination: Destination.quiz,
              toDestinationWidget: QuizPage(),
            ),
          ],
        ),
      ),
    );
  }
}
