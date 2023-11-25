import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:dawn/screens/screen_home_page/screen_home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(useMaterial3: true),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(255, 38, 0, 77)),
        drawerTheme: const DrawerThemeData(
            backgroundColor: Color.fromARGB(255, 38, 0, 77)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 13, 0, 26),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, dark) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: dark,
        themeAnimationDuration: const Duration(milliseconds: 500),
        home: const MyHomePage(),
      ),
    );
  }
}
