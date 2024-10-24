import 'package:app_12/data/trans.dart';
import 'package:flutter/material.dart';

// Manage the state of
class TopicSelectionNotifier extends ChangeNotifier {
  /// Stores the currently selected topic, initialized with the first topic in the list.
  String topic = trans[0].topic;

  /// Flag to track whether the menu is opened or not.
  bool menuOpened = false;

  // Updates the currently selected topic and notifies listeners to rebuild.
  setTopic(String t) {
    topic = t;
    notifyListeners();
  }

  // Toggles menuOpen variable and notify listener to rebuild (arrow in selection bar).
  ToggleMenu() {
    menuOpened = !menuOpened;
    notifyListeners();
  }
}
