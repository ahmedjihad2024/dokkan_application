import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themePrefKey = 'app_theme_mode';

  ThemeCubit() : super(ThemeMode.dark) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark =
          prefs.getBool(_themePrefKey) ?? true; // Default to dark (#0D1117)
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } catch (_) {
      emit(ThemeMode.dark);
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newMode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themePrefKey, newMode == ThemeMode.dark);
    } catch (_) {}
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themePrefKey, mode == ThemeMode.dark);
    } catch (_) {}
  }

  bool get isDarkMode => state == ThemeMode.dark;
}
