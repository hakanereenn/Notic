import 'package:flutter/material.dart';

class AppThemeConstant {
  static Color lBackgroundColor = Color(0xfff8f1f1);
  static Color lPrimaryColor = Color(0xfff6f5f5);
  static Color lAccentColor = Color(0xff276678);
  static Color lThirdColor = Color(0xffcdac81);
  static Color dPrimaryColor = Color(0xff393e46);
  static Color dAccentColor = Color(0xfffb743e);
  static Color dThirdColor = Color(0xff9fb8ad);
  static Color dBackgroundColor = Color(0xff222831);

  static TextStyle lightBody = TextStyle(
    fontSize: 18,
    color: dBackgroundColor,
    fontFamily: 'Open-Sans-Regular',
  );

  static TextStyle darkBody = TextStyle(
    color: lAccentColor,
    fontSize: 18,
    fontFamily: 'Open-Sans-Regular',
  );
  static TextStyle lightTitle = TextStyle(
    color: dBackgroundColor,
    fontFamily: 'Open-Sans',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static TextStyle lightTitle2 = TextStyle(
    color: lAccentColor,
    fontFamily: 'Open-Sans',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static TextStyle darkTitle = TextStyle(
    color: lAccentColor,
    fontFamily: 'Open-Sans',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static TextStyle darkTitle2 = TextStyle(
    color: lPrimaryColor,
    fontFamily: 'Open-Sans',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static final lightTheme = ThemeData(
    buttonTheme: ButtonThemeData(
      buttonColor: lBackgroundColor,
      disabledColor: lBackgroundColor,
    ),
    primaryColorLight: lThirdColor,
    backgroundColor: lBackgroundColor,
    primaryColor: lPrimaryColor,
    accentColor: lAccentColor,
    iconTheme: IconThemeData(color: lAccentColor),
    scaffoldBackgroundColor: lBackgroundColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),
    fontFamily: 'Open-Sans',
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: lightBody,
          headline1: lightTitle,
          headline2: lightTitle2,
        ),
  );
  static final darkTheme = ThemeData(
    backgroundColor: dBackgroundColor,
    primaryColor: dPrimaryColor,
    accentColor: dAccentColor,
    primaryColorLight: dThirdColor,
    iconTheme: IconThemeData(color: dThirdColor),
    scaffoldBackgroundColor: dBackgroundColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),
    fontFamily: 'Open-Sans',
    textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: darkBody,
          headline1: darkTitle,
          headline2: darkTitle2,
        ),
  );
}

class AppConstant {
  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const DE_LOCALE = Locale("de", "DE");
  static const AR_LOCALE = Locale("ar", "DZ");
  static const FR_LOCALE = Locale("fr", "FR");
  static const RU_LOCALE = Locale("ru", "RU");
  static const LANG_PATH = "assets/lang";
}
