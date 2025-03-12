import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';


import '../model/maze.dart';
import '../model/maze_cell.dart';

class MazeView extends StatelessWidget {
  const MazeView({super.key, required this.maze, required this.currentX, required this.currentY, required this.exit});
  final Maze maze;
  final int currentX;
  final int currentY;
  final Point exit;
  final double borderThick = 7.0;
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

    MazeCell currentCell = maze.cells.elementAt(vicinity.row).elementAt(vicinity.column);
    double leftBorder =  borderThin;
    double rightBorder = borderThin;
    double topBorder = borderThin;
    double bottomBorder = borderThin;

    // todo and is visited check, for now just show all walls
    if(currentCell.isWallRight) {
      rightBorder = borderThick;
    }

    if(currentCell.isWallBottom) {
      bottomBorder = borderThick;
    }

    return TableViewCell(
      child: Consumer(
        builder: (context, ref, _) {
          if (vicinity.column == currentX && vicinity.row == currentY) {
            return Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 129, 28),
                    border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: leftBorder
                    ),
                    right: BorderSide(
                      color: Colors.black,
                      width: rightBorder
                    ),
                    top: BorderSide(
                      color: Colors.black,
                      width: topBorder
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: bottomBorder
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    "x",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black
                    ),
                  ),
                ),
            );
          }

          return Container(
            decoration: BoxDecoration(
                color:  Color.fromARGB(255, 255, 255, 230),
                border: Border(
                    left: BorderSide(
                        color: Colors.black,
                        width: leftBorder
                    ),
                    right: BorderSide(
                        color: Colors.black,
                        width: rightBorder
                    ),
                    top: BorderSide(
                        color: Colors.black,
                        width: topBorder
                    ),
                    bottom: BorderSide(
                        color: Colors.black,
                        width: bottomBorder
                    )
                )
            ),
          );
        },
      ),
    );
  }

  TableSpan _rowBuildSpan(BuildContext context, int index) {
    double leadingBorderWidth = borderThin;
    double trailingBorderWidth = borderThin;
    if(index == 0) {
      leadingBorderWidth = borderThick;
    }
    if(index == maze.maxRowColumnCount -1) {
      trailingBorderWidth = borderThick;
    }
    return TableSpan(
      extent: FixedTableSpanExtent(75),
      foregroundDecoration: TableSpanDecoration(
        border: TableSpanBorder(
          leading: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: leadingBorderWidth
          ),
          trailing: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: trailingBorderWidth
          ),
        )
      ),
    );
  }

  TableSpan _columnBuildSpan(BuildContext context, int index) {
    double leadingBorderWidth = borderThin;
    double trailingBorderWidth = borderThin;
    if(index == 0) {
      leadingBorderWidth = borderThick;
    }
    if(index == maze.maxRowColumnCount -1) {
      trailingBorderWidth = borderThick;
    }
    return TableSpan(
      extent: FixedTableSpanExtent(75),
      foregroundDecoration: TableSpanDecoration(
        border: TableSpanBorder(
          leading: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: leadingBorderWidth
          ),
          trailing: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: trailingBorderWidth
          ),
        ),
      ),
    );
  }
}