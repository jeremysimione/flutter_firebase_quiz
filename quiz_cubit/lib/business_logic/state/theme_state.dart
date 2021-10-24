import 'package:flutter/cupertino.dart';
import 'package:quiz_cubit/data/models/theme_model.dart';

@immutable
abstract class ThemeState {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeLoading extends ThemeState {
  const ThemeLoading();
}

class ThemeLoaded extends ThemeState {
  final ThemeModel thematiques;
  const ThemeLoaded(this.thematiques);
}

class ThemeError extends ThemeState {
  final String message;
  const ThemeError(this.message);
}

class ThemeModified extends ThemeState {
  const ThemeModified();
}
