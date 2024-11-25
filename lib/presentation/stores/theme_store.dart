import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  static const String _themePrefKey = "themeMode";

  @observable
  ThemeMode themeMode = ThemeMode.light; // Default theme is Light Mode

  // Public method to initialize the theme
  Future<void> initializeTheme() async {
    await _loadTheme();
  }

  @action
  Future<void> toggleTheme(ThemeMode newTheme) async {
    themeMode = newTheme;
    print("Theme mode changed to: $newTheme"); // Debug print
    await _saveTheme(newTheme); // Save the selected theme
  }

  // Private method to load the saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themePrefKey);
    if (savedTheme == "dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  // Save the selected theme to SharedPreferences
  Future<void> _saveTheme(ThemeMode newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePrefKey, newTheme == ThemeMode.dark ? "dark" : "light");
  }
}
