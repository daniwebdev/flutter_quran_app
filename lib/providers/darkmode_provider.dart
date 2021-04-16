

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ThemeMode _mode;

  ThemeMode get mode => _mode;

  void getCurrentMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeMode = prefs.getString('themeMode');

    if(themeMode == 'light') {
      this.setMode(ThemeMode.light);
    } else if(themeMode == 'dark') {
      this.setMode(ThemeMode.dark);
    } else {
      this.setMode(ThemeMode.system);
    }
  }

  void setMode(ThemeMode mode) {
    this._mode = mode;

    notifyListeners();
  }
}