import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/common/viewmodel/game_view_model.dart';

import '../model/flash_card.dart';

class FlashcardView extends StatelessWidget {
  const FlashcardView({super.key, required this.currentFlashCard});

  final FlashCard currentFlashCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final flashcardStyle = theme.textTheme.displayMedium!.copyWith(
      color: Color.fromARGB(255, 47, 48, 44),
    );
    var appState = context.watch<GameViewModel>();

    String flashCardText;
    if (currentFlashCard.isQuestionSide) {
      flashCardText = "Question ${currentFlashCard.count}";
    } else {
      flashCardText = "Answer ${currentFlashCard.count}";
    }

    return SizedBox(
      height: double.infinity,
      child: Card(
        color: Color.fromARGB(255, 255, 255, 230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Color.fromARGB(255, 7, 7, 7), // Black border color
            width: 1.0, // Border width
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            appState.getNextSide();
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                flashCardText,
                style: flashcardStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
