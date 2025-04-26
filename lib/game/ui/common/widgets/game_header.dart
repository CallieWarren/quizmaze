import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings/widgets/settings_page.dart';
import '../viewmodel/game_view_model.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GameViewModel>();
    String swipesText = 'Swipes Available\n${appState.swipesAvailable}';
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      color: Color.fromARGB(255, 7, 7, 7),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  appState.category,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                child: Image(image: AssetImage('assets/settings_icon.png')),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  swipesText,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  'Items Reviewed\n${appState.total}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
