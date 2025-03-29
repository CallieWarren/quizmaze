import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../model/maze.dart';
import '../model/maze_cell.dart';

class MazeView extends StatelessWidget {
  const MazeView({
    super.key,
    required this.maze,
    required this.currentI,
    required this.currentJ,
    required this.exitI,
    required this.exitJ
  });

  final Maze maze;
  final int currentI;
  final int currentJ;
  final int exitI;
  final int exitJ;
  final double borderWhole = 8.0;
  final double borderHalf = 4.0;
  final double borderThin = 1.0;

  @override
  Widget build(BuildContext context) {
    return TableView.builder(
      cellBuilder: _buildCell,
      columnCount: maze.maxRowColumnCount,
      columnBuilder: (index) => _rowBuildSpan(context, index),
      rowCount: maze.maxRowColumnCount,
      rowBuilder: (index) => _columnBuildSpan(context, index),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    MazeCell currentCell = maze.cells
        .elementAt(vicinity.row)
        .elementAt(vicinity.column);
    double leftBorder = borderThin;
    double rightBorder = borderThin;
    double bottomBorder = borderThin;
    double topBorder = borderThin;

    // if we have visited the cell and there is a wall on the left OR
    // if we have visited the cell to our left and there is a wall on the left
    if((currentCell.isWallLeft && (currentCell.isVisited || vicinity.column == 0)) ||
        (vicinity.column > 0 && maze.cells.elementAt(vicinity.row).elementAt(vicinity.column - 1).isVisited &&
            currentCell.isWallLeft)
    ) {
      leftBorder = borderHalf;
    }

    // if we have visited the cell and there is a wall on the right OR
    // if we have visited the cell to our right and there is a wall on the right
    if (currentCell.isWallRight && (currentCell.isVisited || vicinity.column == maze.maxRowColumnCount - 1)
        || vicinity.column < maze.maxRowColumnCount - 1 && maze.cells.elementAt(vicinity.row).elementAt(vicinity.column + 1).isVisited && currentCell.isWallRight
    ) {
      rightBorder = borderHalf;
    }

    // if we have visited the cell and there is a wall on the top OR
    // if we have visited the cell above and there is a wall on bottom ??
    if(currentCell.isWallTop && (currentCell.isVisited || vicinity.row == 0) ||
        vicinity.row > 0 && maze.cells.elementAt(vicinity.row - 1).elementAt(vicinity.column).isVisited && currentCell.isWallTop
      ) {
      topBorder = borderHalf;
    }

    if (currentCell.isWallBottom && (currentCell.isVisited || vicinity.row == maze.maxRowColumnCount - 1) ||
        vicinity.row < maze.maxRowColumnCount - 1 && maze.cells.elementAt(vicinity.row + 1).elementAt(vicinity.column).isVisited && currentCell.isWallBottom) {
      bottomBorder = borderHalf;
    }

    String cellMarker = "";
    Color cellBackground;
    if(vicinity.row == currentI && vicinity.column == currentJ) {
      cellMarker = "x";
      cellBackground = Color.fromARGB(255, 255, 129, 28);
    } else if(currentCell.isVisited) {
      cellBackground = Color.fromARGB(200, 46, 196, 181);
    } else {
      cellBackground = Color.fromARGB(255, 255, 255, 230);
    }

    return TableViewCell(
      child: Consumer(
        builder: (context, ref, _) {
            return Container(
              decoration: BoxDecoration(
                color: cellBackground,
                border: Border(
                  top: BorderSide(color: Colors.black, width: topBorder),
                  left: BorderSide(color: Colors.black, width: leftBorder),
                  right: BorderSide(color: Colors.black, width: rightBorder),
                  bottom: BorderSide(color: Colors.black, width: bottomBorder),
                ),
              ),
              child: Center(
                child: Text(
                  cellMarker,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            );
          }
      ),
    );
  }

  TableSpan _rowBuildSpan(BuildContext context, int index) {
    double leadingBorderWidth = borderThin;
    double trailingBorderWidth = borderThin;
    if (index == 0) {
      leadingBorderWidth = borderWhole;
    }
    if (index == maze.maxRowColumnCount - 1) {
      trailingBorderWidth = borderWhole;
    }
    return TableSpan(
      extent: FixedTableSpanExtent(75),
      foregroundDecoration: TableSpanDecoration(
        border: TableSpanBorder(
          leading: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: leadingBorderWidth,
          ),
          trailing: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: trailingBorderWidth,
          ),
        ),
      ),
    );
  }

  TableSpan _columnBuildSpan(BuildContext context, int index) {
    double leadingBorderWidth = borderThin;
    double trailingBorderWidth = borderThin;
    if (index == 0) {
      leadingBorderWidth = borderWhole;
    }
    if (index == maze.maxRowColumnCount - 1) {
      trailingBorderWidth = borderWhole;
    }
    return TableSpan(
      extent: FixedTableSpanExtent(75),
      foregroundDecoration: TableSpanDecoration(
        border: TableSpanBorder(
          leading: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: leadingBorderWidth,
          ),
          trailing: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: trailingBorderWidth,
          ),
        ),
      ),
    );
  }
}
