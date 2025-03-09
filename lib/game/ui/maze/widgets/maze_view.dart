import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';


import '../model/maze.dart';

class MazeView extends StatelessWidget {
  const MazeView({super.key, required this.maze});
  final Maze maze;

  @override
  Widget build(BuildContext context) {

    return TableView.builder(
      cellBuilder: _buildCell,
      columnCount: maze.maxRowColumnCount,
      columnBuilder: (index) => _buildSpan(context, index),
      rowCount: maze.maxRowColumnCount,
      rowBuilder: (index) => _buildSpan(context, index),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    // final location = Location.at(vicinity.column, vicinity.row);

    return TableViewCell(
      child: Consumer(
        builder: (context, ref, _) {
          // final character = ref.watch(
          //   crosswordProvider.select(
          //         (crosswordAsync) => crosswordAsync.when(
          //       data: (crossword) => crossword.characters[location],
          //       error: (error, stackTrace) => null,
          //       loading: () => null,
          //     ),
          //   ),
          // );
          //
          // if (character != null) {
          //   return Container(
          //     color: Theme.of(context).colorScheme.onPrimary,
          //     child: Center(
          //       child: Text(
          //         character.character,
          //         style: TextStyle(
          //           fontSize: 24,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //     ),
          //   );
          // }

          return ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
          );
        },
      ),
    );
  }

  TableSpan _buildSpan(BuildContext context, int index) {
    return TableSpan(
      extent: FixedTableSpanExtent(75),
      foregroundDecoration: TableSpanDecoration(
        border: TableSpanBorder(
          leading: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
          trailing: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
    );
  }

}