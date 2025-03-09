import 'dart:math';


import 'package:quizmaze/game/ui/maze/model/wall.dart';

import 'maze_cell.dart';

class Maze {
  var cells = List.filled(4, List.filled(4, MazeCell()));
  var walls = [];
  final maxRowColumnCount = 4;

  void init() {
    // todo random generate walls by level logic?

    // first row walls
    walls.add(Wall(Point(1, 0), Point(2, 0)));
    walls.add(Wall(Point(3, 0), Point(3, 1)));
    // second row walls
    walls.add(Wall(Point(0, 1), Point(1, 1)));
    walls.add(Wall(Point(1, 1), Point(1, 2)));
    // third row walls
    walls.add(Wall(Point(0, 2), Point(1, 2)));
    walls.add(Wall(Point(1, 2), Point(1, 3)));
    walls.add(Wall(Point(3, 2), Point(3, 3)));
    // fourth row walls
    walls.add(Wall(Point(1, 3), Point(2, 3)));

    for(int i = 0; i < maxRowColumnCount; i++) {
      for(int j = 0; j < maxRowColumnCount; j++) {
        var currentCell = cells.elementAt(i).elementAt(j);
        if(i > 0 && !walls.contains(Wall(Point(i, j), Point(i - 1, j)))) {
          currentCell.neighbors.add(cells.elementAt(i - 1).elementAt(j));
        }
        if(i < maxRowColumnCount -1 && !walls.contains(Wall(Point(i, j), Point(i + 1, j)))) {
          currentCell.neighbors.add(cells.elementAt(i + 1).elementAt(j));
        }
        if(j > 0 && !walls.contains(Wall(Point(i, j), Point(i, j - 1)))) {
          currentCell.neighbors.add(Point(i, j - 1));
        }
        if(j < maxRowColumnCount - 1 && !walls.contains(Wall(Point(i, j), Point(i, j + 1)))) {
          currentCell.neighbors.add(Point(i, j + 1));
        }
      }
    }
  }

  Maze();
}