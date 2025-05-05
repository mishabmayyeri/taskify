import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { light, dark, system }

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._prefs) : super(_loadThemeMode(_prefs));

  static ThemeMode _loadThemeMode(SharedPreferences prefs) {
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    return ThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeModeOption option) async {
    ThemeMode themeMode;
    switch (option) {
      case ThemeModeOption.light:
        themeMode = ThemeMode.light;
        break;
      case ThemeModeOption.dark:
        themeMode = ThemeMode.dark;
        break;
      case ThemeModeOption.system:
        themeMode = ThemeMode.system;
        break;
    }
    await _prefs.setInt(_themeKey, themeMode.index);
    emit(themeMode);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      setThemeMode(ThemeModeOption.dark);
    } else {
      setThemeMode(ThemeModeOption.light);
    }
  }
}
