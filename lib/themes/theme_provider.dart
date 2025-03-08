import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jay_chat_zone/themes/dark_mode.dart';
import 'package:jay_chat_zone/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if(_themeData == lightmode){
      themeData = darkMode;
    }else{
      themeData = lightmode;
    }
  }
}