import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/direction.dart';
import '../model/maze.dart';


class MazeViewModel extends ChangeNotifier {
    var maze = Maze();
    var currentX = 0;
    var currentY = 0;
    var exit = Point(3, 3);

    void initMaze() {
        maze.init();
        notifyListeners();
    }


    void move(Direction direction) {
        bool foundExit = false;
        bool foundWall = false;
        while(!foundExit && !foundWall) {
            if (exit.x == currentX && exit.y == currentY) {
                foundExit = true;
                break;
            }
            switch(direction) {
                case Direction.left:
                    if(currentX == 0) {
                        foundWall = true;
                        break;
                    }
                    if(maze.cells.elementAt(currentX).elementAt(currentY).neighbors.contains((element) => (element as Point).x == currentX - 1)) {
                        maze.cells.elementAt(currentX - 1).elementAt(currentY).visit();
                        currentX = currentX - 1;
                        break;
                    } else {
                        foundWall = true;
                    }
                case Direction.right:
                    if(currentX == maze.maxRowColumnCount) {
                        foundWall = true;
                        break;
                    }
                    if(maze.cells.elementAt(currentX).elementAt(currentY).neighbors.contains((element) => (element as Point).x == currentX + 1)) {
                        maze.cells.elementAt(currentX + 1).elementAt(currentY).visit();
                        currentX = currentX + 1;
                        break;
                    } else {
                        foundWall = true;
                        break;
                    }
                case Direction.up:
                    if(currentY == 0) {
                        foundWall = true;
                        break;
                    }
                    if(maze.cells.elementAt(currentX).elementAt(currentY).neighbors.contains((element) => (element as Point).y == currentY - 1)) {
                        maze.cells.elementAt(currentY - 1).elementAt(currentY).visit();
                        currentY = currentY - 1;
                        break;
                    } else {
                        foundWall = true;
                    }
                case Direction.down:
                    if(currentY == maze.maxRowColumnCount) {
                        foundWall = true;
                        break;
                    }
                    if(maze.cells.elementAt(currentX).elementAt(currentY).neighbors.contains((element) => (element as Point).y == currentY + 1)) {
                        maze.cells.elementAt(currentX).elementAt(currentY + 1).visit();
                        currentY = currentY + 1;
                        break;
                    } else {
                        foundWall = true;
                        break;
                    }
            }
        }
        notifyListeners();
    }
}