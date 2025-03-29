import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../flashcard/model/flash_card.dart';
import '../../maze/model/direction.dart';
import '../../maze/model/maze.dart';
import '../../maze/model/maze_cell.dart';


class GameViewModel extends ChangeNotifier {
    var maze = Maze();
    var currentI = 0;
    var currentJ = 0;
    var exitI = 3;
    var exitJ = 3;

    var currentFlashCard = FlashCard();
    var correct = 0;
    var total = 0;

    void getNextQuestion(bool isCorrect) {
        if (isCorrect) {
            correct++;
        }
        total++;
        currentFlashCard.nextQuestion();
        notifyListeners();
    }

    void getNextSide() {
        currentFlashCard.nextSide();
        notifyListeners();
    }

    void move(Direction direction) {
        bool foundExit = false;
        bool foundWall = false;
        while(!foundExit && !foundWall) {
            if (exitI == currentI && exitJ == currentJ) {
                foundExit = true;
                break;
            }
            switch(direction) {
                case Direction.left:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallLeft) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI).elementAt(currentJ - 1).visit();
                        currentJ = currentJ -1;
                        break;
                    }
                case Direction.right:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallRight) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI).elementAt(currentJ + 1).visit();
                        currentJ = currentJ + 1;
                        break;
                    }
                case Direction.up:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallTop) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI - 1).elementAt(currentJ).visit();
                        currentI = currentI - 1;
                        break;
                    }
                case Direction.down:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallBottom) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI + 1).elementAt(currentJ).visit();
                        currentI = currentI + 1;
                        break;
                    }
            }
        }
        notifyListeners();
    }
}