import 'package:flutter/material.dart';
import 'package:habbit_sphere/theme/dark_mode.dart';
import 'package:habbit_sphere/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

 ThemeData get themeData => _themeData;

 bool get isDarkMode => _themeData == darkMode;

 // set theme 
  set themedata(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  } 

  // toggle theme 
  void toggleTheme(){
    if (_themeData == lightMode) {
      themedata = darkMode;
    } else {
      themedata = lightMode;
    }
  }
}