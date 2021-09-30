import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  /* AppProvider() {
    checkTheme();
  }

 
  ThemeData _theme;

  bool get isDark => _theme == AppThemeConstant.lightTheme;

  void setTheme(value, c) async {
    _theme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', c);
    notifyListeners();
  }

  ThemeData get theme => _theme;

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData _theme;

    ThemeMode themeMode = ThemeMode.system;
    String t = themeMode == ThemeMode.light ? 'light' : 'dark';
    String a = prefs.getString('theme') ?? t;
    if (a == 'light') {
      _theme = AppThemeConstant.lightTheme;
      setTheme(AppThemeConstant.lightTheme, 'light');
    } else {
      _theme = AppThemeConstant.darkTheme;
      setTheme(AppThemeConstant.darkTheme, 'dark');
    }
    return _theme;
  } */
  final String _themeKey = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool get darkTheme => _darkTheme;
  AppProvider() {
    _darkTheme = true;
    _loadFromPrefs();
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(_themeKey, _darkTheme);
  }
}
