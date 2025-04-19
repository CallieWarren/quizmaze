import 'dart:math';

import 'package:quizmaze/game/ui/maze/model/wall.dart';

import 'maze_cell.dart';

class Maze {

  final maxRowColumnCount = 4;
  int startI = 0;
  int startJ = 0;
  int exitI = 3;
  int exitJ = 3;
  var cells = List<List<MazeCell>>.empty(growable: true);
  var allWalls = List<Wall>.empty(growable: true);
  var wallsForVisitedCells = List<Wall>.empty(growable: true);

  void init() {
    // add every wall
    for (int i = 0; i < maxRowColumnCount; i++) {
      for (int j = 0; j < maxRowColumnCount; j++) {
        if (j < maxRowColumnCount - 1) {
          allWalls.add(Wall(i, j, i, j + 1));
        }
        if (i < maxRowColumnCount - 1) {
          allWalls.add(Wall(i, j, i + 1, j));
        }
      }
    }

    for (int i = 0; i < maxRowColumnCount; i++) {
      var row = List<MazeCell>.empty(growable: true);
      for (int j = 0; j < maxRowColumnCount; j++) {
        var currentCell = MazeCell();
        row.add(currentCell);
      }
      cells.add(row);
    }


    wallsForVisitedCells.addAll(allWalls.where((wall) => (wall.i1 == startI && wall.j1 == startJ)));
    cells[startI][startJ].isVisitedForGenerate = true;
    allWalls.removeWhere((wall) =>
    wall.i1 == startI &&
        wall.j1 == startJ);
    int cellsVisitedCount = 1;
    while (cellsVisitedCount < maxRowColumnCount * maxRowColumnCount) {
      // add right and bottom wall to maze list
      bool isWallRemoved = false;
      while (!isWallRemoved) {
        var removeWallIndex = Random().nextInt(wallsForVisitedCells.length);
        var removeWallCandidate = wallsForVisitedCells[removeWallIndex];
        MazeCell visitCellCandidate = cells[removeWallCandidate
            .i2][removeWallCandidate.j2];
        if (!visitCellCandidate.isVisitedForGenerate) {
          isWallRemoved = true;
          wallsForVisitedCells.removeAt(removeWallIndex);
          cells[removeWallCandidate.i2][removeWallCandidate.j2].isVisitedForGenerate = true;
          wallsForVisitedCells.addAll(
              allWalls.where((wall) =>
              (wall.i1 == removeWallCandidate.i2 && wall.j1 == removeWallCandidate.j2))
          );
          allWalls.removeWhere((wall) =>
          (wall.i1 == removeWallCandidate.i2 && wall.j1 == removeWallCandidate.j2));
          cellsVisitedCount++;
        }
      }
    }

    for (int i = 0; i < maxRowColumnCount; i++) {
      for (int j = 0; j < maxRowColumnCount; j++) {
        if (j == 0 || j > 0 && isWallLeft(i, j, wallsForVisitedCells)) {
          // add left wall
          cells[i][j].isWallLeft = true;
        } else if (j < 0) {
          // add left neighbor
          cells[i][j].addNeighbor(cells[i][j - 1]);
        }
        if (j == maxRowColumnCount - 1 || j < (maxRowColumnCount - 1) &&
            isWallRight(i, j, wallsForVisitedCells)) {
          // right
          cells[i][j].isWallRight = true;
        } else if (j < maxRowColumnCount - 1) {
          cells[i][j].addNeighbor(cells[i][j + 1]);
        }
        if (i == 0 || i > 0 && isWallTop(i, j, wallsForVisitedCells)) {
          // top
          cells[i][j].isWallTop = true;
        } else if (i > 0) {
          cells[i][j].addNeighbor(cells.elementAt(i - 1).elementAt(j));
        }
        if (i == maxRowColumnCount - 1 || i < maxRowColumnCount - 1 &&
            isWallBottom(i, j, wallsForVisitedCells)) {
          // bottom
          cells[i][j].isWallBottom = true;
        } else if (i < maxRowColumnCount - 1) {
          cells[i][j].addNeighbor(cells.elementAt(i + 1).elementAt(j));
        }
      }
    }
  }
  bool isWallLeft(int i, int j, List<Wall> walls) {
    return walls.any((wall) => wall.i2 == i && wall.j2 == j
        && wall.i1 == i && wall.j1 == j-1);
  }

  bool isWallRight(int i, int j, List<Wall> walls) {
    return walls.any((wall) => wall.i1 == i && wall.j1 == j
        && wall.i2 == i && wall.j2 == j+1);
  }

  bool isWallTop(int i, int j, List<Wall> walls) {
    return walls.any((wall) => wall.i2 == i && wall.j2 == j && wall.i1 == i-1 && wall.j1 == j);
  }

  bool isWallBottom(int i, int j, List<Wall> walls) {
    return walls.any((wall) => wall.i1 == i && wall.j1 == j && wall.i2 == i+1 && wall.j1 == j);
  }

  Maze() {
    init();
    cells.elementAt(startI).elementAt(startJ).visit();
  }
}