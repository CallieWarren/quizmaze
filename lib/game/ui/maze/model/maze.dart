import 'dart:math';


import 'package:quizmaze/game/ui/maze/model/wall.dart';

import 'maze_cell.dart';

class Maze {
  var cells = List<List<MazeCell>>.empty(growable: true);
  var walls = List<Wall>.empty(growable: true);
  final maxRowColumnCount = 4;

  void init() {
    // todo random generate walls by level logic?

    // first row walls
    walls.add(Wall(0, 1, 0, 2));
    walls.add(Wall(0, 3, 1, 3));
    // second row walls
    walls.add(Wall(1, 0, 1, 1));
    walls.add(Wall(1, 1, 1, 2));
    // // third row walls
    walls.add(Wall(2, 0, 2, 1));
    walls.add(Wall(2, 1, 3, 1));
    walls.add(Wall(2, 2, 2, 3));
    walls.add(Wall(2, 2, 3, 2));
    // // fourth row walls
    walls.add(Wall(3, 1, 3, 2));

    for(int i = 0; i < maxRowColumnCount; i++) {
      var row = List<MazeCell>.empty(growable: true);
      for(int j = 0; j < maxRowColumnCount; j++) {
        var currentCell = MazeCell();
        // if(j > 0 && isWallLeft(i, j)) {
        //   // left
        //   currentCell.isWallLeft = true;
        // } else {
        //   // currentCell.neighbors.add(cells.elementAt(i - 1).elementAt(j));
        // }
        if(j < (maxRowColumnCount -1) && isWallRight(i, j)) {
          // right
          currentCell.isWallRight = true;
        } else {
          // currentCell.neighbors.add(cells.elementAt(i + 1).elementAt(j));
        }
        // if(j > 0 && !walls.contains(Wall(Point(i, j), Point(i, j - 1)))) {
        //   // top
        //   currentCell.neighbors.add(Point(i, j - 1));
        // } else {
        //   currentCell.isWallTop = true;
        // }
        if(i < maxRowColumnCount - 1 && isWallBottom(i, j)) {
          currentCell.isWallBottom = true;
          // currentCell.neighbors.add(Point(i, j + 1));
        } else {
        }
        row.add(currentCell);
      }
      cells.add(row);
    }
  }

  // bool isWallLeft(int i, int j) {
  //   return walls.any((wall) => wall.i1 == i && wall.lowerIndexCell.x == j
  //       && wall.higherIndexCell.x == i && wall.higherIndexCell.y == j-1);
  // }

  bool isWallRight(int i, int j) {
    return walls.any((wall) => wall.i1 == i && wall.j1 == j
        && wall.i2 == i && wall.j2 == j+1);
  }

  bool isWallBottom(int i, int j) {
    return walls.any((wall) => wall.i1 == i && wall.j1 == j && wall.i2 == i+1 && wall.j1 == j);
  }


  Maze(){
    init();
  }
}