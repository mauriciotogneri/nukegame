import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:nukegame/screens/lobby_screen.dart';
import 'package:nukegame/screens/match_screen.dart';
import 'package:nukegame/services/initializer.dart';

class Navigation {
  final Routes routes = Routes();

  static Navigation get get => getIt<Navigation>();

  static void pop<T>([T? result]) => get.routes.pop();

  static BuildContext context() => get.routes.key.currentContext!;

  static void lobbyScreen() => get.routes.pushReplacement(
        FadeRoute(
          LobbyScreen.instance(),
          name: 'lobby',
        ),
      );

  static void matchScreen(DocumentReference matchDocRef) => get.routes.pushReplacement(
        FadeRoute(
          MatchScreen.instance(matchDocRef),
          name: 'match',
        ),
      );
}
