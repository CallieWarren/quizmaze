import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaze/game/ui/levelup/level_up_page.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../common/viewmodel/game_view_model.dart';
import '../model/maze_cell.dart';

class MazeView extends StatelessWidget {
  const MazeView({
    super.key,
    required this.mazeState
  });

  final GameViewModel mazeState;

  final double borderWhole = 8.0;
  final double borderHalf = 4.0;
  final double borderThin = 1.0;

  @override
  Widget build(BuildContext context) {
    Color filterColor = Colors.transparent;
    if(mazeState.swipesAvailable == 0) {
      filterColor = Colors.grey;
    }
    return ClipRect(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          filterColor,
          BlendMode.saturation,
        ),
        child:
        TableView.builder(
          cellBuilder: _buildCell,
          columnCount: mazeState.maze.maxRowColumnCount,
          columnBuilder: (index) => _rowBuildSpan(context, index),
          rowCount: mazeState.maze.maxRowColumnCount,
          rowBuilder: (index) => _columnBuildSpan(context, index),
        ),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    MazeCell currentCell = mazeState.maze.cells
        .elementAt(vicinity.row)
        .elementAt(vicinity.column);
    double leftBorder = borderThin;
    double rightBorder = borderThin;
    double bottomBorder = borderThin;
    double topBorder = borderThin;

    // if we have visited the cell or found exit and there is a wall on the left OR
    // if we have visited the cell to our left and there is a wall on the left
    if((currentCell.isWallLeft && (currentCell.isVisitedByPlayer || vicinity.column == 0 || mazeState.foundExit)) ||
        (vicinity.column > 0 && mazeState.maze.cells.elementAt(vicinity.row).elementAt(vicinity.column - 1).isVisitedByPlayer &&
            currentCell.isWallLeft)
    ) {
      leftBorder = borderHalf;
    }

    // if we have visited the cell or found exit and there is a wall on the right OR
    // if we have visited the cell to our right and there is a wall on the right
    if (currentCell.isWallRight && (currentCell.isVisitedByPlayer || vicinity.column == mazeState.maze.maxRowColumnCount - 1 || mazeState.foundExit)
        || vicinity.column < mazeState.maze.maxRowColumnCount - 1 && mazeState.maze.cells.elementAt(vicinity.row).elementAt(vicinity.column + 1).isVisitedByPlayer && currentCell.isWallRight
    ) {
      rightBorder = borderHalf;
    }

    // if we have visited the cell or found exit  and there is a wall on the top OR
    // if we have visited the cell above and there is a wall on bottom ??
    if(currentCell.isWallTop && (currentCell.isVisitedByPlayer || vicinity.row == 0 || mazeState.foundExit) ||
        vicinity.row > 0 && mazeState.maze.cells.elementAt(vicinity.row - 1).elementAt(vicinity.column).isVisitedByPlayer && currentCell.isWallTop
      ) {
      topBorder = borderHalf;
    }

    if (currentCell.isWallBottom && (currentCell.isVisitedByPlayer || vicinity.row == mazeState.maze.maxRowColumnCount - 1 || mazeState.foundExit) ||
        vicinity.row < mazeState.maze.maxRowColumnCount - 1 && mazeState.maze.cells.elementAt(vicinity.row + 1).elementAt(vicinity.column).isVisitedByPlayer && currentCell.isWallBottom) {
      bottomBorder = borderHalf;
    }

    Color cellBackground;
    AssetImage? cellMarker;

    if(mazeState.foundExit) {
      cellBackground = Color.fromARGB(200, 46, 196, 181);
      if(currentCell.isWallBottom && currentCell.isWallTop && currentCell.isWallRight && currentCell.isWallLeft) {
        cellBackground = Colors.black;
      }
      return TableViewCell(
        child: Consumer(
            builder: (context, ref, _) {
              return buildNonClickableMazeComponents(
                  vicinity,
                  cellBackground,
                  leftBorder,
                  rightBorder,
                  topBorder,
                  bottomBorder,
                  cellMarker);
            }
        ),
      );
    }


    if(vicinity.row == mazeState.currentI && vicinity.column == mazeState.currentJ) {
      if(mazeState.swipesAvailable == 0) {
        cellMarker = AssetImage('assets/person_shrugging_icon.png');
      } else {
        cellMarker = AssetImage('assets/person_icon.png');
      }
      cellBackground = Color.fromARGB(255, 255, 170, 90);
    } else if(currentCell.isVisitedByPlayer) {
      cellBackground = Color.fromARGB(200, 46, 196, 181);
    } else if(vicinity.row == mazeState.maze.exitI && vicinity.column == mazeState.maze.exitJ) {
      cellMarker = AssetImage('assets/treasure_icon.png');
      cellBackground = Color.fromARGB(255, 250,255,129);
    } else {
      cellBackground = Color.fromARGB(255, 255, 255, 230);
    }
    
    Widget cell;
    if(currentCell.isVisitedByPlayer && currentCell.isRevisitOption() && !(vicinity.row == mazeState.currentI && vicinity.column == mazeState.currentJ)) {
      cellMarker = AssetImage('assets/fork_icon.png');
      cell = buildClickableMazeCell(vicinity, cellBackground, leftBorder, rightBorder, topBorder, bottomBorder, cellMarker);
    } else {
      cell = buildNonClickableMazeComponents(vicinity, cellBackground, leftBorder, rightBorder, topBorder, bottomBorder, cellMarker);
    }

    return TableViewCell(
      child: Consumer(
        builder: (context, ref, _) {
            return cell;
          }
      ),
    );
  }

  Widget buildClickableMazeCell(TableVicinity vicinity, Color cellBackground,
      double leftBorder, double rightBorder, double topBorder,
      double bottomBorder, AssetImage? cellMarker) {
    return InkWell(
      onTap: () {
        mazeState.updateCurrent(vicinity.row, vicinity.column);
      },
        child: buildNonClickableMazeComponents(
            vicinity,
            cellBackground,
            leftBorder,
            rightBorder,
            topBorder,
            bottomBorder,
            cellMarker)
    );
  }

  Widget buildNonClickableMazeComponents(TableVicinity vicinity,
      Color cellBackground,
      double leftBorder, double rightBorder, double topBorder,
      double bottomBorder, AssetImage? cellMarker) {
    Widget imageOrNone = Container(color: Colors.transparent);
    if(cellMarker != null) {
      imageOrNone = Container(padding: EdgeInsets.all(4.0), child: Image(image: cellMarker));
    }
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
        child: imageOrNone,
      ),
    );
  }

  TableSpan _rowBuildSpan(BuildContext context, int index) {
    double leadingBorderWidth = borderThin;
    double trailingBorderWidth = borderThin;
    if (index == 0) {
      leadingBorderWidth = borderWhole;
    }
    if (index == mazeState.maze.maxRowColumnCount - 1) {
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
    if (index == mazeState.maze.maxRowColumnCount - 1) {
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
