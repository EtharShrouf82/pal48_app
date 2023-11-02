import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'input_decoration_theme.dart';
import 'theme_button.dart';
import 'theme_data.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: "DINN",
    primarySwatch: primaryMaterialColor,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: blackColor),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: blackColor40),
    ),
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonTheme(),
    textButtonTheme: textButtonThemeData,
    inputDecorationTheme: lightInputDecorationTheme,
    appBarTheme: appBarLightTheme,
    scrollbarTheme: scrollbarThemeData,
    dataTableTheme: dataTableLightThemeData,
  );
}
