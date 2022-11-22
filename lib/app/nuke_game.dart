import 'package:flutter/material.dart';
import 'package:nukegame/screens/splash_screen.dart';
import 'package:nukegame/services/navigation.dart';
import 'package:nukegame/services/palette.dart';

class NukeGameApp extends StatelessWidget {
  const NukeGameApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuke Game',
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.get.routes.key,
      theme: ThemeData(
        primarySwatch: Palette.primary,
        backgroundColor: Palette.white,
        scaffoldBackgroundColor: Palette.white,
      ),
      home: SplashScreen.instance(),
    );
  }
}
