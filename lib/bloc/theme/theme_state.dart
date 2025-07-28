import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeState {
  final AppTheme theme;

  ThemeState({this.theme = AppTheme.light});
  ThemeMode get themeMode => theme == AppTheme.light ? ThemeMode.light : ThemeMode.dark;

  ThemeState copyWith({AppTheme? theme}) {
    return ThemeState(theme: theme ?? this.theme);
  }
}