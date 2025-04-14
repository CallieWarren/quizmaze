import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:quizmaze/game/ui/maze/model/wall.dart';

import 'maze_cell.dart';

class Maze {

  int startI = 0;
  int startJ = 0;
  var cells = List<List<MazeCell>>.empty(growable: true);
  var allWalls = List<Wall>.empty(growable: true);
  var mazeWalls = List<Wall>.empty(growable: true);
  final maxRowColumnCount = 4;

  void init() {
    // add every wall
    for(int i = 0; i < maxRowColumnCount; i++) {
      for(int j = 0; j < maxRowColumnCount; j++) {
        if(j < maxRowColumnCount - 1) {
          allWalls.add(Wall(i, j, i, j+1));
        }
        if(i < maxRowColumnCount - 1) {
          allWalls.add(Wall(i, j, i +1, j));
        }
      }
    }

    var currentI = startI;
    var currentJ = startJ;
    do {
      MazeCell currentCell = cells[currentI][currentJ];
      currentCell.isVisited = true;
      // add right and bottom wall to maze list
      mazeWalls.addAll(allWalls.takeWhile((wall) => (wall.i1 == currentI && wall.j1 == currentJ
          && wall.i2 == currentI && wall.j2 == currentJ+1) ||
          wall.i1 == currentI && wall.j1 == currentJ && wall.i2 == currentI + 1 && wall.j2 == currentJ) );
      bool isRemoveWall = false;
      while(!isRemoveWall) {
        var removeWallIndex = Random().nextInt(mazeWalls.length);
        if() {
          removeWall = true;
        }

      }
    } while(mazeWalls.isNotEmpty);


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