import 'package:flutter/material.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  primaryColor: Colors.grey[200],
  scaffoldBackgroundColor: Colors.grey[200],
  dividerColor: Colors.grey[400],
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
      backgroundColor: WidgetStateProperty.all(Colors.cyan),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[200],
    selectedItemColor: Colors.cyan,
    unselectedItemColor: Colors.grey[400],
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.grey[200],
    indicatorColor: Colors.transparent,
    selectedIconTheme: IconThemeData(color: Colors.cyan),
    selectedLabelTextStyle: TextStyle(color: Colors.cyan),
    unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[200],
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  colorScheme: ColorScheme.light(
      primaryContainer: Colors.grey[300], secondaryContainer: Colors.white),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  primaryColor: Colors.grey[850],
  scaffoldBackgroundColor: Colors.grey[850],
  dividerColor: Colors.grey[700],
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.white),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.white),
      backgroundColor: WidgetStateProperty.all(Colors.cyan[400]),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[850],
    selectedItemColor: Colors.cyan[400],
    unselectedItemColor: Colors.grey[400],
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.grey[850],
    indicatorColor: Colors.transparent,
    selectedIconTheme: IconThemeData(color: Colors.cyan[400]),
    selectedLabelTextStyle: TextStyle(color: Colors.cyan[400]),
    unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
      primaryContainer: Colors.grey[800], secondaryContainer: Colors.grey[900]),
);
