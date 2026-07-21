import 'package:flutter/material.dart';

class SettingViewModel extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme()async {

    _isDarkMode = true;
    notifyListeners();

  }

}