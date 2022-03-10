// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AppTheme {
  ThemeData buildLightTheme() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ThemeData(
      //primaryColor: Colors.yellow,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: kYellow500,
        onPrimary: Colors.black,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Color(0xffb00020),
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(horizontal: 30),
        labelColor: Colors.black,
        indicator: RectangularIndicator(
          topLeftRadius: borderRad,
          topRightRadius: borderRad,
          bottomLeftRadius: borderRad,
          bottomRightRadius: borderRad,
          color: kYellow500,
          horizontalPadding: 10,
          verticalPadding: 5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRad),
        ),
      ),
    );
  }
}

var kGrey400 = Color(0xff9e9e9e);
var kYellow500 = Color(0xFFffeb3b);
var kYellowLight = Color(0xFFffff72);
