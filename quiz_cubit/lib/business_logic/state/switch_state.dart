import 'package:flutter/material.dart';

class SwitchState {
  final bool isDarkThemeOn;
  late ThemeData theme;
  SwitchState({required this.isDarkThemeOn}) {
    if (isDarkThemeOn) {
      theme = ThemeData.dark();
    } else {
      theme = ThemeData.light();
    }
  }

  SwitchState copyWith({required bool changeState}) {
    return SwitchState(isDarkThemeOn: changeState);
  }
}
