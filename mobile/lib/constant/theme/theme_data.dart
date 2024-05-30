import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moonlyt/constant/theme/container_pallette.dart';
import 'package:moonlyt/constant/theme/text_palette.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: BasePalette.mainColor,
        statusBarColor: BasePalette.mainColor,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: TextPalette.mainColor,
      selectionHandleColor: TextPalette.mainColor,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: TextPalette.mainColor,
      contentTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: BasePalette.mainColor,
    fontFamily: 'Satoshi',
    unselectedWidgetColor: BasePalette.mainColor,
    // textTheme: getTextTheme(),
  );
}
