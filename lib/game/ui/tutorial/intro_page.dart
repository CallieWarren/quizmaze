import 'package:flutter/material.dart';

import '../common/viewmodel/model/destination.dart';
import '../common/widgets/navigation_button.dart';
import '../first_screen/widgets/first_page.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediumHeadline = theme.textTheme.headlineMedium!.copyWith(
      color: const Color.fromARGB(255, 47, 48, 44),
    );

    const line1 =
        "Thank you for taking the time to give feedback about the app.";
    const line2 =
        "In the following screen, you can choose whether you'd like to learn your own material or play in Demo Mode";
    const line3 =
        "I would recommend starting in Demo Mode, which is pre-populated with UFC Flashcards.";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Welcome to QuizMaze!", style: mediumHeadline),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Image.asset(
                  'assets/success_icon.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
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

            // Button
            NavigationButton(
              buttonText: 'Let\'s Go!',
              fromDestination: Destination.introPage,
              toDestination: Destination.firstPage,
              toDestinationWidget: FirstPage(),
            ),
          ],
        ),
      ),
    );
  }
}
