import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.light(
    primaryContainer: Colors.grey[300],
    secondaryContainer: Colors.white
  ),
);
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.dark(
    primaryContainer: Colors.grey[800],
    secondaryContainer: Colors.grey[900]
  ),
);