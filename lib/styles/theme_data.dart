import 'package:babysitterapp/styles/colors.dart';
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    // global colors around the app
    colorScheme: colorScheme,
    // font used by the app
    fontFamily: 'Poppins',
    // theme of text
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(color: textColor), // Adjusting the text color globally
      bodyMedium: TextStyle(color: textColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: primaryFgColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryFgColor,
        backgroundColor: primaryColor, // Button text color
      ),
    ),
    scaffoldBackgroundColor:
        backgroundColor, // Set the background color for the app
    iconTheme: const IconThemeData(
      color: accentColor, // Set the icon color
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: accentFgColor,
    ),
  );
}

ThemeClass themeClass = ThemeClass();
