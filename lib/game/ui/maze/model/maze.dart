import 'dart:math';


import 'package:quizmaze/game/ui/maze/model/wall.dart';

import 'maze_cell.dart';

class Maze {

  int startI;
  int startJ;
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
        if(j == 0 || j > 0 && isWallLeft(i, j)) {
          // left
          currentCell.isWallLeft = true;
        }
        if(j == maxRowColumnCount - 1 || j < (maxRowColumnCount -1) && isWallRight(i, j)) {
          // right
          currentCell.isWallRight = true;
        }
        if(i == 0 || i > 0 && isWallTop(i, j)) {
          // top
          currentCell.isWallTop = true;
        }
        if(i == maxRowColumnCount - 1 || i < maxRowColumnCount - 1 && isWallBottom(i, j)) {
          // bottom
          currentCell.isWallBottom = true;
        }
        row.add(currentCell);
      }
      cells.add(row);
    }

    for(int i = 0; i < maxRowColumnCount; i++) {
      for(int j = 0; j < maxRowColumnCount; j++) {
        var currentCell = cells.elementAt(i).elementAt(j);
        if(j > 0 && !isWallLeft(i, j)) {
          // left
          currentCell.addNeighbor(cells.elementAt(i).elementAt(j-1));
        }
        if(j < (maxRowColumnCount -1) && !isWallRight(i, j)) {
          // right
          currentCell.addNeighbor(cells.elementAt(i).elementAt(j+1));
        }
        if(i > 0 && !isWallTop(i, j)) {
          currentCell.addNeighbor(cells.elementAt(i-1).elementAt(j));
        }
        if(i < maxRowColumnCount - 1 && !isWallBottom(i, j)) {
          currentCell.addNeighbor(cells.elementAt(i+1).elementAt(j));
        }
      }
    }
  }


  bool isWallLeft(int i, int j) {
    return walls.any((wall) => wall.i2 == i && wall.j2 == j
        && wall.i1 == i && wall.j1 == j-1);
  }

  bool isWallRight(int i, int j) {
    return walls.any((wall) => wall.i1 == i && wall.j1 == j
        && wall.i2 == i && wall.j2 == j+1);
  }

  bool isWallTop(int i, int j) {
    return walls.any((wall) => wall.i2 == i && wall.j2 == j && wall.i1 == i-1 && wall.j1 == j);
  }

  bool isWallBottom(int i, int j) {
    return walls.any((wall) => wall.i1 == i && wall.j1 == j && wall.i2 == i+1 && wall.j1 == j);
  }


  Maze({
    required this.startI,
    required this.startJ
  }) {
    init();
    cells.elementAt(startI).elementAt(startJ).visit();
  }
}