import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData.light();

  ThemeData get darkTheme => ThemeData.dark();

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
