import 'package:flutter/material.dart';
import 'constants.dart';

/// Function to return a theme based on the provided color set.
themeColor(Map colorSet) {
  return ThemeData(
      // Main colour theme.
      scaffoldBackgroundColor: Colors.white,
      // Accessing respective colour of the theme with the same key.
      cardColor: colorSet["Card"],
      primaryColor: colorSet["Words"],
      primaryColorLight: colorSet["Light"],
      primaryColorDark: colorSet["Dark"],
      highlightColor: colorSet["Highlight"],
      shadowColor: colorSet["Shadow"],
      hintColor: allGrey,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? TextStyle(color: colorSet["Dark"])
            : TextStyle(color: Colors.black),
      )),
      // Dialog theme.
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
            fontSize: 69, fontWeight: FontWeight.w600, color: colorSet["Card"]),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
      ),

      // Button theme.
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: colorSet["Card"],
        elevation: 0,
        foregroundColor: Colors.white,
      )),

      // Progress bar theme.
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: colorSet["Darkest"]),

      // Checkbox theme.
      checkboxTheme: CheckboxThemeData(
          side: WidgetStateBorderSide.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return const BorderSide(width: 1.5, color: allGrey);
            }
            return null;
          }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorSet["Card"];
            }
            return null;
          })),

      // List tile theme.
      listTileTheme: const ListTileThemeData(
          tileColor: Colors.transparent,
          selectedTileColor: Colors.transparent));
}
