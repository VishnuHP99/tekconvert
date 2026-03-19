import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {

  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("theme_mode") ?? "system";

    switch (saved) {
      case "dark":
        _mode = ThemeMode.dark;
        break;
      case "light":
        _mode = ThemeMode.light;
        break;
      default:
        _mode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    _mode = mode;

    if (mode == ThemeMode.dark) {
      await prefs.setString("theme_mode", "dark");
    } else if (mode == ThemeMode.system) {
      await prefs.setString("theme_mode", "system");
    } else {
      await prefs.setString("theme_mode", "light");
    }

    notifyListeners();
  }
}