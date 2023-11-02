import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'input_decoration_theme.dart';
import 'theme_button.dart';
import 'theme_data.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: "DINN",
    primarySwatch: primaryMaterialColor,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: blackColor,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: blackColor60),
    ),
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonTheme(borderColor: whileColor20),
    textButtonTheme: textButtonThemeData,
    inputDecorationTheme: darkInputDecorationTheme,
    appBarTheme: appBarDarkTheme,
    scrollbarTheme: scrollbarThemeData,
    dataTableTheme: dataTableDarkThemeData,
  );
}
