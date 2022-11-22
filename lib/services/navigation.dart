import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:nukegame/screens/main_screen.dart';
import 'package:nukegame/services/initializer.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => getIt<Navigation>();

  static void pop<T>([T? result]) => get.routes.pop();

  static BuildContext context() => get.routes.key.currentContext!;

  static void mainScreen() => get.routes.pushReplacement(
        FadeRoute(
          MainScreen.instance(),
          name: 'main',
        ),
      );
}
