// This file contains the constant that will be used across the app.
import 'package:flutter/material.dart';

// Below is the colour palette for the app.
// Map of colors passes to the themeColor function for custom theming.
// Colours can be access by the same key on different maps.

// GLOBAL
const Color allGrey = Color.fromARGB(255, 210, 210, 210);

// BLUE THEME
const Map<String, Color> blueTheme = {
  "Darkest": Color.fromARGB(255, 2, 48, 71),
  "Card": Color.fromARGB(255, 125, 161, 196),
  "Light": Color.fromARGB(255, 198, 214, 227),
  "Dark": Color.fromARGB(255, 35, 97, 146),
  "Shadow": Color.fromARGB(255, 89, 123, 156),
  "Highlight": Color.fromARGB(255, 170, 205, 240),
  "Words": Color.fromARGB(255, 198, 214, 227),
};

// GREEN THEME
const Map<String, Color> greenTheme = {
  "Darkest": Color.fromARGB(255, 2, 48, 51),
  "Card": Color.fromARGB(255, 125, 161, 156),
  "Light": Color.fromARGB(255, 198, 214, 207),
  "Dark": Color.fromARGB(255, 35, 97, 86),
  "Shadow": Color.fromARGB(255, 89, 123, 116),
  "Highlight": Color.fromARGB(255, 170, 205, 200),
  "Words": Color.fromARGB(255, 198, 214, 187),
};

// Animation constants
const int aSlideAwayDuration = 400;
