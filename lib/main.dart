import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:propakistani/globals/globals.dart';
import 'package:propakistani/providers/provider_news.dart';
import 'package:propakistani/screens/screen_home_page/screen_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/provider_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase
  await Firebase.initializeApp();

  //Firebase Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  //saving Theme mode to
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  //Force portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NewsProvider()),
    ChangeNotifierProvider(create: (_) => SharedPreferencesProvider())
  ], child: MyApp(savedThemeMode: savedThemeMode)));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    //Using AdaptiveTheme to set the theme mode
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kColorPrimary,
        ),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.blueGrey.shade50),
        scaffoldBackgroundColor: Colors.blueGrey.shade50,
        dialogBackgroundColor: Colors.white,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.black38),
          trackColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
        ),
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(backgroundColor: kColorPrimary),
        drawerTheme: const DrawerThemeData(backgroundColor: kColorSecondary),
        scaffoldBackgroundColor: kColorSecondary,
        dialogBackgroundColor: kColorSecondary,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(kColorSecondary),
          trackColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
        ),
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
