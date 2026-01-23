import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/tutorial/quiz_maze_intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants.dart';
import '../../common/viewmodel/game_view_model.dart';
import '../../common/viewmodel/model/destination.dart';
import '../../common/widgets/navigation_button.dart';
import '../../flashcard/quiz_page.dart';
import 'first_page.dart';
import 'input_flashcards_page.dart';

class FirstPageStateBuilder extends State<FirstPage> {

  Future<void> checkExistingFlashcards() async {
    var appState = context.read<GameViewModel>();
    final prefs = await SharedPreferences.getInstance();
    var category = prefs.getString(KEY_CATEGORY) ?? "";
    appState.setIsContinueAvailable(category.isNotEmpty);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkExistingFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();
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
                      toDestinationWidget: QuizMazeIntroPage(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if(appState.isContinueAvailable)
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