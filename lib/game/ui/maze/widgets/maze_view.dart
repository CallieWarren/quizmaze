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

    // todo and is visited check, for now just show all walls
    if(currentCell.isWallLeft) {
      leftBorder = borderHalf;
    }
    if (currentCell.isWallRight) {
      rightBorder = borderHalf;
    }

    if (currentCell.isWallBottom) {
      bottomBorder = borderHalf;
    }

    if(currentCell.isWallTop) {
      topBorder = borderHalf;
    }

    return TableViewCell(
      child: Consumer(
        builder: (context, ref, _) {
          if (vicinity.row == currentI && vicinity.column == currentJ) {
            return Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 129, 28),
                border: Border(
                  top: BorderSide(color: Colors.black, width: topBorder),
                  left: BorderSide(color: Colors.black, width: leftBorder),
                  right: BorderSide(color: Colors.black, width: rightBorder),
                  bottom: BorderSide(color: Colors.black, width: bottomBorder),
                ),
              ),
              child: Center(
                child: Text(
                  "x",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 230),
              border: Border(
                top: BorderSide(color: Colors.black, width: topBorder),
                left: BorderSide(color: Colors.black, width: leftBorder),
                right: BorderSide(color: Colors.black, width: rightBorder),
                bottom: BorderSide(color: Colors.black, width: bottomBorder),
              ),
            ),
          );
        },
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
