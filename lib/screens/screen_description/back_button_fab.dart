import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../globals/globals.dart';

class BackButtonFab extends StatelessWidget {
  const BackButtonFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light) ? Colors.grey.withOpacity(0.8) : Colors.black.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 9,
            offset:
                const Offset(0, 0), // changes the position of the shadow
          ),
        ],
        shape: BoxShape.circle,
      ),
      
      child: SpeedDial(
        shape: const CircleBorder(),
        foregroundColor: Colors.white,
        backgroundColor:
            (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                ? kColorSecondary
                : Colors.black,
        onPress: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
