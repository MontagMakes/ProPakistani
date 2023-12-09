import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleDrawer extends StatelessWidget {
  const TitleDrawer({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.21,
        ),
        Positioned(
          child: Text(
            "TRIBUNE",
            style: GoogleFonts.playfair(
                fontSize: MediaQuery.of(context).size.width * 0.15,
                fontWeight: FontWeight.normal,
                color: isDarkMode ? Colors.white : Colors.black),
          ),
        ),
        Positioned(
          top: 10,
          right: 7,
          child: Text(
            "THE EXPRESS",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                color: isDarkMode
                    ? Colors.red
                    : Colors.redAccent.shade700),
          ),
        )
      ]),
    );
  }
}
