import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../globals/globals.dart';

class BackButtonFab extends StatelessWidget {
  final bool isDrawerOpen;
  const BackButtonFab({
    super.key, required this.isDrawerOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          if (!isDrawerOpen)
            kFabShadow
        ],
        shape: BoxShape.circle,
      ),
      child: SpeedDial(
        shape: const CircleBorder(),
        icon: Icons.arrow_back,
        
        iconTheme: IconThemeData(
          color: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light)
              ? Colors.black
              : Colors.white,
        ),

        backgroundColor:
            (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                ? Colors.black
                : Colors.white,
        onPress: () => Navigator.pop(context),
        
      ),
    );
  }
}
