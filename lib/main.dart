import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:dawn/screens/screen_home_page/screen_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
     const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(useMaterial3: true),
      dark: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          appBarTheme:
              const AppBarTheme(backgroundColor: Color.fromARGB(255, 38, 0, 77)),
          drawerTheme: const DrawerThemeData(backgroundColor: Color.fromARGB(255, 38, 0, 77)),
          canvasColor: const Color.fromARGB(255, 51, 0, 102), 
          scaffoldBackgroundColor: const Color.fromARGB(255, 26, 0, 51),
      ),
          
      initial: AdaptiveThemeMode.dark,
      builder: (theme, dark) => MaterialApp(
        theme: theme,
        darkTheme: dark,
        home: const MyHomePage(),
      ),
    );
  }
}
