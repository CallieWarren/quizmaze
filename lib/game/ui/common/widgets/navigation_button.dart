import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../maze/widgets/maze_page.dart';

class NavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 64,
            margin: EdgeInsets.all(16),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MazePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Color.fromARGB(255, 255, 170, 90),
                ),
                shape:
                WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Text(
                'Maze',
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 48, 44),
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}