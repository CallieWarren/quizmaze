import 'package:flutter/material.dart';
import '../../maze/maze_page.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({required this.buttonText, required this.navDestination});

  final String buttonText;
  final Widget navDestination;

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
                  MaterialPageRoute(builder: (context) => navDestination),
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
                buttonText,
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