import 'package:flutter/material.dart';
import 'package:nukegame/types/slot_state.dart';

class Palette {
  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;

  static const Color hidden = Colors.grey;
  static const Color empty = Colors.green;
  static const Color base = Colors.blue;
  static const Color destroyed = Colors.red;

  static Color bySlotState(SlotState state) {
    switch (state) {
      case SlotState.empty:
        return Palette.empty;
      case SlotState.base:
        return Palette.base;
      case SlotState.destroyed:
        return Palette.red;
    }
  }
}
