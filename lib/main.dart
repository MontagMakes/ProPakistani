import 'package:dawn/screens/screen_home_page/screen_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primaryColor: Colors.red,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 38, 0, 77)),
        drawerTheme: DrawerThemeData(backgroundColor: Color.fromARGB(255, 38, 0, 77)),
        canvasColor: Color.fromARGB(255, 13, 0, 26)
        
        
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}
