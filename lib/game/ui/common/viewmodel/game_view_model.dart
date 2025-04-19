import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../flashcard/model/flashcard.dart';
import '../../maze/model/direction.dart';
import '../../maze/model/maze.dart';


class GameViewModel extends ChangeNotifier {
    var currentI = 0;
    var currentJ = 0;
    var maze = Maze();
    var foundExit = false;
    var correct = 0;
    var swipesAvailable = 0;
    var total = 0;
    var flashcards = List<Flashcard>.empty(growable: true);
    var currentFlashCardIndex = 0;
    String category = "";

    void setFlashcards(List<Flashcard> flashcards) {
        this.flashcards = flashcards;
    }

    void getNextQuestion(bool isCorrect) {
        if (isCorrect) {
            correct++;
            swipesAvailable++;
        }
        total++;
        currentFlashCardIndex++;
        notifyListeners();
    }

    void getNextSide() {
        flashcards[currentFlashCardIndex].nextSide();
        notifyListeners();
    }

    void updateCurrent(newI, newJ) {
        currentI = newI;
        currentJ = newJ;
        notifyListeners();
    }

    Flashcard? getCurrentFlashcard() {
        if(flashcards.isEmpty) {
            return null;
        }
        return flashcards[currentFlashCardIndex];
    }

    void move(Direction direction) {
        bool foundWall = false;
        bool isPlayerMoved = false;
        while(!foundExit && !foundWall) {
            if (maze.exitI == currentI && maze.exitJ == currentJ) {
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
                        isPlayerMoved = true;
                        break;
                    }
                case Direction.right:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallRight) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI).elementAt(currentJ + 1).visit();
                        currentJ = currentJ + 1;
                        isPlayerMoved = true;
                        break;
                    }
                case Direction.up:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallTop) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI - 1).elementAt(currentJ).visit();
                        currentI = currentI - 1;
                        isPlayerMoved = true;
                        break;
                    }
                case Direction.down:
                    if(maze.cells.elementAt(currentI).elementAt(currentJ).isWallBottom) {
                        foundWall = true;
                        break;
                    } else {
                        maze.cells.elementAt(currentI + 1).elementAt(currentJ).visit();
                        currentI = currentI + 1;
                        isPlayerMoved = true;
                        break;
                    }
            }
        }
        if(swipesAvailable > 0 && isPlayerMoved) {
            swipesAvailable--;
        }
        notifyListeners();
    }

    String getSwipeText(int swipesAvailable) {
        if (swipesAvailable == 1) {
            return 'Swipe';
        } else {
            return 'Swipes';
        }
    }

    void setBonusSwipes(int bonusSwipes) {
        swipesAvailable += bonusSwipes;
    }

    void buildNewMazeAfterLevelUp() {
        currentI = 0;
        currentJ = 0;
        maze = Maze();
        foundExit = false;
        notifyListeners();
    }

}