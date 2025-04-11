import 'package:flutter/material.dart';

import '../viewmodel/model/destination.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({required this.buttonText, required this.fromDestination, required this.toDestination, required this.toDestinationWidget});

  final String buttonText;
  final Destination fromDestination;
  final Destination toDestination;
  final Widget toDestinationWidget;

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
                if(fromDestination == Destination.maze) {
                  if(toDestination == Destination.quiz) {
                    Navigator.of(context).pop();
                  } else if(toDestination == Destination.levelUp) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => toDestinationWidget),
                    );
                  }
                } else if (fromDestination == Destination.quiz) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => toDestinationWidget),
                  );
                } else if (fromDestination == Destination.levelUp) {
                  Navigator.of(context).pop();
                }
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