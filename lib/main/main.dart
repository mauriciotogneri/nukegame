import 'package:flutter/material.dart';
import 'package:nukegame/app/nuke_game.dart';
import 'package:nukegame/services/initializer.dart';

void main() async {
  await Initializer.load();
  runApp(const NukeGameApp());
}
