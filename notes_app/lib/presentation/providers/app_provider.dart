import 'package:flutter/material.dart';
import 'package:notes_app/presentation/widgets/AppConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkTheme();
  }
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  ThemeData theme = AppThemeConstant.lightTheme;

  void setTheme(value, c) async {
    theme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', c);
    notifyListeners();
  }

  ThemeData getTheme(value) => theme;
  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData _theme;
    String a = prefs.getString('theme') ?? 'light';
    if (a == 'light') {
      _theme = AppThemeConstant.lightTheme;
      setTheme(AppThemeConstant.lightTheme, 'light');
    } else {
      _theme = AppThemeConstant.darkTheme;
      setTheme(AppThemeConstant.darkTheme, 'dark');
    }
    return _theme;
  }
}
